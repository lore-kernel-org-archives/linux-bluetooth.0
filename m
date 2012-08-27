Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 07/33] btmgmt: Add set controller data support
Date: Mon, 27 Aug 2012 13:02:59 -0400
Message-Id: <1346087005-24693-8-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add new command set-data for running the Set Controller Data operation
from MGMT API.
---
 tools/btmgmt.c |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 5cc3198..628d21b 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1813,6 +1813,89 @@ done:
 	}
 }
 
+static void set_data_rsp(int mgmt_sk, uint16_t op, uint16_t id, uint8_t status,
+				void *rsp, uint16_t len, void *user_data)
+{
+	if (status != 0) {
+		fprintf(stderr, "Unable to set controller data. status 0x%02x"
+				" (%s)\n", status, mgmt_errstr(status));
+		exit(EXIT_FAILURE);
+	}
+
+	exit(EXIT_SUCCESS);
+}
+
+static void set_data_usage(void)
+{
+	printf("Usage: btmgmt set_data [-p] <data type> <byte array>\n");
+	printf("\nexample: btmgmt set_data -p 0xff 11 11 aa bb cc\n");
+	printf("\nparameters:\n");
+	printf("\t<data type>: 0x16 (service data) or 0xff (manufacturer\n"
+		"\t specific data). Values different from that will return\n"
+		"\t error from kernel.\n");
+	printf("\t<byte array>: two bytes (service uuid or company identifier\n"
+		"\t code) following by hex encoded bytes (data).\n");
+}
+
+static struct option set_data_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ "priority",	1, 0, 'p' },
+	{ 0, 0, 0, 0 }
+};
+
+static void cmd_set_data(int mgmt_sk, uint16_t index, int argc, char **argv)
+{
+	struct mgmt_cp_set_controller_data *cp;
+	uint8_t data_len, flags = 0;
+	unsigned int i;
+	int opt;
+
+	while ((opt = getopt_long(argc, argv, "+ph", set_data_options,
+								NULL)) != -1) {
+		switch (opt) {
+		case 'p':
+			flags = MGMT_DATA_HIGH_PRIORITY;
+			break;
+		case 'h':
+		default:
+			set_data_usage();
+			exit(EXIT_SUCCESS);
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc < 1) {
+		set_data_usage();
+		exit(EXIT_FAILURE);
+	}
+
+	data_len = argc - 1;
+	cp = malloc(sizeof(*cp) + data_len);
+	cp->flags = flags;
+	sscanf(argv[0], "%hhx", &cp->data_type);
+
+	for (i = 0; i < data_len; i++)
+		sscanf(argv[i + 1], "%hhx", &cp->data[i]);
+
+	cp->data_length = data_len;
+
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	if (mgmt_send_cmd(mgmt_sk, MGMT_OP_SET_CONTROLLER_DATA, index,
+						cp, sizeof(*cp) + data_len,
+						set_data_rsp, NULL) < 0) {
+		free(cp);
+		fprintf(stderr, "Unable to send set controller data cmd\n");
+		exit(EXIT_FAILURE);
+	}
+
+	free(cp);
+}
+
 static struct {
 	char *cmd;
 	void (*func)(int mgmt_sk, uint16_t index, int argc, char **argv);
@@ -1846,6 +1929,7 @@ static struct {
 	{ "did",	cmd_did,	"Set Device ID",		},
 	{ "broadcaster",cmd_broadcaster,"Toggle Broadcaster Mode",	},
 	{ "observer",	cmd_observer,	"Toggle Observer Mode",		},
+	{ "set-data",	cmd_set_data,	"Set Controller Data",		},
 	{ NULL, NULL, 0 }
 };
 
-- 
1.7.9.5

