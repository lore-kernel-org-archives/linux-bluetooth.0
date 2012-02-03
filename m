Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 2/2] Bluetooth: Helper removes duplicated code
Date: Fri,  3 Feb 2012 16:27:55 +0200
Message-Id: <1328279275-10303-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328279275-10303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279275-10303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use __check_timout helper to remove duplicated code

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |   31 +++++++++++++------------------
 1 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9a56a40..95eeae5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2390,22 +2390,25 @@ static inline int __get_blocks(struct hci_dev *hdev, struct sk_buff *skb)
 	return DIV_ROUND_UP(skb->len - HCI_ACL_HDR_SIZE, hdev->block_len);
 }
 
-static inline void hci_sched_acl_pkt(struct hci_dev *hdev)
+static inline void __check_timeout(struct hci_dev *hdev, unsigned int cnt)
 {
-	struct hci_chan *chan;
-	struct sk_buff *skb;
-	int quote;
-	unsigned int cnt;
-
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
-		if (!hdev->acl_cnt && time_after(jiffies, hdev->acl_last_tx +
+		if (!cnt && time_after(jiffies, hdev->acl_last_tx +
 					msecs_to_jiffies(HCI_ACL_TX_TIMEOUT)))
 			hci_link_tx_to(hdev, ACL_LINK);
 	}
+}
 
-	cnt = hdev->acl_cnt;
+static inline void hci_sched_acl_pkt(struct hci_dev *hdev)
+{
+	unsigned int cnt = hdev->acl_cnt;
+	struct hci_chan *chan;
+	struct sk_buff *skb;
+	int quote;
+
+	__check_timeout(hdev, cnt);
 
 	while (hdev->acl_cnt &&
 			(chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
@@ -2438,20 +2441,12 @@ static inline void hci_sched_acl_pkt(struct hci_dev *hdev)
 
 static inline void hci_sched_acl_blk(struct hci_dev *hdev)
 {
+	unsigned int cnt = hdev->block_cnt;
 	struct hci_chan *chan;
 	struct sk_buff *skb;
 	int quote;
-	unsigned int cnt;
-
-	if (!test_bit(HCI_RAW, &hdev->flags)) {
-		/* ACL tx timeout must be longer than maximum
-		 * link supervision timeout (40.9 seconds) */
-		if (!hdev->block_cnt && time_after(jiffies, hdev->acl_last_tx +
-					msecs_to_jiffies(HCI_ACL_TX_TIMEOUT)))
-			hci_link_tx_to(hdev, ACL_LINK);
-	}
 
-	cnt = hdev->block_cnt;
+	__check_timeout(hdev, cnt);
 
 	while (hdev->block_cnt > 0 &&
 			(chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
-- 
1.7.8.3

