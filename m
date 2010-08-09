Return-Path: <cyrus@holtmann.org>
Message-ID: <4C604F37.4020706@csr.com>
Date: Mon, 09 Aug 2010 19:55:51 +0100
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] Bluetooth: HCI devices are either BR/EDR or AMP radios
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

HCI transport drivers may not know what type of radio an AMP device has
so only say whether they're BR/EDR or AMP devices.

Signed-off-by: David Vrabel <david.vrabel@csr.com>
---
  include/net/bluetooth/hci.h |    2 +-
  net/bluetooth/hci_sysfs.c   |    4 ++--
  2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ca2518e..cc14731 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -54,7 +54,7 @@

  /* HCI controller types */
  #define HCI_BREDR	0x00
-#define HCI_80211	0x01
+#define HCI_AMP		0x01

  /* HCI device quirks */
  enum {
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index ce44c47..4e9ca9b 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -196,8 +196,8 @@ static inline char *host_typetostr(int type)
  	switch (type) {
  	case HCI_BREDR:
  		return "BR/EDR";
-	case HCI_80211:
-		return "802.11";
+	case HCI_AMP:
+		return "AMP";
  	default:
  		return "UNKNOWN";
  	}
-- 
1.5.4.3
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
