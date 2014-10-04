Return-Path: <cyrus@holtmann.org>
From: basile@opensource.dyc.edu
To: linux-bluetooth@vger.kernel.org
Cc: blueness@gentoo.org, pacho@gentoo.org,
	"Anthony G. Basile" <basile@opensource.dyc.edu>
Subject: [PATCH] emulator/serial.c: use posix_openpt() instead of getpt()
Date: Sat,  4 Oct 2014 10:31:42 -0400
Message-Id: <1412433102-12904-1-git-send-email-basile@opensource.dyc.edu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Anthony G. Basile" <basile@opensource.dyc.edu>

getpt(3) is glibc-specific and is not provided in musl and possibly
other libc's. Instead, we use use posix_openpt(3) which is equivalent
and portable.

Signed-off-by: Anthony G. Basile <basile@opensource.dyc.edu>
---
 emulator/serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/emulator/serial.c b/emulator/serial.c
index 9583be4..8b49dc6 100644
--- a/emulator/serial.c
+++ b/emulator/serial.c
@@ -32,6 +32,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <fcntl.h>
 #include <sys/param.h>
 #include <sys/epoll.h>
 #include <sys/uio.h>
@@ -160,7 +161,7 @@ static void open_pty(struct serial *serial)
 {
 	enum btdev_type uninitialized_var(type);
 
-	serial->fd = getpt();
+	serial->fd = posix_openpt(O_RDWR | O_NOCTTY);
 	if (serial->fd < 0) {
 		perror("Failed to get master pseudo terminal");
 		return;
-- 
2.0.4

