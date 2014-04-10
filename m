Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] android/hal-gatt: Fix sending uninitialised byte
Date: Thu, 10 Apr 2014 15:17:09 +0300
Message-Id: <1397132229-892-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1397132229-892-1-git-send-email-luiz.dentz@gmail.com>
References: <1397132229-892-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes sending uninitialised byte on init:

Syscall param sendmsg(msg.msg_iov[1]) points to uninitialised byte(s)
   at 0x534ADDD: ??? (in /usr/lib64/libpthread-2.18.so)
   by 0x6B5628C: hal_ipc_cmd (hal-ipc.c:357)
   by 0x6B54F6D: init (hal-gatt.c:1268)
   by 0x4092DB: init_p (if-gatt.c:779)
   by 0x401CCD: main (haltest.c:413)
 Address 0xffefffda1 is on thread 1's stack
 Uninitialised value was created by a stack allocation
   at 0x6B54EC0: init (hal-gatt.c:1252)
---
 android/hal-gatt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index d8c0d54..6fde143 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1264,6 +1264,7 @@ static bt_status_t init(const btgatt_callbacks_t *callbacks)
 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
 
 	cmd.service_id = HAL_SERVICE_ID_GATT;
+	cmd.mode = HAL_MODE_DEFAULT;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
-- 
1.9.0

