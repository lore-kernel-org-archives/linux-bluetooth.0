Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 04/12] tools/rctest: Remove dead code
Date: Tue, 29 Jul 2014 17:20:53 +0300
Message-Id: <1406643661-29323-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Since do_listen() never returns remove hanging code
---
 tools/rctest.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/rctest.c b/tools/rctest.c
index a09a973..583b50c 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -629,19 +629,17 @@ static void automated_send_recv()
 	char device[18];
 
 	if (fork()) {
-		if (!savefile) {
+		if (!savefile)
+			/* do_listen() never returns */
 			do_listen(recv_mode);
-			return;
-		}
 
 		save_fd = open(savefile, O_CREAT | O_WRONLY,
 						S_IRUSR | S_IWUSR);
 		if (save_fd < 0)
 			syslog(LOG_ERR, "Failed to open file to save data");
 
+		/* do_listen() never returns */
 		do_listen(save_mode);
-
-		close(save_fd);
 	} else {
 		ba2str(&bdaddr, device);
 
-- 
1.9.1

