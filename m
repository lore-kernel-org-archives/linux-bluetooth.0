Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/7] btmgmt: Add support for setting Device ID
Date: Fri, 16 Mar 2012 15:41:51 +0100
Message-ID: <1331908913-10330-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1331908913-10330-1-git-send-email-szymon.janc@tieto.com>
References: <1331908913-10330-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mgmt/main.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/mgmt/main.c b/mgmt/main.c
index 4f10e08..ec97136 100644
--- a/mgmt/main.c
+++ b/mgmt/main.c
@@ -1730,6 +1730,70 @@ static void cmd_clr_uuids(int mgmt_sk, uint16_t index, int argc, char **argv)
 	cmd_remove_uuid(mgmt_sk, index, 2, rm_argv);
 }
 
+static void did_rsp(int mgmt_sk, uint16_t op, uint16_t id, uint8_t status,
+				void *rsp, uint16_t len, void *user_data)
+{
+	if (status != 0) {
+		fprintf(stderr, "Set Device ID failed with status 0x%02x (%s)\n",
+						status, mgmt_errstr(status));
+		exit(EXIT_FAILURE);
+	}
+
+	printf("Device ID succesfully set\n");
+
+	exit(EXIT_SUCCESS);
+}
+
+static void did_usage(void)
+{
+	printf("Usage: btmgmt did <source>:<vendor>:<product>:<version>\n");
+	printf("       possible source values: bluetooth, usb\n");
+}
+
+static void cmd_did(int mgmt_sk, uint16_t index, int argc, char **argv)
+{
+	struct mgmt_cp_set_device_id cp;
+	uint16_t vendor, product, version , source;
+	int result;
+
+	if (argc < 2) {
+		did_usage();
+		exit(EXIT_FAILURE);
+	}
+
+	result = sscanf(argv[1], "bluetooth:%4hx:%4hx:%4hx", &vendor, &product,
+								&version);
+	if (result != EOF && result == 3) {
+		source = 0x0001;
+		goto done;
+	}
+
+	result = sscanf(argv[1], "usb:%4hx:%4hx:%4hx", &vendor, &product,
+								&version);
+	if (result != EOF && result == 3) {
+		source = 0x0002;
+		goto done;
+	}
+
+	did_usage();
+	exit(EXIT_FAILURE);
+
+done:
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	cp.source = htobs(source);
+	cp.vendor = htobs(vendor);
+	cp.product = htobs(product);
+	cp.version = htobs(version);
+
+	if (mgmt_send_cmd(mgmt_sk, MGMT_OP_SET_DEVICE_ID, index,
+				&cp, sizeof(cp), did_rsp, NULL) < 0) {
+		fprintf(stderr, "Unable to send set_dev_class cmd\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
 static struct {
 	char *cmd;
 	void (*func)(int mgmt_sk, uint16_t index, int argc, char **argv);
@@ -1760,6 +1824,7 @@ static struct {
 	{ "add-uuid",	cmd_add_uuid,	"Add UUID"			},
 	{ "rm-uuid",	cmd_add_uuid,	"Remove UUID"			},
 	{ "clr-uuids",	cmd_clr_uuids,	"Clear UUIDs",			},
+	{ "did",	cmd_did,	"Set Device ID",		},
 	{ NULL, NULL, 0 }
 };
 
-- 
on behalf of ST-Ericsson

