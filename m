Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 1/1] Fix OPP not sending TransferCompleted signal
Date: Fri,  7 Oct 2011 11:11:10 +0200
Message-Id: <1317978670-24903-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1317978670-24903-1-git-send-email-lkslawek@gmail.com>
References: <1317978670-24903-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commit 934b3b2f5f8432b67822be9f83a141fe3783cbd7 introduced a regression
in OPP, by making it not send TransferCompleted signal. This happened
because OPP was calling manager_emit_transfer_completed() on .reset(),
and manager_emit_transfer_completed() in turn checks if the os->object
is not NULL. This fixes this by moving clearing os->object after doing
service driver .reset().
---
 src/obex.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 59bbe7a..a0c17c1 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -288,8 +288,6 @@ static void os_reset_session(struct obex_session *os)
 	if (os->object) {
 		os->driver->set_io_watch(os->object, NULL, NULL);
 		os->driver->close(os->object);
-		os->object = NULL;
-		os->obj = NULL;
 		if (os->aborted && os->cmd == OBEX_CMD_PUT && os->path &&
 				os->driver->remove)
 			os->driver->remove(os->path);
@@ -315,6 +313,8 @@ static void os_reset_session(struct obex_session *os)
 		os->path = NULL;
 	}
 
+	os->object = NULL;
+	os->obj = NULL;
 	os->driver = NULL;
 	os->aborted = FALSE;
 	os->pending = 0;
-- 
1.7.4.1

