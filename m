Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/ipc: Fix receiving file descriptors
Date: Thu,  7 Nov 2013 16:51:38 +0200
Message-Id: <1383835898-30110-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

It does make sense iterate over !NULL controll headers. This fixes
the bug that file descriptors cannot be send over IPC.
---
 android/hal-ipc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 14be69b..e4b0681 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -373,7 +373,7 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 
 		*fd = -1;
 
-		for (cmsg = CMSG_FIRSTHDR(&msg); !cmsg;
+		for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
 					cmsg = CMSG_NXTHDR(&msg, cmsg)) {
 			if (cmsg->cmsg_level == SOL_SOCKET
 					&& cmsg->cmsg_type == SCM_RIGHTS) {
-- 
1.7.10.4

