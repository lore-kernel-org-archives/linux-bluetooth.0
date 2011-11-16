Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 08/17] hciconfig: Fix errno handling convention
Date: Wed, 16 Nov 2011 09:19:55 -0400
Message-Id: <1321449604-4188-9-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variables which are assigned to the errno variable (usually called
"err") should be negative, and "-err" should be used where a positive
value is needed.
---
 tools/hciconfig.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index cbd0d0e..35b80b1 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -210,9 +210,9 @@ static void cmd_le_addr(int ctl, int hdev, char *opt)
 
 	dd = hci_open_dev(hdev);
 	if (dd < 0) {
-		err = errno;
+		err = -errno;
 		fprintf(stderr, "Could not open device: %s(%d)\n",
-							strerror(err), err);
+							strerror(-err), -err);
 		exit(1);
 	}
 
@@ -230,9 +230,9 @@ static void cmd_le_addr(int ctl, int hdev, char *opt)
 
 	ret = hci_send_req(dd, &rq, 1000);
 	if (status || ret < 0) {
-		err = errno;
+		err = -errno;
 		fprintf(stderr, "Can't set random address for hci%d: "
-					"%s (%d)\n", hdev, strerror(err), err);
+				"%s (%d)\n", hdev, strerror(-err), -err);
 	}
 
 	hci_close_dev(dd);
-- 
1.7.0.4

