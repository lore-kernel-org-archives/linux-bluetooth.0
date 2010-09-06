Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH v3] hciconfig: add LE_SET_ADVERTISE_ENABLE cmd
Date: Mon,  6 Sep 2010 11:18:16 -0400
Message-Id: <1283786296-16211-1-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements two new hciconfig commands: leadv and noleadv.
These new hciconfig flags are responsible to LE_SET_ADVERTISE_ENABLE
command implementation.
---
 tools/hciconfig.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 87dd127..3627b7c 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -149,6 +149,44 @@ static void cmd_scan(int ctl, int hdev, char *opt)
 	}
 }
 
+static void cmd_le_adv(int ctl, int hdev, char *opt)
+{
+	struct hci_request rq;
+	le_set_advertise_enable_cp advertise_cp;
+	uint8_t status;
+	int dd, ret;
+
+	if (hdev < 0)
+		hdev = hci_get_route(NULL);
+
+	dd = hci_open_dev(hdev);
+	if (dd < 0) {
+		perror("Could not open device");
+		exit(1);
+	}
+
+	memset(&advertise_cp, 0, sizeof(advertise_cp));
+	if (strcmp(opt, "noleadv") == 0)
+		advertise_cp.enable = 0x00;
+	else
+		advertise_cp.enable = 0x01;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_SET_ADVERTISE_ENABLE;
+	rq.cparam = &advertise_cp;
+	rq.clen = LE_SET_ADVERTISE_ENABLE_CP_SIZE;
+	rq.rparam = &status;
+	rq.rlen = 1;
+
+	ret = hci_send_req(dd, &rq, 100);
+	if (status || ret < 0)
+		fprintf(stderr, "Can't set advertise mode on hci%d: %s (%d)\n",
+						hdev, strerror(errno), errno);
+
+	hci_close_dev(dd);
+}
+
 static void cmd_iac(int ctl, int hdev, char *opt)
 {
 	int s = hci_open_dev(hdev);
@@ -1728,6 +1766,8 @@ static struct {
 	{ "revision",	cmd_revision,	0,		"Display revision information" },
 	{ "block",	cmd_block,	"<bdaddr>",	"Add a device to the blacklist" },
 	{ "unblock",	cmd_unblock,	"<bdaddr>",	"Remove a device from the blacklist" },
+	{ "leadv",	cmd_le_adv,	0,		"Enable LE advertising" },
+	{ "noleadv",	cmd_le_adv,	0,		"Disable LE advertising" },
 	{ NULL, NULL, 0 }
 };
 
-- 
1.7.0.4

