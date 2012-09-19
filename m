Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1] gatttool: Fix Characteristic descriptor discovery
Date: Wed, 19 Sep 2012 16:37:56 -0300
Message-Id: <1348083476-21435-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <CAJdJm_OSzp9i_ox380aFJvrTWwUKUeR2OYeZQDPvoBxSXvYYjw@mail.gmail.com>
References: <CAJdJm_OSzp9i_ox380aFJvrTWwUKUeR2OYeZQDPvoBxSXvYYjw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes end condition for Characteristic Descriptor Discovery.
This sub-procedure is complete when the Error Response is received and
the Error Code is set to Attribute Not Found or the Find Information
Response has an Attribute Handle that is equal to the Ending Handle of
the request.
---
 attrib/interactive.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 1b0edf4..1b0b9cf 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -48,6 +48,8 @@ static gchar *opt_dst_type = NULL;
 static gchar *opt_sec_level = NULL;
 static int opt_psm = 0;
 static int opt_mtu = 0;
+static int start;
+static int end;
 
 struct characteristic_data {
 	uint16_t orig_start;
@@ -265,11 +267,12 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 {
 	struct att_data_list *list;
 	guint8 format;
+	uint16_t handle = 0xffff;
 	int i;
 
 	if (status != 0) {
-		printf("Discover all characteristic descriptors failed: "
-						"%s\n", att_ecode2str(status));
+		printf("Discover descriptors finished: %s\n",
+						att_ecode2str(status));
 		return;
 	}
 
@@ -280,7 +283,6 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	printf("\n");
 	for (i = 0; i < list->num; i++) {
 		char uuidstr[MAX_LEN_UUID_STR];
-		uint16_t handle;
 		uint8_t *value;
 		bt_uuid_t uuid;
 
@@ -298,7 +300,10 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	att_data_list_free(list);
 
-	rl_forced_update_display();
+	if (handle != 0xffff && handle < end)
+		gatt_find_info(attrib, handle + 1, end, char_desc_cb, NULL);
+	else
+		rl_forced_update_display();
 }
 
 static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
@@ -527,9 +532,6 @@ static void cmd_char(int argcp, char **argvp)
 
 static void cmd_char_desc(int argcp, char **argvp)
 {
-	int start = 0x0001;
-	int end = 0xffff;
-
 	if (conn_state != STATE_CONNECTED) {
 		printf("Command failed: disconnected\n");
 		return;
@@ -541,7 +543,8 @@ static void cmd_char_desc(int argcp, char **argvp)
 			printf("Invalid start handle: %s\n", argvp[1]);
 			return;
 		}
-	}
+	} else
+		start = 0x0001;
 
 	if (argcp > 2) {
 		end = strtohandle(argvp[2]);
@@ -549,7 +552,8 @@ static void cmd_char_desc(int argcp, char **argvp)
 			printf("Invalid end handle: %s\n", argvp[2]);
 			return;
 		}
-	}
+	} else
+		end = 0xffff;
 
 	gatt_find_info(attrib, start, end, char_desc_cb, NULL);
 }
-- 
1.7.12

