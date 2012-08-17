Return-Path: <cyrus@holtmann.org>
From: Sunil Kumar Behera <sunil.behera@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sunil Kumar Behera <sunil.behera@samsung.com>
Subject: [PATCH obexd] MAP: Fix invalid oflag check
Date: Fri, 17 Aug 2012 15:03:46 +0530
Message-id: <1345196026-6873-1-git-send-email-sunil.behera@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change logic to check for O_WRONLY, as oflag is
created by an OR operation of O_WRONLY, O_CREAT and
O_TRUNC.
Message update is a PUT function, this check returns
bad response if GET is received.
---
 plugins/mas.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 30e529f..57d9611 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -632,7 +632,7 @@ static void *message_update_open(const char *name, int oflag, mode_t mode,
 
 	DBG("");
 
-	if (oflag != O_WRONLY) {
+	if (oflag == O_RDONLY) {
 		*err = -EBADR;
 		return NULL;
 	}
-- 
1.7.9.5

