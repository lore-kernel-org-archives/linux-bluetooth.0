Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 08/33] btmgmt: Add unset controller data support
Date: Mon, 27 Aug 2012 13:03:00 -0400
Message-Id: <1346087005-24693-9-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add new command unset-data for running the Unset Controller Data
operation from MGMT API.
---
 tools/btmgmt.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 628d21b..44c4db8 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1896,6 +1896,45 @@ static void cmd_set_data(int mgmt_sk, uint16_t index, int argc, char **argv)
 	free(cp);
 }
 
+static void unset_data_rsp(int mgmt_sk, uint16_t op, uint16_t id,
+		uint8_t status, void *rsp, uint16_t len, void *user_data)
+{
+	if (status != 0) {
+		fprintf(stderr, "Unable to unset controller data. status 0x%02x"
+				" (%s)\n", status, mgmt_errstr(status));
+		exit(EXIT_FAILURE);
+	}
+
+	exit(EXIT_SUCCESS);
+}
+
+static void cmd_unset_data(int mgmt_sk, uint16_t index, int argc, char **argv)
+{
+	struct mgmt_cp_unset_controller_data cp;
+
+	if (argc < 2) {
+		printf("Usage: btmgmt %s <data type>\n", argv[0]);
+		printf("\nexample: btmgmt %s 0xff\n", argv[0]);
+		printf("\nparameters:\n");
+		printf("\t<data type>: 0x16 (service data) or 0xff\n"
+				"\t(manufacturer specific data).\n");
+
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	sscanf(argv[1], "%hhx", &cp.data_type);
+
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	if (mgmt_send_cmd(mgmt_sk, MGMT_OP_UNSET_CONTROLLER_DATA, index,
+				&cp, sizeof(cp), unset_data_rsp, NULL) < 0) {
+		fprintf(stderr, "Unable to send unset controller data cmd\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
 static struct {
 	char *cmd;
 	void (*func)(int mgmt_sk, uint16_t index, int argc, char **argv);
@@ -1930,6 +1969,7 @@ static struct {
 	{ "broadcaster",cmd_broadcaster,"Toggle Broadcaster Mode",	},
 	{ "observer",	cmd_observer,	"Toggle Observer Mode",		},
 	{ "set-data",	cmd_set_data,	"Set Controller Data",		},
+	{ "unset-data",	cmd_unset_data,	"Unset Controller Data",	},
 	{ NULL, NULL, 0 }
 };
 
-- 
1.7.9.5

