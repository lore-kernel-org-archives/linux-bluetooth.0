Return-Path: <cyrus@holtmann.org>
From: Anchit Narang <anchit.n@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [PATCH] tools/rctest: Fixed memory leak
Date: Thu, 30 Jul 2015 11:00:07 +0530
Message-id: <1438234207-7374-1-git-send-email-anchit.n@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removed dynamic allocation of filename and savefile by strdup.
Instead filename and savefile are directly pointing to the argv element.
Closed the file  before returning from do_send function.
---
 tools/rctest.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/rctest.c b/tools/rctest.c
index bdc1eb5..9169e3c 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -80,8 +80,8 @@ static bdaddr_t auto_bdaddr;
 static uint16_t uuid = 0x0000;
 static uint8_t channel = 10;
 
-static char *filename = NULL;
-static char *savefile = NULL;
+static const char *filename = NULL;
+static const char *savefile = NULL;
 static int save_fd = -1;
 
 static int master = 0;
@@ -559,6 +559,7 @@ static void do_send(int sk)
 		}
 		len = read(fd, buf, data_size);
 		send(sk, buf, len, 0);
+		close(fd);
 		return;
 	} else {
 		for (i = 6; i < data_size; i++)
@@ -798,11 +799,11 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'B':
-			filename = strdup(optarg);
+			filename = optarg;
 			break;
 
 		case 'O':
-			savefile = strdup(optarg);
+			savefile = optarg;
 			break;
 
 		case 'N':
-- 
1.7.9.5

