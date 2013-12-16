Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] hciemu: Print error in case hci_vhci is not loaded
Date: Mon, 16 Dec 2013 10:57:42 +0200
Message-Id: <1387184262-21439-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387184262-21439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387184262-21439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Error message should indicate that module is not loaded:
Opening /dev/vhci failed: No such file or directory
---
 src/shared/hciemu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index c2b4748..9f4bfaf 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -31,6 +31,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <stdbool.h>
+#include <errno.h>
 #include <sys/socket.h>
 
 #include <glib.h>
@@ -216,6 +217,7 @@ static bool create_vhci(struct hciemu *hciemu)
 
 	fd = open("/dev/vhci", O_RDWR | O_NONBLOCK | O_CLOEXEC);
 	if (fd < 0) {
+		perror("Opening /dev/vhci failed");
 		btdev_destroy(btdev);
 		return false;
 	}
-- 
1.8.3.2

