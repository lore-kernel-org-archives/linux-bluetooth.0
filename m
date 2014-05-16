Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/4] android/hal: Fix not seting mode in health hal
Date: Fri, 16 May 2014 13:00:42 +0200
Message-Id: <1400238042-16015-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1400238042-16015-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1400238042-16015-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes the following issue:
==8505== Syscall param socketcall.sendmsg(msg.msg_iov[i]) points to
uninitialised byte(s)
==8505==    at 0x534133D: ??? (syscall-template.S:82)
==8505==    by 0x7756346: hal_ipc_cmd (hal-ipc.c:359)
==8505==    by 0x7750EB2: init (hal-health.c:206)
==8505==    by 0x40DF7F: init_p (if-hl.c:86)
==8505==    by 0x401961: main (haltest.c:417)
==8505==  Address 0x7fefffb81 is on thread 1's stack
---
 android/hal-health.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/hal-health.c b/android/hal-health.c
index 344f55c..427d4c9 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -202,6 +202,7 @@ static bt_status_t init(bthl_callbacks_t *callbacks)
 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
 
 	cmd.service_id = HAL_SERVICE_ID_HEALTH;
+	cmd.mode = HAL_MODE_DEFAULT;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
-- 
1.9.3

