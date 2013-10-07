Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] autopair: Remove time(NULL) fallback when seeding rand()
Date: Mon,  7 Oct 2013 17:05:24 -0400
Message-Id: <1381179924-19529-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If /dev/urandom cannot be opened or read, just fail the plugin
initialization, as it is very unlikely that a fully working Linux system
does not have a working /dev/urandom. This also simplifies the code
logic.
---
 plugins/autopair.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index e6e5035..266b695 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -29,6 +29,7 @@
 #include <stdlib.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <errno.h>
 
 #include <bluetooth/bluetooth.h>
 #include <glib.h>
@@ -149,19 +150,27 @@ static int autopair_init(void)
 {
 	/* Initialize the random seed from /dev/urandom */
 	unsigned int seed;
-	int fd;
+	int fd, err;
+	ssize_t n;
 
 	fd = open("/dev/urandom", O_RDONLY);
-	if (fd >= 0) {
-		ssize_t n;
-
-		n = read(fd, &seed, sizeof(seed));
-		if (n < (ssize_t) sizeof(seed))
-			seed = time(NULL);
+	if (fd < 0) {
+		err = -errno;
+		error("Failed to open /dev/urandom: %s (%d)", strerror(-err),
+									-err);
+		return err;
+	}
 
+	n = read(fd, &seed, sizeof(seed));
+	if (n < (ssize_t) sizeof(seed)) {
+		err = (n == -1) ? -errno : -EIO;
+		error("Failed to read %d bytes from /dev/urandom",
+								sizeof(seed));
 		close(fd);
-	} else
-		seed = time(NULL);
+		return err;
+	}
+
+	close(fd);
 
 	srand(seed);
 
-- 
1.7.9.5

