Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 12/22] ipctest: Fix using the format specifier "as"
Date: Fri, 10 Feb 2012 18:39:57 -0300
Message-Id: <1328910007-25604-13-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This format specifier is GNU specific.
---
 test/ipctest.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/test/ipctest.c b/test/ipctest.c
index cbfd78d..012de0a 100644
--- a/test/ipctest.c
+++ b/test/ipctest.c
@@ -987,10 +987,10 @@ static gboolean input_cb(GIOChannel *gin, GIOCondition condition, gpointer data)
 	}
 
 	IF_CMD(debug) {
-		char *what = NULL;
+		char what[15];
 		int enable;
 
-		if (sscanf(line, "%*s %as %d", &what, &enable) != 1)
+		if (sscanf(line, "%*s %s %d", what, &enable) != 1)
 			DBG("debug [stream_read|stream_write] [0|1]");
 		if (strncmp(what, "stream_read", 12) == 0) {
 			u->debug_stream_read = enable;
@@ -1030,7 +1030,8 @@ static gboolean input_cb(GIOChannel *gin, GIOCondition condition, gpointer data)
 	IF_CMD(bdaddr) {
 		char *address;
 
-		if (sscanf(line, "%*s %as", &address) != 1)
+		address = calloc(18, sizeof(char));
+		if (sscanf(line, "%*s %s", address) != 1)
 			DBG("set with bdaddr BDADDR");
 
 		free(u->address);
@@ -1040,9 +1041,9 @@ static gboolean input_cb(GIOChannel *gin, GIOCondition condition, gpointer data)
 	}
 
 	IF_CMD(profile) {
-		char *profile = NULL;
+		char profile[6];
 
-		if (sscanf(line, "%*s %as", &profile) != 1)
+		if (sscanf(line, "%*s %s", profile) != 1)
 			DBG("set with profile [hsp|a2dp]");
 		if (strncmp(profile, "hsp", 4) == 0) {
 			u->transport = BT_CAPABILITIES_TRANSPORT_SCO;
@@ -1052,7 +1053,6 @@ static gboolean input_cb(GIOChannel *gin, GIOCondition condition, gpointer data)
 			DBG("set with profile [hsp|a2dp]");
 		}
 
-		free(profile);
 		DBG("profile %s", u->transport == BT_CAPABILITIES_TRANSPORT_SCO ?
 			"hsp" : "a2dp");
 	}
-- 
1.7.8.1

