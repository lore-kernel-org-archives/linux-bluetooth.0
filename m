Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 06/15] android/hal: Add support for sending create bond command
Date: Fri, 25 Oct 2013 12:50:02 +0200
Message-ID: <1382698211-9123-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
References: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows HAL to start bonding.
---
 android/hal-bluetooth.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index b81f8dd..6f7ef45 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -275,15 +275,17 @@ static int cancel_discovery(void)
 
 static int create_bond(const bt_bdaddr_t *bd_addr)
 {
+	struct hal_cmd_create_bond cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	if (!bd_addr)
-		return BT_STATUS_PARM_INVALID;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 
-	return BT_STATUS_UNSUPPORTED;
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_CREATE_BOND,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static int cancel_bond(const bt_bdaddr_t *bd_addr)
-- 
1.8.4.1

