Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android: Fix missing failure check in ipc_init
Date: Tue,  3 Dec 2013 13:42:08 +0100
Message-Id: <1386074528-8020-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If connecting command socket failed daemon should be terminated.
---
 android/ipc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/ipc.c b/android/ipc.c
index 1d369a8..6f940cd 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -229,6 +229,8 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 void ipc_init(void)
 {
 	cmd_io = connect_hal(cmd_connect_cb);
+	if (!cmd_io)
+		raise(SIGTERM);
 }
 
 void ipc_cleanup(void)
-- 
1.8.3.2

