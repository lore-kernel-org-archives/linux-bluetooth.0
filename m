Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 05/16] Bluetooth: Create hci_do_inquiry()
Date: Fri,  9 Sep 2011 18:56:20 -0300
Message-Id: <1315605391-2407-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1315605391-2407-1-git-send-email-andre.guedes@openbossa.org>
References: <1315605391-2407-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a function to hci_core to carry out inquiry.

All inquiry code from start_discovery() were replaced by a
hci_do_inquiry() call.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |   17 +++++++++++++++++
 net/bluetooth/mgmt.c             |    9 +--------
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 83c0af9..5ca07df 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -916,4 +916,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
 void hci_le_ltk_neg_reply(struct hci_conn *conn);
 
+int hci_do_inquiry(struct hci_dev *hdev, u8 length);
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 446bfdb..abe59b1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2417,3 +2417,20 @@ static void hci_cmd_task(unsigned long arg)
 		}
 	}
 }
+
+int hci_do_inquiry(struct hci_dev *hdev, u8 length)
+{
+	u8 lap[3] = {0x33, 0x8b, 0x9e};
+	struct hci_cp_inquiry cp;
+
+	BT_DBG("%s", hdev->name);
+
+	if (test_bit(HCI_INQUIRY, &hdev->flags))
+		return -EPERM;
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(&cp.lap, lap, 3);
+	cp.length  = length;
+
+	return hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
+}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 74d2036..7620c3a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1629,8 +1629,6 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 
 static int start_discovery(struct sock *sk, u16 index)
 {
-	u8 lap[3] = { 0x33, 0x8b, 0x9e };
-	struct hci_cp_inquiry cp;
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
 	int err;
@@ -1655,12 +1653,7 @@ static int start_discovery(struct sock *sk, u16 index)
 		goto failed;
 	}
 
-	memset(&cp, 0, sizeof(cp));
-	memcpy(&cp.lap, lap, 3);
-	cp.length  = 0x08;
-	cp.num_rsp = 0x00;
-
-	err = hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
+	err = hci_do_inquiry(hdev, 0x08);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
-- 
1.7.5.2

