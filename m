Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: mmvinni@yahoo.com, justinmattock@gmail.com, edt@aei.ca
Subject: [PATCH] Bluetooth: Fix HCI_RESET command syncronization
Date: Wed, 16 Mar 2011 15:44:46 -0300
Message-Id: <1300301086-22653-1-git-send-email-padovan@profusion.mobi>
In-Reply-To: <4D7BB10B.3080100@gmail.com>
References: <4D7BB10B.3080100@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We can't send new commands before a cmd_complete for the HCI_RESET commnnd
shows up.

Reported-by: Mikko Vinni <mmvinni@yahoo.com>
Reported-by: Justin P. Mattock <justinmattock@gmail.com>
Reported-by: Ed Tomlinson <edt@aei.ca>
Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/hci.h |    2 ++
 net/bluetooth/hci_core.c    |    3 +++
 net/bluetooth/hci_event.c   |    4 +++-
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ec6acf2..2c0d309 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -84,6 +84,8 @@ enum {
 	HCI_SERVICE_CACHE,
 	HCI_LINK_KEYS,
 	HCI_DEBUG_KEYS,
+
+	HCI_RESET,
 };
 
 /* HCI ioctl defines */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b372fb8..32b82e2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -534,6 +534,8 @@ int hci_dev_open(__u16 dev)
 		set_bit(HCI_INIT, &hdev->flags);
 		hdev->init_last_cmd = 0;
 
+		set_bit(HCI_RESET, &hdev->flags);
+
 		ret = __hci_request(hdev, hci_init_req, 0,
 					msecs_to_jiffies(HCI_INIT_TIMEOUT));
 
@@ -1074,6 +1076,7 @@ static void hci_cmd_timer(unsigned long arg)
 
 	BT_ERR("%s command tx timeout", hdev->name);
 	atomic_set(&hdev->cmd_cnt, 1);
+	clear_bit(HCI_RESET, &hdev->flags);
 	tasklet_schedule(&hdev->cmd_task);
 }
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3fbfa50..cebe7588 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -183,6 +183,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
+	clear_bit(HCI_RESET, &hdev->flags);
+
 	hci_req_complete(hdev, HCI_OP_RESET, status);
 }
 
@@ -1847,7 +1849,7 @@ static inline void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (ev->opcode != HCI_OP_NOP)
 		del_timer(&hdev->cmd_timer);
 
-	if (ev->ncmd) {
+	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
 		atomic_set(&hdev->cmd_cnt, 1);
 		if (!skb_queue_empty(&hdev->cmd_q))
 			tasklet_schedule(&hdev->cmd_task);
-- 
1.7.4.1

