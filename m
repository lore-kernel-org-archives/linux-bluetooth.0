Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 8/8] Bluetooth: Complete Read Local Version HCI cmd
Date: Thu,  1 Dec 2011 14:42:15 +0200
Message-Id: <1322743335-8671-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Mark request status as done for Read Local Version HCI command.
---
 net/bluetooth/hci_event.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a646310..e064aa1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -598,7 +598,7 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s status 0x%x", hdev->name, rp->status);
 
 	if (rp->status)
-		return;
+		goto done;
 
 	hdev->hci_ver = rp->hci_ver;
 	hdev->hci_rev = __le16_to_cpu(rp->hci_rev);
@@ -612,6 +612,9 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (test_bit(HCI_INIT, &hdev->flags))
 		hci_setup(hdev);
+
+done:
+	hci_req_complete(hdev, HCI_OP_READ_LOCAL_VERSION, rp->status);
 }
 
 static void hci_setup_link_policy(struct hci_dev *hdev)
-- 
1.7.4.1

