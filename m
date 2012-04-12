Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 1/5] Bluetooth: Remove unused hci_le_ltk_reply()
Date: Thu, 12 Apr 2012 20:33:17 +0530
Message-id: <1334243001-17016-27-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In this API, we were using sizeof operator for an array
given as function argument, which is invalid.
However this API is not used anywhere.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 include/net/bluetooth/hci_core.h |    1 -
 net/bluetooth/hci_conn.c         |   16 ----------------
 2 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c0b232c..6e170de 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1069,7 +1069,6 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 					u16 latency, u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 							__u8 ltk[16]);
-void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
 void hci_le_ltk_neg_reply(struct hci_conn *conn);
 
 int hci_do_inquiry(struct hci_dev *hdev, u8 length);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 947172b..74418ba 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -224,22 +224,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 }
 EXPORT_SYMBOL(hci_le_start_enc);
 
-void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16])
-{
-	struct hci_dev *hdev = conn->hdev;
-	struct hci_cp_le_ltk_reply cp;
-
-	BT_DBG("%p", conn);
-
-	memset(&cp, 0, sizeof(cp));
-
-	cp.handle = cpu_to_le16(conn->handle);
-	memcpy(cp.ltk, ltk, sizeof(ltk));
-
-	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
-}
-EXPORT_SYMBOL(hci_le_ltk_reply);
-
 void hci_le_ltk_neg_reply(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
-- 
1.7.4.1

