Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 13/22] Bluetooth: Don't disable tasklets to call hdev->notify()
Date: Sat, 17 Dec 2011 19:29:33 -0200
Message-Id: <1324157382-1815-14-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-13-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-9-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-10-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-11-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-13-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

It's pointless, we aren't protecting anything since btusb_notify()
schedules a work to run, then all it operation happens without protection.
If protection is really needed here, we will fix it further.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/hci_conn.c  |   10 ++--------
 net/bluetooth/hci_event.c |   10 ++--------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5e9e193..385cccb 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -419,11 +419,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	hci_dev_hold(hdev);
 
 	hci_conn_hash_add(hdev, conn);
-	if (hdev->notify) {
-		tasklet_disable(&hdev->tx_task);
+	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_CONN_ADD);
-		tasklet_enable(&hdev->tx_task);
-	}
 
 	atomic_set(&conn->devref, 0);
 
@@ -468,11 +465,8 @@ int hci_conn_del(struct hci_conn *conn)
 	hci_chan_list_flush(conn);
 
 	hci_conn_hash_del(hdev, conn);
-	if (hdev->notify) {
-		tasklet_disable(&hdev->tx_task);
+	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
-		tasklet_enable(&hdev->tx_task);
-	}
 
 	skb_queue_purge(&conn->data_q);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0a9501f..93ecb2d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -378,11 +378,8 @@ static void hci_cc_read_voice_setting(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s voice setting 0x%04x", hdev->name, setting);
 
-	if (hdev->notify) {
-		tasklet_disable(&hdev->tx_task);
+	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_VOICE_SETTING);
-		tasklet_enable(&hdev->tx_task);
-	}
 }
 
 static void hci_cc_write_voice_setting(struct hci_dev *hdev, struct sk_buff *skb)
@@ -409,11 +406,8 @@ static void hci_cc_write_voice_setting(struct hci_dev *hdev, struct sk_buff *skb
 
 	BT_DBG("%s voice setting 0x%04x", hdev->name, setting);
 
-	if (hdev->notify) {
-		tasklet_disable(&hdev->tx_task);
+	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_VOICE_SETTING);
-		tasklet_enable(&hdev->tx_task);
-	}
 }
 
 static void hci_cc_host_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.7.6.4

