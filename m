Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 2/4] hcimgmt: Add command to set IO Capabilities
Date: Fri, 15 Apr 2011 14:57:43 -0300
Message-Id: <1302890265-15649-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302890265-15649-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302890265-15649-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hcimgmt.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/tools/hcimgmt.c b/tools/hcimgmt.c
index 99338ed..fc88654 100644
--- a/tools/hcimgmt.c
+++ b/tools/hcimgmt.c
@@ -46,6 +46,31 @@
 
 #define for_each_opt(opt, long, short) while ((opt=getopt_long(argc, argv, short ? short:"+", long, NULL)) != -1)
 
+static void helper_arg(int min_num_arg, int max_num_arg, int *argc,
+			char ***argv, const char *usage)
+{
+	*argc -= optind;
+	/* too many arguments, but when "max_num_arg < min_num_arg" then no
+		 limiting (prefer "max_num_arg=-1" to gen infinity)
+	*/
+	if ( (*argc > max_num_arg) && (max_num_arg >= min_num_arg ) ) {
+		fprintf(stderr, "%s: too many arguments (maximal: %i)\n",
+				*argv[0], max_num_arg);
+		printf("%s", usage);
+		exit(1);
+	}
+
+	/* print usage */
+	if (*argc < min_num_arg) {
+		fprintf(stderr, "%s: too few arguments (minimal: %i)\n",
+				*argv[0], min_num_arg);
+		printf("%s", usage);
+		exit(0);
+	}
+
+	*argv += optind;
+}
+
 static void usage(void);
 
 /* Display local devices */
@@ -131,6 +156,9 @@ static ssize_t hci_mgmt_cmd(int dd, uint16_t index, uint16_t opcode, void *data,
 		return -EIO;
 	}
 
+	if (rsp == NULL)
+		return 0;
+
 	/* sizeof(opcode) == 2 */
 	plen = btohs(hdr.len) - 2;
 	copied = rsp_len < plen ? plen : rsp_len;
@@ -278,6 +306,57 @@ static void cmd_info(int dev_id, int argc, char **argv)
 	printf("\n");
 }
 
+static struct option setiocap_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char *setiocap_help =
+	"Usage:\n"
+	"\tsetiocap <value>\n";
+
+static void cmd_setiocap(int dev_id, int argc, char **argv)
+{
+	int opt, dd;
+	ssize_t ret;
+	struct mgmt_cp_set_io_capability cp;
+
+	for_each_opt(opt, setiocap_options, NULL) {
+		switch (opt) {
+		default:
+			printf("%s", setiocap_help);
+			return;
+		}
+	}
+
+	helper_arg(1, 1, &argc, &argv, setiocap_help);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.io_capability = (uint8_t) strtol(argv[0], NULL, 0);
+
+	dd = hci_open_channel(HCI_DEV_NONE, HCI_CHANNEL_CONTROL);
+	if (dd < 0) {
+		perror("HCI Control socket open failed");
+		exit(1);
+	}
+
+	if (dev_id < 0) {
+		dev_id = hci_get_route(NULL);
+		if (dev_id < 0) {
+			perror("Device is not available");
+			exit(1);
+		}
+	}
+
+	ret = hci_mgmt_cmd(dd, dev_id, MGMT_OP_SET_IO_CAPABILITY, &cp, sizeof(cp),
+				MGMT_EV_CMD_COMPLETE, NULL, 0);
+	if (ret < 0) {
+		fprintf(stderr, "Command failed: %s (%zd)\n",
+							strerror(-ret), -ret);
+		exit(1);
+	}
+}
+
 static struct {
 	char *cmd;
 	void (*func)(int dev_id, int argc, char **argv);
@@ -287,6 +366,7 @@ static struct {
 	{ "version",	cmd_version,	"Display version"	},
 	{ "features",	cmd_features,	"Control API features"	},
 	{ "info",	cmd_info,	"Read controller info"	},
+	{ "setiocap",	cmd_setiocap,	"Set IO Capabilities"	},
 	{ NULL, NULL, 0 }
 };
 
-- 
1.7.4.3

