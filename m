Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] plugins: Fix compilation error on autopair
Date: Thu, 16 May 2013 10:00:56 -0400
Message-Id: <1368712856-30692-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix this error caught using gcc 4.6.3:

plugins/autopair.c: In function ‘autopair_init’:
plugins/autopair.c:154:8: error: ignoring return value of ‘fread’,
declared with attribute warn_unused_result [-Werror=unused-result]
---
 plugins/autopair.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index 5d90f9d..5afc357 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -146,15 +146,19 @@ static struct btd_adapter_driver autopair_driver = {
 static int autopair_init(void)
 {
 	/* Initialize the random seed from /dev/urandom */
-	unsigned int seed = time(NULL);
+	unsigned int seed;
+	size_t nread = 0;
 	FILE *f;
 
 	f = fopen("/dev/urandom", "rb");
 	if (f != NULL) {
-		fread(&seed, sizeof(seed), 1, f);
+		nread = fread(&seed, sizeof(seed), 1, f);
 		fclose(f);
 	}
 
+	if (f == NULL || nread != 1)
+		seed = time(NULL);
+
 	srand(seed);
 
 	return btd_register_adapter_driver(&autopair_driver);
-- 
1.7.9.5

