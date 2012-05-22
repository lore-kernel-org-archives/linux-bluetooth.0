Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, marcel <marcel@holtmann.org>
Cc: "tedd.an" <tedd.an@intel.com>
Subject: [PATCH 3/3] hciattach: add sleep option in the usage
Date: Tue, 22 May 2012 13:13:09 -0700
Message-ID: <5353562.qNZjE19RpW@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

sleep/nosleep option is not shown in the usage

---
 tools/hciattach.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hciattach.c b/tools/hciattach.c
index 06ae9d6..a08ee14 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -1287,7 +1287,7 @@ static void usage(void)
 {
 	printf("hciattach - HCI UART driver initialization utility\n");
 	printf("Usage:\n");
-	printf("\thciattach [-n] [-p] [-b] [-r] [-d] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [bdaddr]\n");
+	printf("\thciattach [-n] [-p] [-b] [-r] [-d] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [sleep|nosleep] [bdaddr]\n");
 	printf("\thciattach -l\n");
 }
 
-- 
1.7.9.5
