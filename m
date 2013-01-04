Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH 2/2] rfkill: Fix count parameter in read
Date: Fri, 04 Jan 2013 11:12:28 +0530
Message-id: <1357278148-27872-2-git-send-email-jaganath.k@samsung.com>
In-reply-to: <1357278148-27872-1-git-send-email-jaganath.k@samsung.com>
References: <1357278148-27872-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since g_str_has_prefix() has been used with the output buffer of read
it should be NULL terminated
---
 src/rfkill.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rfkill.c b/src/rfkill.c
index bac9efd..51591cb 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -114,7 +114,7 @@ static gboolean rfkill_event(GIOChannel *chan,
 
 	memset(sysname, 0, sizeof(sysname));
 
-	if (read(fd, sysname, sizeof(sysname)) < 4) {
+	if (read(fd, sysname, sizeof(sysname) - 1) < 4) {
 		close(fd);
 		return TRUE;
 	}
-- 
1.7.9.5

