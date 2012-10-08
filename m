Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 4/6] Bluetooth: Handle number of compl blocks for AMP_LINK
Date: Mon,  8 Oct 2012 17:52:10 +0300
Message-Id: <1349707932-10006-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349707932-10006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add handling blocks count for AMP link.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_event.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 82e478a..c479732 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2698,13 +2698,21 @@ static void hci_num_comp_blocks_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	for (i = 0; i < ev->num_hndl; i++) {
 		struct hci_comp_blocks_info *info = &ev->handles[i];
-		struct hci_conn *conn;
+		struct hci_conn *conn = NULL;
+		struct hci_chan *chan;
 		__u16  handle, block_count;
 
 		handle = __le16_to_cpu(info->handle);
 		block_count = __le16_to_cpu(info->blocks);
 
-		conn = hci_conn_hash_lookup_handle(hdev, handle);
+		if (hdev->dev_type == HCI_BREDR) {
+			conn = hci_conn_hash_lookup_handle(hdev, handle);
+		} else {
+			chan = hci_chan_lookup_handle_all(hdev, handle);
+			if (chan)
+				conn = chan->conn;
+		}
+
 		if (!conn)
 			continue;
 
-- 
1.7.9.5

