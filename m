Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 12/13] emulator: Fix compilation error with musl
Date: Fri, 19 Sep 2014 16:10:15 +0200
Message-Id: <1411135816-18966-13-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
References: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

make --no-print-directory all-am
  CC       emulator/serial.o
emulator/serial.c: In function 'open_pty':
emulator/serial.c:162:2: error: implicit declaration of
    function 'getpt' [-Werror=implicit-function-declaration]
  serial->fd = getpt();
  ^

  CC       emulator/le.o
emulator/le.c: In function 'send_event':
emulator/le.c:224:2: error: implicit declaration of function
    'writev' [-Werror=implicit-function-declaration]
  if (writev(hci->vhci_fd, iov, iovcnt) < 0)
  ^
---
 emulator/hfp.c    | 1 +
 emulator/le.c     | 1 +
 emulator/serial.c | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/emulator/hfp.c b/emulator/hfp.c
index 928a729..55e912c 100644
--- a/emulator/hfp.c
+++ b/emulator/hfp.c
@@ -30,6 +30,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <string.h>
 #include <sys/socket.h>
 #include <sys/un.h>
 
diff --git a/emulator/le.c b/emulator/le.c
index 0a1b00d..955f08f 100644
--- a/emulator/le.c
+++ b/emulator/le.c
@@ -32,6 +32,7 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <sys/un.h>
+#include <sys/uio.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
diff --git a/emulator/serial.c b/emulator/serial.c
index 9583be4..271e882 100644
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
+	serial->fd = open("/dev/ptmx", O_RDWR | O_NOCTTY);
 	if (serial->fd < 0) {
 		perror("Failed to get master pseudo terminal");
 		return;
-- 
1.9.3

