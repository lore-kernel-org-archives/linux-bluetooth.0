Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] btproxy: Fix closing invalid file descriptor
Date: Fri,  3 Jan 2014 14:54:46 +0200
Message-Id: <1388753686-29400-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1388753686-29400-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1388753686-29400-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Instead of invalid file descriptor dst_fd close src_fd.
---
 tools/btproxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index 3c7c48f..1573587 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -659,7 +659,7 @@ int main(int argc, char *argv[])
 
 		dst_fd = open_vhci(0x00);
 		if (dst_fd < 0) {
-			close(dst_fd);
+			close(src_fd);
 			return EXIT_FAILURE;
 		}
 
-- 
1.8.3.2

