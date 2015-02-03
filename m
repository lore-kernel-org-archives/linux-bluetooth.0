Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] tools/btgatt-server: Fix help message for GATT
Date: Tue, 03 Feb 2015 12:00:43 +0530
Message-id: <1422945043-4387-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added '\n' to make help message looks good as below:
btgatt-server
Usage:
	btgatt-server [options]
Options:
	-i, --index <id>		Specify adapter index, e.g. hci0
	-m, --mtu <mtu>			The ATT MTU to use
	-s, --security-level <sec>	Set security level (low|medium|high)
	-v, --verbose			Enable extra logging
	-r, --heart-rate		Enable Heart Rate service
	-h, --help			Display help
---
 tools/btgatt-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index f6ad8c3..d27cf10 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -631,7 +631,7 @@ static void usage(void)
 		"\t-s, --security-level <sec>\tSet security level (low|"
 								"medium|high)\n"
 		"\t-v, --verbose\t\t\tEnable extra logging\n"
-		"\t-r, --heart-rate\t\tEnable Heart Rate service"
+		"\t-r, --heart-rate\t\tEnable Heart Rate service\n"
 		"\t-h, --help\t\t\tDisplay help\n");
 }
 
-- 
1.9.1

