Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 08/15] Bluetooth: Prepare for full support discovery procedures
Date: Wed,  5 Oct 2011 20:20:40 -0300
Message-Id: <1317856847-28167-9-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
References: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch prepares start_discovery() to support LE-Only and BR/EDR/LE
discovery procedures (BR/EDR is already supported).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/mgmt.c             |   12 +++++++++++-
 3 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index aaf79af..1e11e7f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -202,6 +202,7 @@ enum {
 
 #define LMP_EV4		0x01
 #define LMP_EV5		0x02
+#define LMP_NO_BREDR	0x20
 #define LMP_LE		0x40
 
 #define LMP_SNIFF_SUBR	0x02
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 36e15cc..e0c9790 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -613,6 +613,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
 #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
 #define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
+#define lmp_bredr_capable(dev)     (!((dev)->features[4] & LMP_NO_BREDR))
 #define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
 
 /* ----- Extended LMP capabilities ----- */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 58cf33a..0040e37 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -32,6 +32,8 @@
 #define MGMT_VERSION	0
 #define MGMT_REVISION	1
 
+#define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
+
 struct pending_cmd {
 	struct list_head list;
 	__u16 opcode;
@@ -1632,7 +1634,15 @@ static int start_discovery(struct sock *sk, u16 index)
 		goto failed;
 	}
 
-	err = hci_do_inquiry(hdev, 0x08);
+	if (lmp_host_le_capable(hdev)) {
+		if (lmp_bredr_capable(hdev))
+			err = -ENOSYS;
+		else
+			err = -ENOSYS;
+	} else {
+		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
+	}
+
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
-- 
1.7.5.2

