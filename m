Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH 5/7] Add characteristics read options in interactive gatttool
Date: Mon, 21 Feb 2011 19:50:04 -0300
Message-Id: <1298328606-7993-5-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
References: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/interactive.c |  142 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 141 insertions(+), 1 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index 9389686..e9d74b9 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -50,6 +50,13 @@ static gchar *opt_sec_level = NULL;
 static int opt_psm = 0;
 static int opt_mtu = 0;
 
+struct characteristic_data {
+	uint16_t orig_start;
+	uint16_t start;
+	uint16_t end;
+	uuid_t uuid;
+};
+
 static void cmd_help(int argcp, char **argvp);
 
 enum state {
@@ -210,6 +217,79 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	rl_forced_update_display();
 }
 
+static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	uint8_t value[ATT_MAX_MTU];
+	int i, vlen;
+
+	if (status != 0) {
+		printf("Characteristic value/descriptor read failed: %s\n",
+							att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_read_resp(pdu, plen, value, &vlen)) {
+		printf("Protocol error\n");
+		return;
+	}
+
+	printf("\nCharacteristic value/descriptor: ");
+	for (i = 0; i < vlen; i++)
+		printf("%02x ", value[i]);
+	printf("\n");
+
+	rl_forced_update_display();
+}
+
+static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
+					guint16 plen, gpointer user_data)
+{
+	struct characteristic_data *char_data = user_data;
+	struct att_data_list *list;
+	int i;
+
+	if (status == ATT_ECODE_ATTR_NOT_FOUND &&
+				char_data->start != char_data->orig_start)
+		goto done;
+
+	if (status != 0) {
+		printf("Read characteristics by UUID failed: %s\n",
+							att_ecode2str(status));
+		goto done;
+	}
+
+	list = dec_read_by_type_resp(pdu, plen);
+	if (list == NULL)
+		goto done;
+
+	for (i = 0; i < list->num; i++) {
+		uint8_t *value = list->data[i];
+		int j;
+
+		char_data->start = att_get_u16(value) + 1;
+
+		printf("\nhandle: 0x%04x \t value: ", att_get_u16(value));
+		value += 2;
+		for (j = 0; j < list->len - 2; j++, value++)
+			printf("%02x ", *value);
+		printf("\n");
+	}
+
+	att_data_list_free(list);
+
+	gatt_read_char_by_uuid(attrib, char_data->start, char_data->end,
+					&char_data->uuid, char_read_by_uuid_cb,
+					char_data);
+
+	rl_forced_update_display();
+
+	return;
+
+done:
+	g_free(char_data);
+}
+
 static void cmd_exit(int argcp, char **argvp)
 {
 	rl_callback_handler_remove();
@@ -346,6 +426,62 @@ static void cmd_char_desc(int argcp, char **argvp)
 	return;
 }
 
+static void cmd_read_hnd(int argcp, char **argvp)
+{
+	int handle;
+
+	if (argcp < 2) {
+		printf("Missing argument: handle\n");
+		return;
+	}
+
+	if (strtohandle(&handle, argvp[1])) {
+		printf("Invalid handle: %s\n", argvp[1]);
+		return;
+	}
+
+	gatt_read_char(attrib, handle, char_read_cb, attrib);
+
+	return;
+}
+
+static void cmd_read_uuid(int argcp, char **argvp)
+{
+	struct characteristic_data *char_data;
+	int start = 0x0001;
+	int end = 0xffff;
+	uuid_t uuid;
+
+	if (conn_state != STATE_CONNECTED) {
+		printf("Command failed: disconnected\n");
+		return;
+	}
+
+	if (argcp < 2) {
+		printf("Missing argument: UUID\n");
+		return;
+	}
+
+	if (bt_string2uuid(&uuid, argvp[1]) < 0) {
+		printf("Invalid UUID\n");
+		return;
+	}
+
+	if (set_handles(&start, &end, argcp - 1, argvp + 1))
+		return;
+
+	char_data = g_new(struct characteristic_data, 1);
+	char_data->orig_start = start;
+	char_data->start = start;
+	char_data->end = end;
+	char_data->uuid = uuid;
+
+	gatt_read_char_by_uuid(attrib, start, end, &char_data->uuid,
+					char_read_by_uuid_cb, char_data);
+
+	return;
+}
+
 static struct {
 	const char *cmd;
 	void (*func)(int argcp, char **argvp);
@@ -366,6 +502,10 @@ static struct {
 		"Characteristics Discovery" },
 	{ "char-desc",		cmd_char_desc,	"[start hnd] [end hnd]",
 		"Characteristics Descriptor Discovery" },
+	{ "char-read-hnd",	cmd_read_hnd,	"<handle>",
+		"Characteristics Value/Descriptor Read by handle" },
+	{ "char-read-uuid",	cmd_read_uuid,	"<UUID> [start hnd] [end hnd]",
+		"Characteristics Value/Descriptor Read by UUID" },
 	{ NULL, NULL, NULL}
 };
 
@@ -374,7 +514,7 @@ static void cmd_help(int argcp, char **argvp)
 	int i;
 
 	for (i = 0; commands[i].cmd; i++)
-		printf("%-15s %-25s %s\n", commands[i].cmd,
+		printf("%-15s %-30s %s\n", commands[i].cmd,
 				commands[i].params, commands[i].desc);
 }
 
-- 
1.7.1

