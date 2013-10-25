Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/15] android/hal: Add support for sending adapter remove bond command
Date: Fri, 25 Oct 2013 10:56:11 +0200
Message-ID: <1382691378-31940-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
References: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows HAL to remove bonding.
---
 android/hal-bluetooth.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index ebaa877..ca443a6 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -305,12 +305,17 @@ static int cancel_bond(const bt_bdaddr_t *bd_addr)
 
 static int remove_bond(const bt_bdaddr_t *bd_addr)
 {
+	struct hal_cmd_remove_bond cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_REMOVE_BOND,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static int pin_reply(const bt_bdaddr_t *bd_addr, uint8_t accept,
-- 
1.8.4.1

