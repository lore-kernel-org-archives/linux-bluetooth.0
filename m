Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 2/2] Add support for parsing the remote name during LE Scan
Date: Thu,  6 Oct 2011 11:42:12 -0300
Message-Id: <1317912132-6644-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1317912132-6644-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1317912132-6644-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hcitool.c |   52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 988ebe3..c9d1822 100644
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
 
 static struct sighandler_data {
@@ -2369,6 +2381,38 @@ static void sigint_handler(int sig)
 	exit(0);
 }
 
+static char *eir_parse_name(uint8_t *eir_data)
+{
+	int len;
+
+	if (eir_data == NULL)
+		return NULL;
+
+	len = 0;
+	while (len < HCI_MAX_EIR_LENGTH - 1) {
+		uint8_t field_len = eir_data[0];
+		char *name;
+
+		/* Check for the end of EIR */
+		if (field_len == 0)
+			break;
+
+		switch (eir_data[1]) {
+		case EIR_NAME_SHORT:
+		case EIR_NAME_COMPLETE:
+			name = malloc(sizeof(char) * field_len);
+			memset(name, 0, field_len);
+			memcpy(name, &eir_data[2], field_len - 1);
+			return name;
+		}
+
+		len += field_len + 1;
+		eir_data += field_len + 1;
+	}
+
+	return NULL;
+}
+
 static int print_advertising_devices(int dd, uint8_t filter_type)
 {
 	unsigned char buf[HCI_MAX_EVENT_SIZE], *ptr;
@@ -2423,8 +2467,14 @@ static int print_advertising_devices(int dd, uint8_t filter_type)
 		/* Ignoring multiple reports */
 		info = (le_advertising_info *) (meta->data + 1);
 		if (check_report_filter(filter_type, info)) {
+			char *name;
+
 			ba2str(&info->bdaddr, addr);
-			printf("%s\n", addr);
+			name = eir_parse_name(info->data);
+
+			printf("%s %s\n", addr, name ? : "(unknown)");
+
+			free(name);
 		}
 	}
 
-- 
1.7.6.1

