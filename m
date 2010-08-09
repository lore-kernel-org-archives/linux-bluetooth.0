Return-Path: <cyrus@holtmann.org>
Message-ID: <4C607688.9050608@csr.com>
Date: Mon, 09 Aug 2010 22:43:36 +0100
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] Bluetooth: btmrvl: devices are either BR/EDR or AMPs
Content-Type: multipart/mixed;
 boundary="------------080702090007010409070902"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080702090007010409070902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom

--------------080702090007010409070902
Content-Type: text/x-diff;
 name="0001-Bluetooth-btmrvl-devices-are-either-BR-EDR-or-AMPs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="0001-Bluetooth-btmrvl-devices-are-either-BR-EDR-or-AMPs.patch"

>From 5d16a92e61d8457077d0235d6b7006b824ff6891 Mon Sep 17 00:00:00 2001
From: David Vrabel <dv02@dv02-laptop.(none)>
Date: Mon, 9 Aug 2010 22:39:43 +0100
Subject: [PATCH] Bluetooth: btmrvl: devices are either BR/EDR or AMPs

Signed-off-by: David Vrabel <david.vrabel@csr.com>
---
 drivers/bluetooth/btmrvl_main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 0d32ec8..548d1d9 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -117,8 +117,8 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 				(event->data[2] == MODULE_ALREADY_UP)) ?
 				"Bring-up succeed" : "Bring-up failed");
 
-			if (event->length > 3)
-				priv->btmrvl_dev.dev_type = event->data[3];
+			if (event->length > 3 && event->data[3])
+				priv->btmrvl_dev.dev_type = HCI_AMP;
 			else
 				priv->btmrvl_dev.dev_type = HCI_BREDR;
 
-- 
1.5.4.3


--------------080702090007010409070902--
