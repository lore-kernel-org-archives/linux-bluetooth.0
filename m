Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH] Fix hciconfig leadv returned response.
Date: Mon, 31 Jan 2011 15:57:33 -0300
Message-Id: <1296500253-11888-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes hciconfig leadv returned response by treating both status of the command
execution and HCI error code.
---
 tools/hciconfig.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index c271d14..05a8910 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -269,11 +269,20 @@ static void cmd_le_adv(int ctl, int hdev, char *opt)
 	rq.rlen = 1;
 
 	ret = hci_send_req(dd, &rq, 100);
-	if (status || ret < 0)
+
+	hci_close_dev(dd);
+
+	if (ret < 0) {
 		fprintf(stderr, "Can't set advertise mode on hci%d: %s (%d)\n",
 						hdev, strerror(errno), errno);
+		exit(1);
+	}
 
-	hci_close_dev(dd);
+	if (status) {
+		fprintf(stderr, "LE set advertise enable on hci%d returned status %d\n",
+						hdev, status);
+		exit(1);
+	}
 }
 
 static void cmd_le_states(int ctl, int hdev, char *opt)
@@ -302,7 +311,7 @@ static void cmd_le_states(int ctl, int hdev, char *opt)
 
 	err = hci_send_req(dd, &rq, 1000);
 
-	close(dd);
+	hci_close_dev(dd);
 
 	if (err < 0) {
 		fprintf(stderr, "Can't read LE supported states on hci%d:"
-- 
1.7.1

