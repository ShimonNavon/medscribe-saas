# HandClinic AI · מקליט ביקורים למרפאות (SaaS Platform)

Interactive SaaS platform, live clinic visit simulator, and source-backed Archify architecture diagrams for **Meeting Recorder (`מקליט ביקורים`)**.

## Live Domains (`handclinic.co.il`)

| URL | Target | Description |
| --- | --- | --- |
| https://handclinic.co.il/ | `medscribe-saas` (`:30095`) | Main SaaS Platform + Interactive Visit Simulator |
| https://arch.handclinic.co.il/ | `medscribe-saas` (`:30095`) | Interactive Voice Agent Architecture (Archify) |
| https://app.handclinic.co.il/ | `meeting-recorder-prod` (`:30085`) | Live Production Clinic Recorder |
| https://test.handclinic.co.il/ | `meeting-recorder-test` (`:30084`) | Staging & Automated Voice QA Instance |
| https://beta.handclinic.co.il/ | `meeting-recorder-whatsapp` (`:30089`) | WhatsApp Delivery Beta |
| https://yaffa-david.handclinic.co.il/ | `handclinic` (`:30094`) | Dr. Yaffa David — Hand Surgery Clinic Website |

## Deployment & CI/CD

- **Cluster:** Kubernetes (`ubuntu03` control-plane, `ubuntu04` worker)
- **Namespace:** `medscribe-saas` (`NodePort 30095`)
- **Edge & TLS:** Cloudflare Tunnel (`ubuntu02`) → `http://ubuntu03:30095`
- **CI/CD:** `.github/workflows/ci.yml` validates HTML/scripts and rolls out the gzipped ConfigMap + Deployment to the cluster.

## Manual Deploy

```bash
./deploy/deploy.sh
```
