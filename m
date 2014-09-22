Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools: Destroy client on error
Date: Mon, 22 Sep 2014 15:14:50 +0300
Message-Id: <1411388090-24137-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 tools/btgatt-client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 41b85ad..021000d 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1124,6 +1124,7 @@ int main(int argc, char *argv[])
 				EPOLLIN | EPOLLRDHUP | EPOLLHUP | EPOLLERR,
 				prompt_read_cb, cli, NULL) < 0) {
 		fprintf(stderr, "Failed to initialize console\n");
+		client_destroy(cli);
 		return EXIT_FAILURE;
 	}
 
-- 
1.9.1

