Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android: Fix for BT Turn off while pairing
Date: Thu, 13 Feb 2014 11:51:32 +0100
Message-ID: <1392288692-5917-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix an issue when Android disables BT during ongoing
paring. In this case mgmt did not accept any commands and BT gets
in some unknown state.
Since Android turns off BT anyway, it is ok to just cancel all
the mgmt requests before send power off command.
---
 android/bluetooth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index ff41627..ad8cfec 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2907,6 +2907,9 @@ static void handle_disable_cmd(const void *buf, uint16_t len)
 		goto reply;
 	}
 
+	/* Cancel all pending requests. Need it in case of ongoing paring */
+	mgmt_cancel_index(mgmt_if, adapter.index);
+
 	if (!set_mode(MGMT_OP_SET_POWERED, 0x00)) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
-- 
1.8.4

