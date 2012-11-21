Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ] hciconfig: Add an option to set which advertise type will be on
Date: Wed, 21 Nov 2012 10:09:52 -0400
Message-Id: <1353506992-3371-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are some advertise types that can be used, so we need a way to
tell which one we want. The default one is ADV_IND.
---
 tools/hciconfig.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 64f2650..e107bff 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -254,8 +254,31 @@ static void cmd_le_adv(int ctl, int hdev, char *opt)
 		exit(1);
 	}
 
+	if (opt == NULL || strcmp(opt, "noleadv")) {
+		le_set_advertising_parameters_cp adv_params_cp;
+
+		memset(&adv_params_cp, 0, sizeof(adv_params_cp));
+		adv_params_cp.min_interval = 0x0800;
+		adv_params_cp.max_interval = 0x0800;
+		if (opt)
+			adv_params_cp.advtype = atoi(opt);
+		adv_params_cp.chan_map = 7;
+
+		memset(&rq, 0, sizeof(rq));
+		rq.ogf = OGF_LE_CTL;
+		rq.ocf = OCF_LE_SET_ADVERTISING_PARAMETERS;
+		rq.cparam = &adv_params_cp;
+		rq.clen = LE_SET_ADVERTISING_PARAMETERS_CP_SIZE;
+		rq.rparam = &status;
+		rq.rlen = 1;
+
+		ret = hci_send_req(dd, &rq, 1000);
+		if (ret < 0)
+			goto done;
+	}
+
 	memset(&advertise_cp, 0, sizeof(advertise_cp));
-	if (strcmp(opt, "noleadv") == 0)
+	if (opt && strcmp(opt, "noleadv") == 0)
 		advertise_cp.enable = 0x00;
 	else
 		advertise_cp.enable = 0x01;
@@ -270,6 +293,7 @@ static void cmd_le_adv(int ctl, int hdev, char *opt)
 
 	ret = hci_send_req(dd, &rq, 1000);
 
+done:
 	hci_close_dev(dd);
 
 	if (ret < 0) {
@@ -1932,7 +1956,9 @@ static struct {
 	{ "block",	cmd_block,	"<bdaddr>",	"Add a device to the blacklist" },
 	{ "unblock",	cmd_unblock,	"<bdaddr>",	"Remove a device from the blacklist" },
 	{ "lerandaddr", cmd_le_addr,	"<bdaddr>",	"Set LE Random Address" },
-	{ "leadv",	cmd_le_adv,	0,		"Enable LE advertising" },
+	{ "leadv",	cmd_le_adv,	"[type]",	"Enable LE advertising"
+		"\n\t\t\t0 - Connectable undirected advertising (default)"
+		"\n\t\t\t3 - Non connectable undirected advertising"},
 	{ "noleadv",	cmd_le_adv,	0,		"Disable LE advertising" },
 	{ "lestates",	cmd_le_states,	0,		"Display the supported LE states" },
 	{ NULL, NULL, 0 }
-- 
1.8.0

