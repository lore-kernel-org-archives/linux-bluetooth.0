Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Complete Read Local Version HCI cmd
Date: Fri, 24 Feb 2012 12:45:44 +0200
Message-Id: <1330080344-23739-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Mark request status as done for Read Local Version HCI command.
In AMP initialization this HCI command is the last and needs
to be completed.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_event.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fb6543b..143de9b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -618,7 +618,7 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s status 0x%x", hdev->name, rp->status);
 
 	if (rp->status)
-		return;
+		goto done;
 
 	hdev->hci_ver = rp->hci_ver;
 	hdev->hci_rev = __le16_to_cpu(rp->hci_rev);
@@ -632,6 +632,9 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (test_bit(HCI_INIT, &hdev->flags))
 		hci_setup(hdev);
+
+done:
+	hci_req_complete(hdev, HCI_OP_READ_LOCAL_VERSION, rp->status);
 }
 
 static void hci_setup_link_policy(struct hci_dev *hdev)
-- 
1.7.9

