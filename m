Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Fix unconditional call to mgmt interface in hci_event.c
Date: Wed, 6 Apr 2011 13:02:20 +0200
Message-ID: <1302087740-18244-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hci_cc_read_local_oob_data_reply funtion should call
mgmt_read_local_oob_data_reply_complete only if management interface
is enabled.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/hci_event.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7a3398d..9062e1b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -831,7 +831,8 @@ static void hci_cc_read_local_oob_data_reply(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%x", hdev->name, rp->status);
 
-	mgmt_read_local_oob_data_reply_complete(hdev->id, rp->hash,
+	if (test_bit(HCI_MGMT, &hdev->flags))
+		mgmt_read_local_oob_data_reply_complete(hdev->id, rp->hash,
 						rp->randomizer, rp->status);
 }
 
-- 
1.7.0.4

