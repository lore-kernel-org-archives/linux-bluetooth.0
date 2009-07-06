Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] test/hciemu.c: verbose usage message
Date: Mon,  6 Jul 2009 18:05:03 +0200
Message-Id: <1246896305-26018-1-git-send-email-filippo@esaurito.net>
In-Reply-To: <1246890054-13479-2-git-send-email-filippo@esaurito.net>
References: <1246890054-13479-2-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/hciemu.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/test/hciemu.c b/test/hciemu.c
index 9f651bc..68fabb0 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -1172,7 +1172,13 @@ static void usage(void)
 {
 	printf("hciemu - HCI emulator ver %s\n", VERSION);
 	printf("Usage: \n");
-	printf("\thciemu [-n] local_address\n");
+	printf("\thciemu [options] local_address\n"
+		"Options:\n"
+		"\t[-d device] use specified device\n"
+		"\t[-b bdaddr] emulate specified address\n"
+		"\t[-s file] create snoop file\n"
+		"\t[-n] do not detach\n"
+		"\t[-h] help, you are looking at it\n");
 }
 
 static struct option main_options[] = {
-- 
1.6.3.3

