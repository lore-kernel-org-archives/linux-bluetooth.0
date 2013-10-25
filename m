Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/15] android/hal: Add support for sending cancel bond command
Date: Fri, 25 Oct 2013 10:56:10 +0200
Message-ID: <1382691378-31940-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
References: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows HAL to cancel pending bonding.
---
 android/hal-bluetooth.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 6f7ef45..ebaa877 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -290,12 +290,17 @@ static int create_bond(const bt_bdaddr_t *bd_addr)
 
 static int cancel_bond(const bt_bdaddr_t *bd_addr)
 {
+	struct hal_cmd_cancel_bond cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CANCEL_BOND,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static int remove_bond(const bt_bdaddr_t *bd_addr)
-- 
1.8.4.1

