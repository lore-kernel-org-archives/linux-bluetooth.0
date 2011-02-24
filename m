Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH v3 4/7] Add Characteristics Descriptor Discovery option in interactive gatttool
Date: Thu, 24 Feb 2011 10:54:09 -0300
Message-Id: <1298555649-5529-1-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
References: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---

Remove return statements at the end of void functions.

 attrib/interactive.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index ed45894..b00d0bc 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -169,6 +169,47 @@ static void char_cb(GSList *characteristics, guint8 status, gpointer user_data)
 	rl_forced_update_display();
 }
 
+static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct att_data_list *list;
+	guint8 format;
+	int i;
+
+	if (status != 0) {
+		printf("Discover all characteristic descriptors failed: "
+						"%s\n", att_ecode2str(status));
+		return;
+	}
+
+	list = dec_find_info_resp(pdu, plen, &format);
+	if (list == NULL)
+		return;
+
+	printf("\n");
+	for (i = 0; i < list->num; i++) {
+		char uuidstr[MAX_LEN_UUID_STR];
+		uint16_t handle;
+		uint8_t *value;
+		uuid_t uuid;
+
+		value = list->data[i];
+		handle = att_get_u16(value);
+
+		if (format == 0x01)
+			sdp_uuid16_create(&uuid, att_get_u16(&value[2]));
+		else
+			sdp_uuid128_create(&uuid, &value[2]);
+
+		sdp_uuid2strn(&uuid, uuidstr, MAX_LEN_UUID_STR);
+		printf("handle: 0x%04x, uuid: %s\n", handle, uuidstr);
+	}
+
+	att_data_list_free(list);
+
+	rl_forced_update_display();
+}
+
 static void cmd_exit(int argcp, char **argvp)
 {
 	rl_callback_handler_remove();
@@ -287,6 +328,22 @@ static void cmd_char(int argcp, char **argvp)
 	return;
 }
 
+static void cmd_char_desc(int argcp, char **argvp)
+{
+	int start = 0x0001;
+	int end = 0xffff;
+
+	if (conn_state != STATE_CONNECTED) {
+		printf("Command failed: disconnected\n");
+		return;
+	}
+
+	if (set_handles(&start, &end, argcp, argvp))
+		return;
+
+	gatt_find_info(attrib, start, end, char_desc_cb, NULL);
+}
+
 static struct {
 	const char *cmd;
 	void (*func)(int argcp, char **argvp);
@@ -305,6 +362,8 @@ static struct {
 		"Primary Service Discovery" },
 	{ "characteristics",	cmd_char,	"[start hnd] [end hnd]",
 		"Characteristics Discovery" },
+	{ "char-desc",		cmd_char_desc,	"[start hnd] [end hnd]",
+		"Characteristics Descriptor Discovery" },
 	{ NULL, NULL, NULL}
 };
 
-- 
1.7.1

