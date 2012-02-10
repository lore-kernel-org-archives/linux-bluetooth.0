Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 04/22] tools: Fix using old-style initializers
Date: Fri, 10 Feb 2012 18:39:49 -0300
Message-Id: <1328910007-25604-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hcitool.c |    2 +-
 tools/rfcomm.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 5189d8d..66e5c20 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -74,7 +74,7 @@ static void usage(void);
 
 static int dev_info(int s, int dev_id, long arg)
 {
-	struct hci_dev_info di = { dev_id: dev_id };
+	struct hci_dev_info di = { .dev_id = dev_id };
 	char addr[18];
 
 	if (ioctl(s, HCIGETDEVINFO, (void *) &di))
diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index 6800445..e73b0ba 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -673,7 +673,7 @@ static void cmd_show(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 	if (strcmp(argv[0], "all") == 0)
 		print_dev_list(ctl, 0);
 	else {
-		struct rfcomm_dev_info di = { id: atoi(argv[0]) };
+		struct rfcomm_dev_info di = { .id = atoi(argv[0]) };
 		if (ioctl(ctl, RFCOMMGETDEVINFO, &di) < 0) {
 			perror("Get info failed");
 			exit(1);
-- 
1.7.8.1

