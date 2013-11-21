Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/ipc: Zero initialize cmsg buffer
Date: Thu, 21 Nov 2013 16:23:30 +0200
Message-Id: <1385043811-21842-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This fixes valgrind warnings:
...
Syscall param sendmsg(msg.msg_control) points to uninitialised byte(s)
...
---
 android/ipc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/ipc.c b/android/ipc.c
index 2fa90bd..4044d4d 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -47,6 +47,7 @@ void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 
 	memset(&msg, 0, sizeof(msg));
 	memset(&m, 0, sizeof(m));
+	memset(cmsgbuf, 0, sizeof(cmsgbuf));
 
 	m.service_id = service_id;
 	m.opcode = opcode;
-- 
1.8.3.2

