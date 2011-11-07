Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Create hci_do_inquiry()
Date: Mon,  7 Nov 2011 11:45:24 -0300
Message-Id: <1320677124-24947-1-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1320427013-5684-1-git-send-email-andre.guedes@openbossa.org>
References: <1320427013-5684-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a function to hci_core to carry out inquiry.

All inquiry code from start_discovery() were replaced by a
hci_do_inquiry() call.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |   18 ++++++++++++++++++
 net/bluetooth/mgmt.c             |   11 +++--------
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f97792c..ae36ac0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -970,4 +970,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
 void hci_le_ltk_neg_reply(struct hci_conn *conn);
 
+int hci_do_inquiry(struct hci_dev *hdev, u8 length);
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b7f6b5b..e6e9913 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2560,3 +2560,21 @@ static void hci_cmd_task(unsigned long arg)
 		}
 	}
 }
+
+int hci_do_inquiry(struct hci_dev *hdev, u8 length)
+{
+	/* General inquiry access code (GIAC) */
+	u8 lap[3] = { 0x33, 0x8b, 0x9e };
+	struct hci_cp_inquiry cp;
+
+	BT_DBG("%s", hdev->name);
+
+	if (test_bit(HCI_INQUIRY, &hdev->flags))
+		return -EINPROGRESS;
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(&cp.lap, lap, sizeof(cp.lap));
+	cp.length  = length;
+
+	return hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
+}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 747366a..17c7fbb 100644
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
@@ -1598,8 +1600,6 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 
 static int start_discovery(struct sock *sk, u16 index)
 {
-	u8 lap[3] = { 0x33, 0x8b, 0x9e };
-	struct hci_cp_inquiry cp;
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
 	int err;
@@ -1618,12 +1618,7 @@ static int start_discovery(struct sock *sk, u16 index)
 		goto failed;
 	}
 
-	memset(&cp, 0, sizeof(cp));
-	memcpy(&cp.lap, lap, 3);
-	cp.length  = 0x08;
-	cp.num_rsp = 0x00;
-
-	err = hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
+	err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
-- 
1.7.7.1

