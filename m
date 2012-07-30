Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 1/3] rfcomm: Fix checking return value instead of errno
Date: Mon, 30 Jul 2012 13:24:49 -0300
Message-Id: <1343665491-16362-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We were checking by a positive return value instead of checking by -1
and errno. However when there's no support for TTY kernel returns
EOPNOTSUPP as usual, which in the end will have a return value of -1
and errno will be set to EOPNOTSUPP.
---
 tools/rfcomm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index e73b0ba..0a80670 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -182,10 +182,14 @@ static int create_dev(int ctl, int dev, uint32_t flags, bdaddr_t *bdaddr, int ar
 	}
 
 	err = ioctl(ctl, RFCOMMCREATEDEV, &req);
-	if (err == EOPNOTSUPP)
-		fprintf(stderr, "RFCOMM TTY support not available\n");
-	else if (err < 0)
-		perror("Can't create device");
+	if (err == -1) {
+		err = -errno;
+
+		if (err == -EOPNOTSUPP)
+			fprintf(stderr, "RFCOMM TTY support not available\n");
+		else
+			perror("Can't create device");
+	}
 
 	return err;
 }
-- 
1.7.11.3

