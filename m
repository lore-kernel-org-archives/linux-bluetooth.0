Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] tools/hciconfig: Configure LE adv data flags
Date: Mon, 06 Apr 2015 15:46:24 +0530
Message-id: <1428315384-4984-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for LE advertisement data flags by adding a new command
in hciconfig tool "leadvflags".

LE adv flag values can be refered from CSS 5, section 1.3.2, formats.
---
 tools/hciconfig.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 6397e71..cf389d5 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -47,6 +47,14 @@
 #include "src/shared/util.h"
 #include "tools/csr.h"
 
+#define EIR_FLAGS		0x01 /* flags */
+#define EIR_NAME_SHORT		0x08 /* shortened local name */
+#define EIR_NAME_COMPLETE	0x09 /* complete local name */
+#define EIR_TX_POWER		0x0A /* transmit power level */
+#define EIR_GAP_APPEARANCE	0x19  /* GAP appearance */
+
+#define HCI_MAX_AD_LENGTH	31
+
 static struct hci_dev_info di;
 static int all;
 
@@ -234,6 +242,112 @@ static void cmd_le_addr(int ctl, int hdev, char *opt)
 	hci_close_dev(dd);
 }
 
+static uint8_t create_ad(uint8_t *ptr, uint8_t type)
+{
+	uint8_t ad_len = 0, flags = 0;
+	size_t name_len;
+	char *name;
+
+	flags = type;
+
+	ptr[0] = 2;
+	ptr[1] = EIR_FLAGS;
+	ptr[2] = flags;
+
+	ad_len += 3;
+	ptr += 3;
+
+	ptr[0] = 2;
+	ptr[1] = EIR_TX_POWER;
+	ptr[2] = 0x12;
+
+	ad_len += 3;
+	ptr += 3;
+
+	if (ad_len + 4 <= HCI_MAX_AD_LENGTH) {
+		ptr[0] = 3;
+		ptr[1] = EIR_GAP_APPEARANCE;
+
+		/* Generic Phone */
+		bt_put_le16((uint16_t)64, ptr + 2);
+
+		ad_len += 4;
+		ptr += 4;
+	}
+
+	name = strdup("ZEQ");
+	name_len = strlen(name);
+	if (name_len > 0) {
+		size_t max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
+
+		if (name_len > max_len) {
+			name_len = max_len;
+			ptr[1] = EIR_NAME_SHORT;
+		} else
+			ptr[1] = EIR_NAME_COMPLETE;
+
+		ptr[0] = name_len + 1;
+
+		memcpy(ptr + 2, name, name_len);
+
+		ad_len += (name_len + 2);
+		ptr += (name_len + 2);
+	}
+
+	return ad_len;
+}
+
+static void cmd_le_adv_flags(int ctl, int hdev, char *opt)
+{
+	struct hci_request rq;
+	le_set_advertising_data_cp advertise_data_cp;
+	uint8_t status;
+	uint8_t len;
+	int dd, ret;
+	unsigned int type = 0;
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
+	memset(&advertise_data_cp, 0, sizeof(advertise_data_cp));
+	if (opt)
+		type = atoi(opt);
+
+	len = create_ad(advertise_data_cp.data, type);
+
+	advertise_data_cp.length = len;
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_SET_ADVERTISING_DATA;
+	rq.cparam = &advertise_data_cp;
+	rq.clen = LE_SET_ADVERTISING_DATA_CP_SIZE;
+	rq.rparam = &status;
+	rq.rlen = 1;
+
+	ret = hci_send_req(dd, &rq, 1000);
+
+	hci_close_dev(dd);
+	if (ret < 0) {
+		fprintf(stderr, "Can't set advertise mode on hci%d: %s (%d)\n",
+						hdev, strerror(errno), errno);
+		exit(1);
+	}
+
+	if (status) {
+		fprintf(stderr,
+			"LE set advertise enable on hci%d returned status %d\n",
+								hdev, status);
+		exit(1);
+	}
+
+}
+
 static void cmd_le_adv(int ctl, int hdev, char *opt)
 {
 	struct hci_request rq;
@@ -1950,6 +2064,13 @@ static struct {
 		"\n\t\t\t3 - Non connectable undirected advertising"},
 	{ "noleadv",	cmd_no_le_adv,	0,		"Disable LE advertising" },
 	{ "lestates",	cmd_le_states,	0,		"Display the supported LE states" },
+	{ "leadvflags",	cmd_le_adv_flags, "[type]",	"Set data flags"
+		"\n\t\t\t (Flags value can be reffered from spec CSS 5, section 1.3.2, formats)\n"
+		"\n\t\t\t 0x01 - Limited Discoverable"
+		"\n\t\t\t 0x02 - General Discoverable"
+		"\n\t\t\t 0x04 - No BR/EDR"
+		"\n\t\t\t 0x08 - Simultaneous LE and BR/EDR to Same Device Capable(Controller)"
+		"\n\t\t\t 0x10 - Simultaneous LE and BR/EDR to Same Device Capable(Host)"},
 	{ NULL, NULL, 0 }
 };
 
-- 
1.9.1

