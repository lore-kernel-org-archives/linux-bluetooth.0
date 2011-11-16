Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 07/17] hcitool: Fix errno handling convention
Date: Wed, 16 Nov 2011 09:19:54 -0400
Message-Id: <1321449604-4188-8-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variables which are assigned to the errno variable (usually called
"err") should be negative, and "-err" should be used where a positive
value is needed.
---
 tools/hcitool.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 5c4a0bc..5189d8d 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2696,9 +2696,9 @@ static void cmd_lewladd(int dev_id, int argc, char **argv)
 	hci_close_dev(dd);
 
 	if (err < 0) {
-		err = errno;
+		err = -errno;
 		fprintf(stderr, "Can't add to white list: %s(%d)\n",
-							strerror(err), err);
+							strerror(-err), -err);
 		exit(1);
 	}
 }
@@ -2786,9 +2786,9 @@ static void cmd_lewlsz(int dev_id, int argc, char **argv)
 	hci_close_dev(dd);
 
 	if (err < 0) {
-		err = errno;
+		err = -errno;
 		fprintf(stderr, "Can't read white list size: %s(%d)\n",
-							strerror(err), err);
+							strerror(-err), -err);
 		exit(1);
 	}
 
@@ -2831,9 +2831,9 @@ static void cmd_lewlclr(int dev_id, int argc, char **argv)
 	hci_close_dev(dd);
 
 	if (err < 0) {
-		err = errno;
+		err = -errno;
 		fprintf(stderr, "Can't clear white list: %s(%d)\n",
-							strerror(err), err);
+							strerror(-err), -err);
 		exit(1);
 	}
 }
@@ -2961,9 +2961,9 @@ static void cmd_lecup(int dev_id, int argc, char **argv)
 
 	if (hci_le_conn_update(dd, htobs(handle), htobs(min), htobs(max),
 				htobs(latency), htobs(timeout), 5000) < 0) {
-		int err = errno;
+		int err = -errno;
 		fprintf(stderr, "Could not change connection params: %s(%d)\n",
-							strerror(err), err);
+							strerror(-err), -err);
 	}
 
 	hci_close_dev(dd);
-- 
1.7.0.4

