Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 2/5] Bluetooth: Remove unused hci_le_ltk_neg_reply()
Date: Thu, 12 Apr 2012 20:33:18 +0530
Message-id: <1334243001-17016-28-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 include/net/bluetooth/hci_core.h |    2 --
 net/bluetooth/hci_conn.c         |   14 --------------
 2 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6e170de..ed9eaba 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1069,8 +1069,6 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 					u16 latency, u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 							__u8 ltk[16]);
-void hci_le_ltk_neg_reply(struct hci_conn *conn);
-
 int hci_do_inquiry(struct hci_dev *hdev, u8 length);
 int hci_cancel_inquiry(struct hci_dev *hdev);
 int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 74418ba..43e0d49 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -224,20 +224,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 }
 EXPORT_SYMBOL(hci_le_start_enc);
 
-void hci_le_ltk_neg_reply(struct hci_conn *conn)
-{
-	struct hci_dev *hdev = conn->hdev;
-	struct hci_cp_le_ltk_neg_reply cp;
-
-	BT_DBG("%p", conn);
-
-	memset(&cp, 0, sizeof(cp));
-
-	cp.handle = cpu_to_le16(conn->handle);
-
-	hci_send_cmd(hdev, HCI_OP_LE_LTK_NEG_REPLY, sizeof(cp), &cp);
-}
-
 /* Device _must_ be locked */
 void hci_sco_setup(struct hci_conn *conn, __u8 status)
 {
-- 
1.7.4.1

