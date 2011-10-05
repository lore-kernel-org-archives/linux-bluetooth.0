Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 05/15] Bluetooth: Create hci_do_inquiry()
Date: Wed,  5 Oct 2011 20:20:37 -0300
Message-Id: <1317856847-28167-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
References: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a function to hci_core to carry out inquiry.

All inquiry code from start_discovery() were replaced by a
hci_do_inquiry() call.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |   17 +++++++++++++++++
 net/bluetooth/mgmt.c             |    9 +--------
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index df6fa85..b7c070b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -914,4 +914,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
 void hci_le_ltk_neg_reply(struct hci_conn *conn);
 
+int hci_do_inquiry(struct hci_dev *hdev, u8 length);
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b84458d..8516420 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2407,3 +2407,20 @@ static void hci_cmd_task(unsigned long arg)
 		}
 	}
 }
+
+int hci_do_inquiry(struct hci_dev *hdev, u8 length)
+{
+	u8 lap[3] = { 0x33, 0x8b, 0x9e };
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
index 5e1414b..4f77468 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1608,8 +1608,6 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 
 static int start_discovery(struct sock *sk, u16 index)
 {
-	u8 lap[3] = { 0x33, 0x8b, 0x9e };
-	struct hci_cp_inquiry cp;
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
 	int err;
@@ -1634,12 +1632,7 @@ static int start_discovery(struct sock *sk, u16 index)
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

