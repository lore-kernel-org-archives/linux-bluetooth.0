Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ v2 1/2] plugins: Use open()/read() instead of fopen()/fread() on autopair
Date: Fri, 17 May 2013 10:31:28 -0400
Message-Id: <1368801089-30703-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1368721510-14339-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1368721510-14339-1-git-send-email-anderson.lizardo@openbossa.org>
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

v2: Incorporate comments from Marcel.

 plugins/autopair.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index 5d90f9d..7e71efa 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -27,6 +27,8 @@
 
 #include <stdbool.h>
 #include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
 
 #include <bluetooth/bluetooth.h>
 #include <glib.h>
@@ -146,14 +148,20 @@ static struct btd_adapter_driver autopair_driver = {
 static int autopair_init(void)
 {
 	/* Initialize the random seed from /dev/urandom */
-	unsigned int seed = time(NULL);
-	FILE *f;
+	unsigned int seed;
+	int fd;
 
-	f = fopen("/dev/urandom", "rb");
-	if (f != NULL) {
-		fread(&seed, sizeof(seed), 1, f);
-		fclose(f);
-	}
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd < 0) {
+		ssize_t n;
+
+		n = read(fd, &seed, sizeof(seed));
+		if (n < (ssize_t) sizeof(seed))
+			seed = time(NULL);
+
+		close(fd);
+	} else
+		seed = time(NULL);
 
 	srand(seed);
 
-- 
1.7.9.5

