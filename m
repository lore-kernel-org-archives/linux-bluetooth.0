Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 3/3] Add hcitool command to change the parameters of a given LE connection
Date: Tue, 22 Feb 2011 18:42:07 -0300
Message-Id: <1298410927-9165-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298410927-9165-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298410927-9165-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allows the LE master to start the Connection Parameter Update Procedure.
Parameters values consistency are not verified on purpose allowing
invalid values to test fail scenarios.
---
 tools/hcitool.c |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 875e25e..8c147bf 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2533,6 +2533,91 @@ static void cmd_ledc(int dev_id, int argc, char **argv)
 	hci_close_dev(dd);
 }
 
+static struct option lecup_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ "handle",	1, 0, 'H' },
+	{ "min",	1, 0, 'm' },
+	{ "max",	1, 0, 'M' },
+	{ "latency",	1, 0, 'l' },
+	{ "timeout",	1, 0, 't' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char *lecup_help =
+	"Usage:\n"
+	"\tlecup <handle> <min> <max> <latency> <timeout>\n"
+	"\tOptions:\n"
+	"\t    -H, --handle <0xXXXX>  LE connection handle\n"
+	"\t    -m, --min <interval>   Range: 0x0006 to 0x0C80\n"
+	"\t    -M, --max <interval>   Range: 0x0006 to 0x0C80\n"
+	"\t    -l, --latency <range>  Slave latency. Range: 0x0000 to 0x03E8\n"
+	"\t    -t, --timeout  <time>  N * 10ms. Range: 0x000A to 0x0C80\n"
+	"\n\t min/max range: 7.5ms to 4s. Multiply factor: 1.25ms"
+	"\n\t timeout range: 100ms to 32.0s. Larger than max interval\n";
+
+static void cmd_lecup(int dev_id, int argc, char **argv)
+{
+	uint16_t handle = 0, min, max, latency, timeout;
+	int opt, dd, base;
+
+	/* Aleatory valid values */
+	min = 0x0C8;
+	max = 0x0960;
+	latency = 0x0007;
+	timeout = 0x0C80;
+
+	for_each_opt(opt, lecup_options, NULL) {
+		if (optarg && strncasecmp("0x", optarg, 2) == 0)
+			base = 16;
+		else
+			base = 10;
+
+		switch (opt) {
+		case 'H':
+			handle = strtoul(optarg, NULL, base);
+			break;
+		case 'm':
+			min = strtoul(optarg, NULL, base);
+			break;
+		case 'M':
+			max = strtoul(optarg, NULL, base);
+			break;
+		case 'l':
+			latency = strtoul(optarg, NULL, base);
+			break;
+		case 't':
+			timeout = strtoul(optarg, NULL, base);
+			break;
+		default:
+			printf("%s", lecup_help);
+			return;
+		}
+	}
+
+	if (handle == 0) {
+		printf("%s", lecup_help);
+		return;
+	}
+
+	if (dev_id < 0)
+		dev_id = hci_get_route(NULL);
+
+	dd = hci_open_dev(dev_id);
+	if (dd < 0) {
+		fprintf(stderr, "HCI device open failed\n");
+		exit(1);
+	}
+
+	if (hci_le_conn_update(dd, htobs(handle), htobs(min), htobs(max),
+				htobs(latency), htobs(timeout), 5000) < 0) {
+		int err = errno;
+		fprintf(stderr, "Could not change connection params: %s(%d)\n",
+							strerror(err), err);
+	}
+
+	hci_close_dev(dd);
+}
+
 static struct {
 	char *cmd;
 	void (*func)(int dev_id, int argc, char **argv);
@@ -2565,6 +2650,7 @@ static struct {
 	{ "lescan", cmd_lescan, "Start LE scan"                        },
 	{ "lecc",   cmd_lecc,   "Create a LE Connection"               },
 	{ "ledc",   cmd_ledc,   "Disconnect a LE Connection"           },
+	{ "lecup",  cmd_lecup,  "LE Connection Update"                 },
 	{ NULL, NULL, 0 }
 };
 
-- 
1.7.4.1

