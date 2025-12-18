# Rayzon CRM – Procure-to-Pay (P2P) & Quote-to-Cash (Q2C)
## Business Understanding → Fulfillment Model → Technical Requirements

---

## 1. Purpose of This Document

This document explains:
- How **P2P and Q2C work in the real world**
- How customer fulfillment happens **without customer using the CRM**
- How business processes are translated into **clear technical requirements**
- Scope boundaries to avoid over-engineering and ERP creep

This is intended for **business stakeholders, IT leadership, and implementation teams**.

---

## 2. High-Level Business Objective

The objective is to enhance the existing **Rayzon CRM** by integrating:

- **Quote-to-Cash (Q2C)**: Sales → Invoice → Payment
- **Procure-to-Pay (P2P)**: Purchase Request → PO → Vendor Invoice → Payment

### Key outcome:
> A single, integrated internal system that coordinates Sales, Procurement, and Finance — without replacing Rayzon CRM or exposing the system to customers.

---

## 3. Real-World Process (Before Systems)

### Quote-to-Cash (Q2C) – Human Process
1. Customer requests a quote  
2. Sales prepares pricing  
3. Manager approves discount  
4. Quote sent to customer  
5. Customer accepts  
6. Invoice raised  
7. Customer pays  

### Procure-to-Pay (P2P) – Human Process
1. Sales confirms demand  
2. Procurement identifies vendor  
3. Approval taken  
4. Purchase Order issued  
5. Vendor delivers  
6. Vendor invoice verified  
7. Payment released  

### Core reality:
> Sales creates demand.  
> Procurement fulfills demand.  
> Finance manages money.

---

## 4. System Model (What the Software Does)

The system **orchestrates workflows**.  
People execute actions.  
Customers receive documents and deliveries.

---

## 5. Customer Usage Model (IMPORTANT)

### Customers do NOT log into Rayzon CRM.

This implementation is **internal-facing only**.

### Customer interactions happen via:
- Email (quotes, invoices, order confirmations)
- PDF documents
- Physical delivery / service execution
- Payment links or bank transfer

### Out of Scope (Phase 1):
- Customer portal
- Customer login
- Self-service ordering

> Architecture will remain future-ready for optional customer portal if required later.

---

## 6. How Customer Fulfillment Happens (Without App Access)

### Step 1: Quotation
**Customer sees**
- Quote PDF / Email

**System**
- Quote created
- Pricing rules applied
- Approval workflow completed

---

### Step 2: Order Confirmation
**Customer sees**
- Order confirmation email
- Expected delivery timeline

**System**
- Quote converted to Sales Order
- Order status = Confirmed

---

### Step 3: Procurement (Internal Only)
**Customer sees**
- Nothing

**System**
- Purchase Requisition auto-created
- Procurement approval
- PO issued to vendor

---

### Step 4: Delivery / Service
**Customer sees**
- Goods delivered or service completed
- Delivery challan / completion confirmation

**System**
- Goods receipt or service completion recorded
- Sales Order marked as Fulfilled

---

### Step 5: Invoicing
**Customer sees**
- Invoice PDF
- Payment instructions / link

**System**
- Invoice generated from Sales Order
- Tax applied
- Invoice status updated

---

### Step 6: Payment
**Customer sees**
- Payment receipt

**System**
- Payment recorded
- Invoice marked Paid
- Sales Order closed

---

## 7. System Architecture (Conceptual)

### Core Principle
> Rayzon CRM remains the system of record.

### Logical Components
- Rayzon CRM (UI + master data)
- Q2C Workflow Layer
- P2P Workflow Layer
- Integration & Control Layer (APIs, approvals, audit logs)

### Key Design Choices
- API-driven
- Loosely coupled
- Configuration over customization
- Modular and phase-based

---

## 8. Core Business Objects

### Q2C Objects
- Lead
- Opportunity
- Quote
- Sales Order
- Invoice
- Payment

### P2P Objects
- Purchase Requisition
- Purchase Order
- Vendor Invoice
- Payment

### Master Data
- Customer
- Vendor
- Item / Service
- Tax
- Price List

---

## 9. Status-Driven Workflow Model

### Example: Sales Order Lifecycle

Each status:
- Controls allowed actions
- Triggers workflows
- Enables reporting

---

## 10. Translating Business Flow into Technical Requirements

### Standard Requirement Format
> **When [business event] occurs, the system shall [action] so that [business outcome] is achieved.**

---

### Sample Technical Requirements

1. When a quote is approved, the system shall generate and email a customer-facing quote document.
2. When a quote is accepted, the system shall convert it into a Sales Order.
3. When a Sales Order is confirmed, the system shall automatically create a Purchase Requisition for required items.
4. The system shall link Purchase Requisitions and Purchase Orders to the originating Sales Order.
5. When goods or services are delivered, the system shall allow marking the Sales Order as fulfilled.
6. When a Sales Order is fulfilled, the system shall generate an invoice and send it to the customer.
7. When payment is received, the system shall update invoice and order status and notify internal stakeholders.

---

## 11. Scope Boundaries (To Avoid ERP Creep)

### In Scope
- Q2C workflows
- P2P workflows
- Internal approvals
- Invoicing & payment tracking
- Reporting & audit trails

### Explicitly Out of Scope (Phase 1)
- Customer portal
- Inventory optimization
- HR / Payroll
- Full ERP replacement
- Complex accounting ledgers

---

## 12. Key Success Principles

- Deliver MVP first
- Lock scope per phase
- Avoid speculative features
- Focus on business-critical flows
- Support via AMC post go-live

---

## 13. One-Line Positioning Statement

> **This initiative provides ERP-grade process control using a CRM-centric, cost-effective, and fast-to-deploy architecture.**

---

## 14. Final Mental Model

> **People → Process → Event → Data → Workflow → Status → Report**

If it fits this chain, it can be built.
