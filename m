Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] btproxy: Fix resource leak
Date: Wed, 22 Jan 2014 13:00:42 +0200
Message-Id: <1390388442-1192-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Close file descriptors if setup_proxy fails.
---
 tools/btproxy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index 4429a16..9f409c3 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -330,8 +330,11 @@ static bool setup_proxy(int host_fd, bool host_shutdown,
 	struct proxy *proxy;
 
 	proxy = new0(struct proxy, 1);
-	if (!proxy)
+	if (!proxy) {
+		close(host_fd);
+		close(dev_fd);
 		return NULL;
+	}
 
 	proxy->host_fd = host_fd;
 	proxy->host_shutdown = host_shutdown;
-- 
1.8.3.2

