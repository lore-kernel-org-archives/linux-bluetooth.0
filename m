Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/10] Bluetooth: Clean up hci_sniff_subrate_evt function
Date: Thu, 17 Feb 2011 14:16:33 +0100
Message-ID: <1297948601-12723-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
References: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/hci_event.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 09cb29e..1741936 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2242,17 +2242,8 @@ static inline void hci_sync_conn_changed_evt(struct hci_dev *hdev, struct sk_buf
 static inline void hci_sniff_subrate_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_sniff_subrate *ev = (void *) skb->data;
-	struct hci_conn *conn;
 
 	BT_DBG("%s status %d", hdev->name, ev->status);
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
-	if (conn) {
-	}
-
-	hci_dev_unlock(hdev);
 }
 
 static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.7.0.4

