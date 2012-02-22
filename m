Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix handling of discoverable setting with timeout
Date: Wed, 22 Feb 2012 18:21:00 +0100
Message-Id: <1329931260-9460-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The current handling of the discoverable timeout was missing the proper
handling of the timeout when the mode was already set. Now the command
can be used to expire or retrigger the timeout.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6df4af6..f7e111f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -900,6 +900,17 @@ static int set_discoverable(struct sock *sk, u16 index, void *data, u16 len)
 	}
 
 	if (!!cp->val == test_bit(HCI_DISCOVERABLE, &hdev->dev_flags)) {
+		if (hdev->discov_timeout > 0) {
+			cancel_delayed_work(&hdev->discov_off);
+			hdev->discov_timeout = 0;
+		}
+
+		if (cp->val && timeout > 0) {
+			hdev->discov_timeout = timeout;
+			queue_delayed_work(hdev->workqueue, &hdev->discov_off,
+				msecs_to_jiffies(hdev->discov_timeout * 1000));
+		}
+
 		err = send_settings_rsp(sk, MGMT_OP_SET_DISCOVERABLE, hdev);
 		goto failed;
 	}
-- 
1.7.7.6

