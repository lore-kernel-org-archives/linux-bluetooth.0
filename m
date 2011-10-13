Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] Add support for parsing the remote name during LE Scan
Date: Thu, 13 Oct 2011 18:39:07 -0300
Message-Id: <1318541947-13947-1-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1318524096-2412-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1318524096-2412-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hcitool.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 6184a4c..3547794 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -54,6 +54,18 @@
 #define FLAGS_LIMITED_MODE_BIT 0x01
 #define FLAGS_GENERAL_MODE_BIT 0x02
 
+#define EIR_FLAGS                   0x01  /* flags */
+#define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available */
+#define EIR_UUID16_ALL              0x03  /* 16-bit UUID, all listed */
+#define EIR_UUID32_SOME             0x04  /* 32-bit UUID, more available */
+#define EIR_UUID32_ALL              0x05  /* 32-bit UUID, all listed */
+#define EIR_UUID128_SOME            0x06  /* 128-bit UUID, more available */
+#define EIR_UUID128_ALL             0x07  /* 128-bit UUID, all listed */
+#define EIR_NAME_SHORT              0x08  /* shortened local name */
+#define EIR_NAME_COMPLETE           0x09  /* complete local name */
+#define EIR_TX_POWER                0x0A  /* transmit power level */
+#define EIR_DEVICE_ID               0x10  /* device ID */
+
 #define for_each_opt(opt, long, short) while ((opt=getopt_long(argc, argv, short ? short:"+", long, NULL)) != -1)
 
 static volatile int signal_received = 0;
@@ -2354,6 +2366,40 @@ static void sigint_handler(int sig)
 	signal_received = sig;
 }
 
+static void eir_parse_name(uint8_t *eir_data, char *name)
+{
+	int len;
+
+	if (eir_data == NULL)
+		goto failed;
+
+	len = 0;
+	while (len < HCI_MAX_EIR_LENGTH - 1) {
+		uint8_t field_len = eir_data[0];
+
+		/* Check for the end of EIR */
+		if (field_len == 0)
+			break;
+
+		switch (eir_data[1]) {
+		case EIR_NAME_SHORT:
+		case EIR_NAME_COMPLETE:
+			if (field_len > HCI_MAX_NAME_LENGTH)
+				goto failed;
+
+			memcpy(name, &eir_data[2], field_len - 1);
+			return;
+		}
+
+		len += field_len + 1;
+		eir_data += field_len + 1;
+	}
+
+failed:
+	sprintf(name, "(unknown)");
+	return;
+}
+
 static int print_advertising_devices(int dd, uint8_t filter_type)
 {
 	unsigned char buf[HCI_MAX_EVENT_SIZE], *ptr;
@@ -2409,8 +2455,14 @@ static int print_advertising_devices(int dd, uint8_t filter_type)
 		/* Ignoring multiple reports */
 		info = (le_advertising_info *) (meta->data + 1);
 		if (check_report_filter(filter_type, info)) {
+			char name[HCI_MAX_NAME_LENGTH + 1];
+
+			memset(name, 0, sizeof(name));
+
 			ba2str(&info->bdaddr, addr);
-			printf("%s\n", addr);
+			eir_parse_name(info->data, name);
+
+			printf("%s %s\n", addr, name);
 		}
 	}
 
-- 
1.7.7

