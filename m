Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH v2 7/7] Add Write Request in interactive gatttool
Date: Tue, 22 Feb 2011 16:12:04 -0300
Message-Id: <1298401924-20094-7-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1298401924-20094-1-git-send-email-sheldon.demario@openbossa.org>
References: <1298401924-20094-1-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
References: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---

Add forgoten conn_state check on cmd_char_write_req()

 attrib/interactive.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index a1c5671..9af3daa 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -487,6 +487,56 @@ static void cmd_read_uuid(int argcp, char **argvp)
 	return;
 }
 
+static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	if (status != 0) {
+		printf("Characteristic Write Request failed: "
+						"%s\n", att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_write_resp(pdu, plen)) {
+		printf("Protocol error\n");
+		return;
+	}
+
+	printf("Characteristic value was written successfully\n");
+}
+
+static void cmd_char_write_req(int argcp, char **argvp)
+{
+	uint8_t *value;
+	size_t plen;
+	int handle;
+
+	if (conn_state != STATE_CONNECTED) {
+		printf("Command failed: disconnected\n");
+		return;
+	}
+
+	if (argcp < 3) {
+		printf("Usage: char-write-req <handle> <new value>\n");
+		return;
+	}
+
+	handle = strtoll(argvp[1], NULL, 16);
+	if (errno != 0 || handle <= 0) {
+		printf("A valid handle is required\n");
+		return;
+	}
+
+	plen = gatt_attr_data_from_string(argvp[2], &value);
+	if (plen == 0) {
+		g_printerr("Invalid value\n");
+		return;
+	}
+
+	gatt_write_char(attrib, handle, value, plen, char_write_req_cb, NULL);
+
+	g_free(value);
+}
+
 static struct {
 	const char *cmd;
 	void (*func)(int argcp, char **argvp);
@@ -511,6 +561,8 @@ static struct {
 		"Characteristics Value/Descriptor Read by handle" },
 	{ "char-read-uuid",	cmd_read_uuid,	"<UUID> [start hnd] [end hnd]",
 		"Characteristics Value/Descriptor Read by UUID" },
+	{ "char-write-req",	cmd_char_write_req,	"<handle> <new value>",
+		"Characteristic Value Write (Write Request)" },
 	{ NULL, NULL, NULL}
 };
 
-- 
1.7.1

