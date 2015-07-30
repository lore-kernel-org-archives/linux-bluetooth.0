Return-Path: <cyrus@holtmann.org>
From: Anchit Narang <anchit.n@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [PATCH] tools/rctest: Fixed memory leak
Date: Thu, 30 Jul 2015 12:01:59 +0530
Message-id: <1438237920-26001-1-git-send-email-anchit.n@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removed dynamic allocation of filename and savefile by strdup.
Instead filename and savefile are directly pointing to the argv element.
---
 tools/rctest.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/rctest.c b/tools/rctest.c
index bdc1eb5..383d165 100644
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
@@ -798,11 +798,11 @@ int main(int argc, char *argv[])
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

