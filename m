Return-Path: <cyrus@holtmann.org>
From: Michael Knudsen <michaelknudsendk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Knudsen <m.knudsen@samsung.com>
Subject: [PATCH 2/3] Bluetooth:  Support the read codecs operation
Date: Thu, 22 Nov 2012 13:47:47 +0100
Message-Id: <1353588468-28711-3-git-send-email-m.knudsen@samsung.com>
In-Reply-To: <1353588468-28711-1-git-send-email-m.knudsen@samsung.com>
References: <1353588468-28711-1-git-send-email-m.knudsen@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/mgmt.h     |    8 ++++++
 tools/btmgmt.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 6c7e44a..37b002c 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -318,6 +318,13 @@ struct mgmt_cp_set_device_id {
 	uint16_t version;
 } __packed;
 
+#define MGMT_OP_READ_CODECS            0x0029
+struct mgmt_rp_read_codecs {
+       uint8_t	count;
+       uint8_t	codec[0];
+} __packed;
+
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -496,6 +503,7 @@ static const char *mgmt_op[] = {
 	"Block Device",
 	"Unblock Device",
 	"Set Device ID",
+	"Read Codecs",
 };
 
 static const char *mgmt_ev[] = {
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index ff6a46a..857c3a8 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -993,6 +993,79 @@ static void cmd_info(int mgmt_sk, uint16_t index, int argc, char **argv)
 	}
 }
 
+struct codecs_map {
+	int codec;
+	char *name;
+} codecs_map[] = {
+	{ HCI_FORMAT_ULAW,		"uLAW" },
+	{ HCI_FORMAT_ALAW,		"aLAW" },
+	{ HCI_FORMAT_CVSD,		"CVSD" },
+	{ HCI_FORMAT_TRANSPARENT,	"transparent" },
+	{ HCI_FORMAT_PCM,		"PCM" },
+	{ HCI_FORMAT_MSBC,		"mSBC" },
+	{ HCI_FORMAT_VENDOR,		"vendor" },
+	{ -1 },
+};
+
+static void codecs_rsp(int mgmt_sk, uint16_t op, uint16_t id, uint8_t status,
+				void *rsp, uint16_t len, void *user_data)
+{
+	struct mgmt_rp_read_codecs *rp = rsp;
+	char addr[18];
+	int i, count;
+
+	if (status != 0) {
+		fprintf(stderr,
+			"Reading hci%u info failed with status 0x%02x (%s)\n",
+					id, status, mgmt_errstr(status));
+		exit(EXIT_FAILURE);
+	}
+
+	if (len < sizeof(*rp)) {
+		fprintf(stderr, "Too small codecs reply (%u bytes)\n", len);
+		exit(EXIT_FAILURE);
+	}
+
+	count = rp->count;
+
+	printf("hci%u:\tnumber of codecs: %u\n", id, count);
+
+	for (i = 0; i < count; i++) {
+		int entry;
+		struct codecs_map *p;
+
+		entry = rp->codec[i];
+
+		p = codecs_map;
+
+		while (p->codec != -1) {
+			if (entry == p->codec)
+				break;
+			else
+				p++;
+		}
+
+		if (p->codec != -1)
+			printf("\t%s (0x%x)\n", p->name, p->codec);
+		else
+			printf("\tunknown (0x%x)\n", p->codec);
+	}
+
+	exit(EXIT_SUCCESS);
+}
+
+static void cmd_codecs(int mgmt_sk, uint16_t index, int argc, char **argv)
+{
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	if (mgmt_send_cmd(mgmt_sk, MGMT_OP_READ_CODECS, index, NULL,
+						0, codecs_rsp, NULL) < 0) {
+		fprintf(stderr, "Unable to send read_info cmd\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
 static void setting_rsp(int mgmt_sk, uint16_t op, uint16_t id, uint8_t status,
 				void *rsp, uint16_t len, void *user_data)
 {
@@ -1824,6 +1897,7 @@ static struct {
 	{ "version",	cmd_version,	"Get the MGMT Version"		},
 	{ "commands",	cmd_commands,	"List supported commands"	},
 	{ "info",	cmd_info,	"Show controller info"		},
+	{ "codecs",	cmd_codecs,	"List supported codecs"		},
 	{ "power",	cmd_power,	"Toggle powered state"		},
 	{ "discov",	cmd_discov,	"Toggle discoverable state"	},
 	{ "connectable",cmd_connectable,"Toggle connectable state"	},
-- 
1.7.9.5

