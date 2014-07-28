Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 04/11] tools/rctest: Remove dead code
Date: Mon, 28 Jul 2014 15:46:42 +0300
Message-Id: <1406551609-17546-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1406551609-17546-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406551609-17546-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Since do_listen() never returns remove hanging code
---
 tools/rctest.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/rctest.c b/tools/rctest.c
index a09a973..e61f7e2 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -629,10 +629,8 @@ static void automated_send_recv()
 	char device[18];
 
 	if (fork()) {
-		if (!savefile) {
+		if (!savefile)
 			do_listen(recv_mode);
-			return;
-		}
 
 		save_fd = open(savefile, O_CREAT | O_WRONLY,
 						S_IRUSR | S_IWUSR);
@@ -640,8 +638,6 @@ static void automated_send_recv()
 			syslog(LOG_ERR, "Failed to open file to save data");
 
 		do_listen(save_mode);
-
-		close(save_fd);
 	} else {
 		ba2str(&bdaddr, device);
 
-- 
1.9.1

