Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Bluetooth: Fix updating advertising data needlessly
Date: Mon, 14 Oct 2013 16:20:07 +0300
Message-Id: <1381756807-14900-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381756807-14900-1-git-send-email-johan.hedberg@gmail.com>
References: <1381756807-14900-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We need to ensure that the advertising data is up-to-date whenever
advertising is enabled, but when disabling advertising we do not need to
worry about it (since it will eventually get fixed as soon as
advertising is enabled again). This patch fixes this in the command
complete callback for set_adv_enable.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index aa6fed3..da2bc3d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -924,7 +924,7 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 			clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
 	}
 
-	if (!test_bit(HCI_INIT, &hdev->flags)) {
+	if (*sent && !test_bit(HCI_INIT, &hdev->flags)) {
 		struct hci_request req;
 
 		hci_req_init(&req, hdev);
-- 
1.8.3.1

