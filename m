Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 3/4] Add command to clear the link key list via MGMT interface
Date: Fri, 15 Apr 2011 14:57:44 -0300
Message-Id: <1302890265-15649-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302890265-15649-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302890265-15649-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hcimgmt.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/tools/hcimgmt.c b/tools/hcimgmt.c
index fc88654..7744344 100644
--- a/tools/hcimgmt.c
+++ b/tools/hcimgmt.c
@@ -357,6 +357,56 @@ static void cmd_setiocap(int dev_id, int argc, char **argv)
 	}
 }
 
+static struct option clearkeys_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char *clearkeys_help =
+	"Usage:\n"
+	"\tclearkeys\n";
+
+static void cmd_clearkeys(int dev_id, int argc, char **argv)
+{
+	int opt, dd;
+	ssize_t ret;
+	struct mgmt_cp_load_keys cp;
+
+	for_each_opt(opt, clearkeys_options, NULL) {
+		switch (opt) {
+		default:
+			printf("%s", clearkeys_help);
+			return;
+		}
+	}
+
+	helper_arg(0, 0, &argc, &argv, setiocap_help);
+
+	memset(&cp, 0, sizeof(cp));
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
+	ret = hci_mgmt_cmd(dd, dev_id, MGMT_OP_LOAD_KEYS, &cp, sizeof(cp),
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
@@ -367,6 +417,7 @@ static struct {
 	{ "features",	cmd_features,	"Control API features"	},
 	{ "info",	cmd_info,	"Read controller info"	},
 	{ "setiocap",	cmd_setiocap,	"Set IO Capabilities"	},
+	{ "clearkeys",  cmd_clearkeys,	"Clear key list"	},
 	{ NULL, NULL, 0 }
 };
 
-- 
1.7.4.3

