Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/2] Add option to set LE random address to hciconfig
Date: Fri, 28 Jan 2011 19:33:36 -0300
Message-Id: <1296254017-3381-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hciconfig.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 6e5117f..c271d14 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -195,6 +195,49 @@ static void cmd_scan(int ctl, int hdev, char *opt)
 	}
 }
 
+static void cmd_le_addr(int ctl, int hdev, char *opt)
+{
+	struct hci_request rq;
+	le_set_random_address_cp cp;
+	uint8_t status;
+	int dd, err, ret;
+
+	if (!opt)
+		return;
+
+	if (hdev < 0)
+		hdev = hci_get_route(NULL);
+
+	dd = hci_open_dev(hdev);
+	if (dd < 0) {
+		err = errno;
+		fprintf(stderr, "Could not open device: %s(%d)\n",
+							strerror(err), err);
+		exit(1);
+	}
+
+	memset(&cp, 0, sizeof(cp));
+
+	str2ba(opt, &cp.bdaddr);
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_SET_RANDOM_ADDRESS;
+	rq.cparam = &cp;
+	rq.clen = LE_SET_RANDOM_ADDRESS_CP_SIZE;
+	rq.rparam = &status;
+	rq.rlen = 1;
+
+	ret = hci_send_req(dd, &rq, 1000);
+	if (status || ret < 0) {
+		err = errno;
+		fprintf(stderr, "Can't set random address for hci%d: "
+					"%s (%d)\n", hdev, strerror(err), err);
+	}
+
+	hci_close_dev(dd);
+}
+
 static void cmd_le_adv(int ctl, int hdev, char *opt)
 {
 	struct hci_request rq;
@@ -1879,6 +1922,7 @@ static struct {
 	{ "revision",	cmd_revision,	0,		"Display revision information" },
 	{ "block",	cmd_block,	"<bdaddr>",	"Add a device to the blacklist" },
 	{ "unblock",	cmd_unblock,	"<bdaddr>",	"Remove a device from the blacklist" },
+	{ "lerandaddr", cmd_le_addr,	"<bdaddr>",	"Set LE Random Address" },
 	{ "leadv",	cmd_le_adv,	0,		"Enable LE advertising" },
 	{ "noleadv",	cmd_le_adv,	0,		"Disable LE advertising" },
 	{ "lestates",	cmd_le_states,	0,		"Display the supported LE states" },
-- 
1.7.4.rc2

