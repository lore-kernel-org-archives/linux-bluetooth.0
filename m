Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 2/4] tools/btmgmt: Add the 'add-adv' command
Date: Tue, 24 Mar 2015 11:35:09 -0700
Message-Id: <1427222111-15481-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1427222111-15481-1-git-send-email-armansito@chromium.org>
References: <1427222111-15481-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the 'add-adv' command which allows users to
send the MGMT "Add Advertising" command to the kernel.
---
 tools/btmgmt.c | 155 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index ea4eba7..06f9a82 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -3664,6 +3664,160 @@ static void cmd_advinfo(struct mgmt *mgmt, uint16_t index,
 	}
 }
 
+static void add_adv_rsp(uint8_t status, uint16_t len, const void *param,
+								void *user_data)
+{
+	const struct mgmt_rp_add_advertising *rp = param;
+
+	if (status != 0) {
+		error("Add Advertising failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (len != sizeof(*rp)) {
+		error("Invalid Add Advertising response length (%u)", len);
+		return noninteractive_quit(EXIT_FAILURE);
+	}
+
+	print("Instance added: %u", rp->instance);
+
+	return noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void add_adv_usage(void)
+{
+	print("Usage: add-adv [-d adv_data] [-s scan_rsp] "
+						"[-t timeout] <instance_id>");
+}
+
+static struct option add_adv_options[] = {
+	{ "help",	0, 0, 'h' },
+	{ "adv-data",	1, 0, 'd' },
+	{ "scan-rsp",	1, 0, 's' },
+	{ "timeout",	1, 0, 't' },
+	{ 0, 0, 0, 0}
+};
+
+static bool parse_bytes(char *optarg, uint8_t **bytes, size_t *len)
+{
+	unsigned i;
+
+	if (!optarg) {
+		add_adv_usage();
+		return false;
+	}
+
+	*len = strlen(optarg);
+
+	if (*len % 2) {
+		error("Malformed data");
+		return false;
+	}
+
+	*len /= 2;
+	if (*len > UINT8_MAX) {
+		error("Data too long");
+		return false;
+	}
+
+	*bytes = malloc(*len);
+	if (!*bytes) {
+		error("Failed to allocate memory");
+		return false;
+	}
+
+	for (i = 0; i < *len; i++) {
+		if (sscanf(optarg + (i * 2), "%2hhx", *bytes + i) != 1) {
+			error("Invalid data");
+			free(bytes);
+			*bytes = NULL;
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static void cmd_add_adv(struct mgmt *mgmt, uint16_t index,
+							int argc, char **argv)
+{
+	struct mgmt_cp_add_advertising *cp = NULL;
+	int opt;
+	uint8_t *adv_data = NULL, *scan_rsp = NULL;
+	size_t adv_len = 0, scan_rsp_len = 0;
+	size_t cp_len;
+	uint16_t timeout = 0;
+	uint8_t instance;
+	bool success = false;
+	bool quit = true;
+
+	while ((opt = getopt_long(argc, argv, "+d:s:t:h",
+						add_adv_options, NULL)) != -1) {
+		switch (opt) {
+		case 'd':
+			if (!parse_bytes(optarg, &adv_data, &adv_len))
+				goto done;
+			break;
+		case 's':
+			if (!parse_bytes(optarg, &scan_rsp, &scan_rsp_len))
+				goto done;
+			break;
+		case 't':
+			timeout = strtol(optarg, NULL, 0);
+			break;
+		case 'h':
+			success = true;
+		default:
+			add_adv_usage();
+			goto done;
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc != 1) {
+		add_adv_usage();
+		goto done;
+	}
+
+	instance = strtol(argv[0], NULL, 0);
+
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	cp_len = sizeof(*cp) + (adv_len + scan_rsp_len) * sizeof(uint8_t);
+	cp = malloc0(cp_len);
+	if (!cp)
+		goto done;
+
+	cp->instance = instance;
+	put_le16(timeout, &cp->timeout);
+	cp->adv_data_len = adv_len;
+	cp->scan_rsp_len = scan_rsp_len;
+
+	memcpy(cp->data, adv_data, adv_len * sizeof(uint8_t));
+	memcpy(cp->data + adv_len, scan_rsp, scan_rsp_len * sizeof(uint8_t));
+
+	if (!mgmt_send(mgmt, MGMT_OP_ADD_ADVERTISING, index, cp_len, cp,
+						add_adv_rsp, NULL, NULL)) {
+		error("Unable to send \"Add Advertising\" command");
+		goto done;
+	}
+
+	quit = false;
+
+done:
+	free(adv_data);
+	free(scan_rsp);
+	free(cp);
+
+	if (quit)
+		noninteractive_quit(success ? EXIT_SUCCESS : EXIT_FAILURE);
+}
+
 struct cmd_info {
 	char *cmd;
 	void (*func)(struct mgmt *mgmt, uint16_t index, int argc, char **argv);
@@ -3727,6 +3881,7 @@ static struct cmd_info all_cmd[] = {
 	{ "bredr-oob",	cmd_bredr_oob,	"Local OOB data (BR/EDR)"	},
 	{ "le-oob",	cmd_le_oob,	"Local OOB data (LE)"		},
 	{ "advinfo",	cmd_advinfo,	"Show advertising features"	},
+	{ "add-adv",	cmd_add_adv,	"Add Advertising Data"		},
 };
 
 static void cmd_quit(struct mgmt *mgmt, uint16_t index,
-- 
2.2.0.rc0.207.ga3a616c

