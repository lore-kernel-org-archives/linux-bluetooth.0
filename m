Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] hciconfig: Remove putkey command
Date: Wed,  5 Dec 2012 12:43:54 +0100
Message-Id: <1354707834-30972-1-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354705606.1815.6.camel@aeonflux>
References: <1354705606.1815.6.camel@aeonflux>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With new storage architecture legacy storage "linkkeys"
file doesn't exist anymore.
---
 tools/hciconfig.8 |    5 -----
 tools/hciconfig.c |   64 -----------------------------------------------------
 2 files changed, 69 deletions(-)

diff --git a/tools/hciconfig.8 b/tools/hciconfig.8
index 6397427..897d820 100644
--- a/tools/hciconfig.8
+++ b/tools/hciconfig.8
@@ -212,11 +212,6 @@ bytes and SCO buffer size to
 .I pkt
 packets.
 .TP
-.BI putkey " <bdaddr>"
-This command stores the link key for
-.I bdaddr
-on the device.
-.TP
 .BI delkey " <bdaddr>"
 This command deletes the stored link key for
 .I bdaddr
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 045e9a8..6b18c4f 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -1015,69 +1015,6 @@ static void cmd_voice(int ctl, int hdev, char *opt)
 	}
 }
 
-static int get_link_key(const bdaddr_t *local, const bdaddr_t *peer,
-			uint8_t *key)
-{
-	char filename[PATH_MAX + 1], addr[18], tmp[3], *str;
-	int i;
-
-	ba2str(local, addr);
-	create_name(filename, PATH_MAX, STORAGEDIR, addr, "linkkeys");
-
-	ba2str(peer, addr);
-	str = textfile_get(filename, addr);
-	if (!str)
-		return -EIO;
-
-	memset(tmp, 0, sizeof(tmp));
-	for (i = 0; i < 16; i++) {
-		memcpy(tmp, str + (i * 2), 2);
-		key[i] = (uint8_t) strtol(tmp, NULL, 16);
-	}
-
-	free(str);
-
-	return 0;
-}
-
-static void cmd_putkey(int ctl, int hdev, char *opt)
-{
-	struct hci_dev_info di;
-	bdaddr_t bdaddr;
-	uint8_t key[16];
-	int dd;
-
-	if (!opt)
-		return;
-
-	dd = hci_open_dev(hdev);
-	if (dd < 0) {
-		fprintf(stderr, "Can't open device hci%d: %s (%d)\n",
-						hdev, strerror(errno), errno);
-		exit(1);
-	}
-
-	if (hci_devinfo(hdev, &di) < 0) {
-		fprintf(stderr, "Can't get device info for hci%d: %s (%d)\n",
-						hdev, strerror(errno), errno);
-		exit(1);
-	}
-
-	str2ba(opt, &bdaddr);
-	if (get_link_key(&di.bdaddr, &bdaddr, key) < 0) {
-		fprintf(stderr, "Can't find link key for %s on hci%d\n", opt, hdev);
-		exit(1);
-	}
-
-	if (hci_write_stored_link_key(dd, &bdaddr, key, 1000) < 0) {
-		fprintf(stderr, "Can't write stored link key on hci%d: %s (%d)\n",
-						hdev, strerror(errno), errno);
-		exit(1);
-	}
-
-	hci_close_dev(dd);
-}
-
 static void cmd_delkey(int ctl, int hdev, char *opt)
 {
 	bdaddr_t bdaddr;
@@ -1984,7 +1921,6 @@ static struct {
 	{ "sspmode",	cmd_ssp_mode,	"[mode]",	"Get/Set Simple Pairing Mode" },
 	{ "aclmtu",	cmd_aclmtu,	"<mtu:pkt>",	"Set ACL MTU and number of packets" },
 	{ "scomtu",	cmd_scomtu,	"<mtu:pkt>",	"Set SCO MTU and number of packets" },
-	{ "putkey",	cmd_putkey,	"<bdaddr>",	"Store link key on the device" },
 	{ "delkey",	cmd_delkey,	"<bdaddr>",	"Delete link key from the device" },
 	{ "oobdata",	cmd_oob_data,	0,		"Get local OOB data" },
 	{ "commands",	cmd_commands,	0,		"Display supported commands" },
-- 
1.7.9.5

