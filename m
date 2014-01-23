Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] btproxy: Fix resource leak
Date: Thu, 23 Jan 2014 11:07:28 +0200
Message-Id: <1390468048-8526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Close file descriptors before leaving.
---
 tools/btproxy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index be81bae..3503148 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -680,8 +680,11 @@ int main(int argc, char *argv[])
 			return EXIT_FAILURE;
 		}
 
-		if (!setup_proxy(host_fd, false, dev_fd, true))
+		if (!setup_proxy(host_fd, false, dev_fd, true)) {
+			close(dev_fd);
+			close(host_fd);
 			return EXIT_FAILURE;
+		}
 	} else {
 		int server_fd;
 
-- 
1.8.3.2

