Return-Path: <cyrus@holtmann.org>
Message-ID: <4D6CFF69.1020503@csr.com>
Date: Tue, 01 Mar 2011 14:15:05 +0000
From: Marco Sinigaglia <marco.sinigaglia@csr.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: HCI Le time out
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I am using CSR 8505 A06 and, using LE, I have some timeout problems 
raised on hci.c.
The following LE functions use a 100ms for the hci_send_req cmd.
- hci_le_set_scan_parameters
- hci_le_set_advertise_enable
- hci_le_set_scan_enable

The 100ms is not enough becouse the chip can be in deep sleep.
Indeed, increasing it to 1000 the problem is fixed.

Would be possible to check in this modifications?

Cheers
Marco Sinigaglia


@@ -2646,7 +2645,7 @@
      rq.rparam = &status;
      rq.rlen = 1;

-    if (hci_send_req(dd, &rq, 100) < 0)
+    if (hci_send_req(dd, &rq, 1000) < 0)
          return -1;

      if (status) {
@@ -2680,7 +2679,7 @@
      rq.rparam = &status;
      rq.rlen = 1;

-    if (hci_send_req(dd, &rq, 100) < 0)
+    if (hci_send_req(dd, &rq, 1000) < 0)
          return -1;

      if (status) {
@@ -2708,7 +2707,7 @@
      rq.rparam = &status;
      rq.rlen = 1;

-    if (hci_send_req(dd, &rq, 100) < 0)
+    if (hci_send_req(dd, &rq, 1000) < 0)
          return -1;



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
