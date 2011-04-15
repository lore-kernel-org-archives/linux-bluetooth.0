Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 4/4] hcimgmt: add support for setting pairable mode
Date: Fri, 15 Apr 2011 14:57:45 -0300
Message-Id: <1302890265-15649-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302890265-15649-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302890265-15649-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hcimgmt.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 54 insertions(+), 1 deletions(-)

diff --git a/tools/hcimgmt.c b/tools/hcimgmt.c
index 7744344..9998982 100644
--- a/tools/hcimgmt.c
+++ b/tools/hcimgmt.c
@@ -407,6 +407,58 @@ static void cmd_clearkeys(int dev_id, int argc, char **argv)
 	}
 }
 
+static struct option pairable_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char *pairable_help =
+	"Usage:\n"
+	"\tclearkeys <1|0>\n";
+
+static void cmd_pairable(int dev_id, int argc, char **argv)
+{
+	int opt, dd;
+	ssize_t ret;
+	struct mgmt_mode cp;
+
+	for_each_opt(opt, pairable_options, NULL) {
+		switch (opt) {
+		default:
+			printf("%s", pairable_help);
+			return;
+		}
+	}
+
+	helper_arg(1, 1, &argc, &argv, pairable_help);
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
+	cp.val = (uint8_t) strtol(argv[0], NULL, 0);
+
+	ret = hci_mgmt_cmd(dd, dev_id, MGMT_OP_SET_PAIRABLE, &cp, sizeof(cp),
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
@@ -417,7 +469,8 @@ static struct {
 	{ "features",	cmd_features,	"Control API features"	},
 	{ "info",	cmd_info,	"Read controller info"	},
 	{ "setiocap",	cmd_setiocap,	"Set IO Capabilities"	},
-	{ "clearkeys",  cmd_clearkeys,	"Clear key list"	},
+	{ "clearkeys",	cmd_clearkeys,	"Clear key list"	},
+	{ "pairable",	cmd_pairable,	"Set pairable mode"	},
 	{ NULL, NULL, 0 }
 };
 
-- 
1.7.4.3

