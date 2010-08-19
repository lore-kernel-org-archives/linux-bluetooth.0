Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH v2] hciconfig: add LE_SET_ADVERTISE_ENABLE cmd
Date: Thu, 19 Aug 2010 16:52:38 -0400
Message-Id: <1282251158-27015-1-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements two new hciconfig commands: leadv and noleadv.
These new hciconfig flags are responsible to LE_SET_ADVERTISE_ENABLE
command implementation.
---
 tools/hciconfig.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 87dd127..1e04193 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -149,6 +149,45 @@ static void cmd_scan(int ctl, int hdev, char *opt)
 	}
 }
 
+static void cmd_le_adv(int ctl, int hdev, char *opt)
+{
+	struct hci_request rq;
+	le_set_advertise_enable_cp advertise_cp;
+	uint8_t status, enable;
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
+	enable = 0x01;
+	if (!strcmp(opt, "noleadv"))
+		enable = 0x00;
+
+	memset(&advertise_cp, 0, sizeof(advertise_cp));
+	advertise_cp.enable = enable;
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
@@ -1728,6 +1767,8 @@ static struct {
 	{ "revision",	cmd_revision,	0,		"Display revision information" },
 	{ "block",	cmd_block,	"<bdaddr>",	"Add a device to the blacklist" },
 	{ "unblock",	cmd_unblock,	"<bdaddr>",	"Remove a device from the blacklist" },
+	{ "leadv",	cmd_le_adv,	0,		"Enable LE advertising" },
+	{ "noleadv",	cmd_le_adv,	0,		"Disable LE advertising" },
 	{ NULL, NULL, 0 }
 };
 
-- 
1.7.0.4

