Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/2] plugins: Use open()/read() instead of fopen()/fread() on autopair
Date: Thu, 16 May 2013 12:25:09 -0400
Message-Id: <1368721510-14339-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

open()/read() is more common on BlueZ code. Incidentally, get rid of
this compilation error (using gcc 4.6.3):

plugins/autopair.c: In function ‘autopair_init’:
plugins/autopair.c:154:8: error: ignoring return value of ‘fread’,
declared with attribute warn_unused_result [-Werror=unused-result]
---

WARNING: compilation tested only.

 plugins/autopair.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index 5d90f9d..63f906d 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -27,6 +27,8 @@
 
 #include <stdbool.h>
 #include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
 
 #include <bluetooth/bluetooth.h>
 #include <glib.h>
@@ -146,15 +148,19 @@ static struct btd_adapter_driver autopair_driver = {
 static int autopair_init(void)
 {
 	/* Initialize the random seed from /dev/urandom */
-	unsigned int seed = time(NULL);
-	FILE *f;
-
-	f = fopen("/dev/urandom", "rb");
-	if (f != NULL) {
-		fread(&seed, sizeof(seed), 1, f);
-		fclose(f);
+	unsigned int seed;
+	ssize_t nread = 0;
+	int fd;
+
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd != -1) {
+		nread = read(fd, &seed, sizeof(seed));
+		close(fd);
 	}
 
+	if (nread < (ssize_t) sizeof(seed))
+		seed = time(NULL);
+
 	srand(seed);
 
 	return btd_register_adapter_driver(&autopair_driver);
-- 
1.7.9.5

