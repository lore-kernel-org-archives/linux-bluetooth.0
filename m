Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 4/5] tools: Update rfcomm help
Date: Fri, 31 May 2013 00:01:56 +0200
Message-Id: <1369951317-16789-4-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1369951317-16789-1-git-send-email-szymon.janc@gmail.com>
References: <1369951317-16789-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This includes:
remove describtion of non-existing option '-f'
add missing description of '-L' option
add missing long version of '-i' option
---
 tools/rfcomm.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index ff164c8..b5bea38 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -652,15 +652,15 @@ static void usage(void)
 		"\n");
 
 	printf("Options:\n"
-		"\t-i [hciX|bdaddr]      Local HCI device or BD Address\n"
-		"\t-h, --help            Display help\n"
-		"\t-r, --raw             Switch TTY into raw mode\n"
-		"\t-A, --auth            Enable authentication\n"
-		"\t-E, --encrypt         Enable encryption\n"
-		"\t-S, --secure          Secure connection\n"
-		"\t-M, --master          Become the master of a piconet\n"
-		"\t-f, --config [file]   Specify alternate config file\n"
-		"\t-a                    Show all devices (default)\n"
+		"\t-i, --device [hciX|bdaddr]     Local HCI device or BD Address\n"
+		"\t-h, --help                     Display help\n"
+		"\t-r, --raw                      Switch TTY into raw mode\n"
+		"\t-A, --auth                     Enable authentication\n"
+		"\t-E, --encrypt                  Enable encryption\n"
+		"\t-S, --secure                   Secure connection\n"
+		"\t-M, --master                   Become the master of a piconet\n"
+		"\t-L, --linger [seconds]         Set linger timeout\n"
+		"\t-a                             Show all devices (default)\n"
 		"\n");
 
 	printf("Commands:\n");
-- 
1.7.10.4

