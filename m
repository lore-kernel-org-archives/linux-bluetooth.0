Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 09/16] Bluetooth: Prepare for full support discovery procedures
Date: Mon, 11 Jul 2011 18:11:52 -0300
Message-Id: <1310418719-12296-10-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
References: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch prepares start_discovery() to support LE-Only and BR/EDR/LE
devices discovery procedures (BR/EDR devices are already supported).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/mgmt.c             |   37 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index be30aab..653daec 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -202,6 +202,7 @@ enum {
 
 #define LMP_EV4		0x01
 #define LMP_EV5		0x02
+#define LMP_NO_BREDR	0x20
 #define LMP_LE		0x40
 
 #define LMP_SNIFF_SUBR	0x02
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1ff59f2..fc75c61 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -597,6 +597,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
 #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
 #define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
+#define lmp_no_bredr_capable(dev)  ((dev)->features[4] & LMP_NO_BREDR)
 #define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
 
 /* ----- Extended LMP capabilities ----- */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bbb0daa..af3beca 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -32,6 +32,15 @@
 #define MGMT_VERSION	0
 #define MGMT_REVISION	1
 
+enum bt_device_type {
+	BREDR_ONLY,
+	LE_ONLY,
+	BREDR_LE,
+	UNKNOWN,
+};
+
+#define BREDR_ONLY_INQ_LENGTH 0x08 /* TGAP(100) */
+
 struct pending_cmd {
 	struct list_head list;
 	__u16 opcode;
@@ -1628,10 +1637,23 @@ static int do_inquiry(struct hci_dev *hdev, __u8 inq_length)
 	return hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
 }
 
+static int get_device_type(struct hci_dev *hdev)
+{
+	if (!lmp_no_bredr_capable(hdev) && lmp_host_le_capable(hdev))
+		return BREDR_LE;
+	else if (lmp_host_le_capable(hdev))
+		return LE_ONLY;
+	else if (!lmp_no_bredr_capable(hdev))
+		return BREDR_ONLY;
+	else
+		return UNKNOWN;
+}
+
 static int start_discovery(struct sock *sk, u16 index)
 {
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
+	int dev_type;
 	int err;
 
 	BT_DBG("hci%u", index);
@@ -1654,7 +1676,20 @@ static int start_discovery(struct sock *sk, u16 index)
 		goto failed;
 	}
 
-	err = do_inquiry(hdev, 0x08);
+	dev_type = get_device_type(hdev);
+
+	switch (dev_type) {
+	case BREDR_ONLY:
+		err = do_inquiry(hdev, BREDR_ONLY_INQ_LENGTH);
+		break;
+	case LE_ONLY:
+	case BREDR_LE:
+		err = -ENOSYS;
+		break;
+	default:
+		err = -EINVAL;
+	}
+
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
-- 
1.7.4.1

