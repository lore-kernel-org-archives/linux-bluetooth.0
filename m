Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Add LE read supported states for hciconfig
Date: Wed, 29 Dec 2010 18:17:24 -0300
Message-Id: <1293657444-9911-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Displays the states and state combinations that the link layer
supports. Usage: hciconfig hcix lestates
---
 tools/hciconfig.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index f0ae11c..6e5117f 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -120,6 +120,51 @@ static void print_dev_features(struct hci_dev_info *di, int format)
 	}
 }
 
+static void print_le_states(uint64_t states)
+{
+	int i;
+	const char *le_states[] = {
+		"Non-connectable Advertising State" ,
+		"Scannable Advertising State",
+		"Connectable Advertising State",
+		"Directed Advertising State",
+		"Passive Scanning State",
+		"Active Scanning State",
+		"Initiating State/Connection State in Master Role",
+		"Connection State in the Slave Role",
+		"Non-connectable Advertising State and Passive Scanning State combination",
+		"Scannable Advertising State and Passive Scanning State combination",
+		"Connectable Advertising State and Passive Scanning State combination",
+		"Directed Advertising State and Passive Scanning State combination",
+		"Non-connectable Advertising State and Active Scanning State combination",
+		"Scannable Advertising State and Active Scanning State combination",
+		"Connectable Advertising State and Active Scanning State combination",
+		"Directed Advertising State and Active Scanning State combination",
+		"Non-connectable Advertising State and Initiating State combination",
+		"Scannable Advertising State and Initiating State combination",
+		"Non-connectable Advertising State and Master Role combination",
+		"Scannable Advertising State and Master Role combination",
+		"Non-connectable Advertising State and Slave Role combination",
+		"Scannable Advertising State and Slave Role combination",
+		"Passive Scanning State and Initiating State combination",
+		"Active Scanning State and Initiating State combination",
+		"Passive Scanning State and Master Role combination",
+		"Active Scanning State and Master Role combination",
+		"Passive Scanning State and Slave Role combination",
+		"Active Scanning State and Slave Role combination",
+		"Initiating State and Master Role combination/Master Role and Master Role combination",
+		NULL
+	};
+
+	printf("Supported link layer states:\n");
+	for (i = 0; le_states[i]; i++) {
+		const char *status;
+
+		status = states & (1 << i) ? "YES" : "NO ";
+		printf("\t%s %s\n", status, le_states[i]);
+	}
+}
+
 static void cmd_rstat(int ctl, int hdev, char *opt)
 {
 	/* Reset HCI device stat counters */
@@ -188,6 +233,49 @@ static void cmd_le_adv(int ctl, int hdev, char *opt)
 	hci_close_dev(dd);
 }
 
+static void cmd_le_states(int ctl, int hdev, char *opt)
+{
+	le_read_supported_states_rp rp;
+	struct hci_request rq;
+	int err, dd;
+
+	if (hdev < 0)
+		hdev = hci_get_route(NULL);
+
+	dd = hci_open_dev(hdev);
+	if (dd < 0) {
+		fprintf(stderr, "Can't open device hci%d: %s (%d)\n",
+						hdev, strerror(errno), errno);
+		exit(1);
+	}
+
+	memset(&rp, 0, sizeof(rp));
+	memset(&rq, 0, sizeof(rq));
+
+	rq.ogf    = OGF_LE_CTL;
+	rq.ocf    = OCF_LE_READ_SUPPORTED_STATES;
+	rq.rparam = &rp;
+	rq.rlen   = LE_READ_SUPPORTED_STATES_RP_SIZE;
+
+	err = hci_send_req(dd, &rq, 1000);
+
+	close(dd);
+
+	if (err < 0) {
+		fprintf(stderr, "Can't read LE supported states on hci%d:"
+				" %s(%d)\n", hdev, strerror(errno), errno);
+		exit(1);
+	}
+
+	if (rp.status) {
+		fprintf(stderr, "Read LE supported states on hci%d"
+				" returned status %d\n", hdev, rp.status);
+		exit(1);
+	}
+
+	print_le_states(rp.states);
+}
+
 static void cmd_iac(int ctl, int hdev, char *opt)
 {
 	int s = hci_open_dev(hdev);
@@ -1793,6 +1881,7 @@ static struct {
 	{ "unblock",	cmd_unblock,	"<bdaddr>",	"Remove a device from the blacklist" },
 	{ "leadv",	cmd_le_adv,	0,		"Enable LE advertising" },
 	{ "noleadv",	cmd_le_adv,	0,		"Disable LE advertising" },
+	{ "lestates",	cmd_le_states,	0,		"Display the supported LE states" },
 	{ NULL, NULL, 0 }
 };
 
-- 
1.7.3.4

