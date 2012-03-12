Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Fix type in cpu_to_le conversion
Date: Mon, 12 Mar 2012 15:59:32 +0200
Message-Id: <1331560774-10748-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331560774-10748-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331560774-10748-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use struct hci_cp_write_def_link_policy to overcome sparse
warnigs below:

...
net/bluetooth/hci_event.c:633:21: warning: incorrect type in assignment
(different base types)
net/bluetooth/hci_event.c:633:21:    expected unsigned short [unsigned]
[assigned] [usertype] link_policy
net/bluetooth/hci_event.c:633:21:    got restricted __le16 [usertype] <noident>
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_event.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 66ffe45..7e0d1eb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -616,6 +616,7 @@ done:
 
 static void hci_setup_link_policy(struct hci_dev *hdev)
 {
+	struct hci_cp_write_def_link_policy cp;
 	u16 link_policy = 0;
 
 	if (hdev->features[0] & LMP_RSWITCH)
@@ -627,9 +628,8 @@ static void hci_setup_link_policy(struct hci_dev *hdev)
 	if (hdev->features[1] & LMP_PARK)
 		link_policy |= HCI_LP_PARK;
 
-	link_policy = cpu_to_le16(link_policy);
-	hci_send_cmd(hdev, HCI_OP_WRITE_DEF_LINK_POLICY, sizeof(link_policy),
-		     &link_policy);
+	cp.policy = cpu_to_le16(link_policy);
+	hci_send_cmd(hdev, HCI_OP_WRITE_DEF_LINK_POLICY, sizeof(cp), &cp);
 }
 
 static void hci_cc_read_local_commands(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.7.9.1

