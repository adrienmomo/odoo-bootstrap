#!/bin/bash

# Help message function
show_help() {
    echo "Usage: $0 --output_port <port> --sitename <name> [--db_password <password>]"
    echo "Options:"
    echo "  -h                        Show this help message"
    echo "  --output_port <port>      Port to use for output (replaces <output_port> in docker-compose.yml)"
    echo "  --sitename <name>         Site name (replaces <sitename> in docker-compose.yml)"
    echo "  --db_password <password>  Database password (optional, overrides odoo_pg_pass file content)"
}

# Initialize variables
OUTPUT_PORT=""
SITENAME=""
DB_PASSWORD=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        --output_port)
            OUTPUT_PORT="$2"
            shift 2
            ;;
        --sitename)
            SITENAME="$2"
            shift 2
            ;;
        --db_password)
            DB_PASSWORD="$2"
            shift 2
            ;;
        *)
            echo "Error: Unknown argument: $1"
            show_help
            exit 1
            ;;
    esac
done

# Check for required arguments
if [[ -z "$OUTPUT_PORT" || -z "$SITENAME" ]]; then
    echo "Error: Missing required arguments."
    show_help
    exit 1
fi

# Copy docker-compose.example to docker-compose.yml
cp docker-compose.example docker-compose.yml

# Replace placeholders in docker-compose.yml
sed -i '' "s/<output_port>/$OUTPUT_PORT/g" docker-compose.yml
sed -i '' "s/<sitename>/$SITENAME/g" docker-compose.yml

# Copy odoo_pg_pass.example to odoo_pg_pass
cp odoo_pg_pass.example odoo_pg_pass

# Override password if provided
if [[ -n "$DB_PASSWORD" ]]; then
    echo "$DB_PASSWORD" > odoo_pg_pass
fi

echo "Bootstrap complete."
