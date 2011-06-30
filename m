Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 4/5] Bluetooth: Add lmp_host_le_capable() macro
Date: Thu, 30 Jun 2011 19:20:55 -0300
Message-Id: <1309472456-24674-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1309472456-24674-1-git-send-email-andre.guedes@openbossa.org>
References: <1309472456-24674-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since we have the extended LMP features properly implemented, we
should check the LMP_HOST_LE bit to know if the host supports LE.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h      |    3 +++
 include/net/bluetooth/hci_core.h |    3 +++
 net/bluetooth/hci_core.c         |    2 +-
 3 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5f37822..5004e36 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -219,6 +219,9 @@ enum {
 #define LMP_INQ_TX_PWR	0x02
 #define LMP_EXTFEATURES	0x80
 
+/* Extended LMP features */
+#define LMP_HOST_LE	0x02
+
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
 #define HCI_CM_HOLD	0x0001
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cd65f0e..005e3bb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -580,6 +580,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
 #define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
 
+/* ----- Extended LMP capabilities ----- */
+#define lmp_host_le_capable(dev)   ((dev)->extfeatures[0] & LMP_HOST_LE)
+
 /* ----- HCI protocols ----- */
 struct hci_proto {
 	char		*name;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0029e17..ecc584d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -542,7 +542,7 @@ int hci_dev_open(__u16 dev)
 		ret = __hci_request(hdev, hci_init_req, 0,
 					msecs_to_jiffies(HCI_INIT_TIMEOUT));
 
-		if (lmp_le_capable(hdev))
+		if (lmp_host_le_capable(hdev))
 			ret = __hci_request(hdev, hci_le_init_req, 0,
 					msecs_to_jiffies(HCI_INIT_TIMEOUT));
 
-- 
1.7.4.1

