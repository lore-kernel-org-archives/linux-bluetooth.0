Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH] Bluetooth: Increase HCI reset timeout in hci_dev_do_close
Date: Mon, 17 Oct 2011 23:05:49 +0200
Message-Id: <1318885549-14784-2-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1318885549-14784-1-git-send-email-szymon@janc.net.pl>
References: <1318885549-14784-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon@janc.net.pl>
---
 net/bluetooth/hci_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fdcbf8f..f5dad71 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -613,7 +613,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
 		set_bit(HCI_INIT, &hdev->flags);
 		__hci_request(hdev, hci_reset_req, 0,
-					msecs_to_jiffies(250));
+					msecs_to_jiffies(HCI_INIT_TIMEOUT));
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
-- 
1.7.7


