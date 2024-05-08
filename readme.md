# Docker Compose template to bootstrap new Odoo deployment

## 1 - Clone the repository

## 2 - set the PGsql password

```bash
cd odoo-bootstrap
cp odoo_pg_pass.example odoo_pg_pass
```
and then, edit `odoo_pg_pass` to set your own pg user password

## 2 - Build and run

```bash
docker compose up
```
