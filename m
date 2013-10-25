Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH v2 2/2] android/client: Add processing of .haltestrc
Date: Fri, 25 Oct 2013 12:51:46 +0200
Message-ID: <1382698306-30914-3-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1382698306-30914-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382698306-30914-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows tool to read commands from .haltestrc.
So it is possible to call some functions that are typically used.
So user can have:
  adapter init
  adapter get_profile_interface socket
  adapter get_profile_interface pan
  adapter get_profile_interface hidhost
  adapter get_profile_interface a2dp
  pan init
  av init
---
 android/client/haltest.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/client/haltest.c b/android/client/haltest.c
index ac43afb..6b4030b 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -314,6 +314,8 @@ static void stdin_handler(struct pollfd *pollfd)
 
 int main(int argc, char **argv)
 {
+	struct stat rcstat;
+
 	terminal_setup();
 	history_restore(".haltest_history");
 
@@ -321,6 +323,9 @@ int main(int argc, char **argv)
 	/* Register command line handler */
 	poll_register_fd(0, POLLIN, stdin_handler);
 
+	if (stat(".haltestrc", &rcstat) == 0 && (rcstat.st_mode & S_IFREG) != 0)
+		process_file(".haltestrc");
+
 	poll_dispatch_loop();
 
 	return 0;
-- 
1.7.9.5

