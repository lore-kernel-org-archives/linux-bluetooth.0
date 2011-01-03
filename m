Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Add option to set leadv peripheral role for hciconfig
Date: Mon,  3 Jan 2011 16:39:57 -0500
Message-Id: <1294090797-20456-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Temporary solution to allow GATT server testing using dual mode hardware.
For peripheral role, the advertising data shall include the Flags AD type
with the General Discoverable Mode flag set to one. Additionally, this patch
set the BR/EDR Not Supported flag to one to force a LE only device.
---
 lib/sdp.h         |    9 ++++++
 src/adapter.c     |    9 ------
 tools/hciconfig.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 77 insertions(+), 18 deletions(-)

diff --git a/lib/sdp.h b/lib/sdp.h
index 16b59fc..8b85ab6 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -407,6 +407,15 @@ extern "C" {
 #define SDP_INVALID_PDU_SIZE		0x0004
 #define SDP_INVALID_CSTATE		0x0005
 
+/* EIR and Advertising flags descriptions (Vol 3/Part C/Appendix C) */
+#define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
+#define EIR_GEN_DISC                0x02 /* LE General Discoverable Mode */
+#define EIR_BREDR_UNSUP             0x04 /* BR/EDR Not Supported */
+#define EIR_SIM_CONTROLLER          0x08 /* Simultaneous LE and BR/EDR to Same
+					    Device Capable (Controller) */
+#define EIR_SIM_HOST                0x10 /* Simultaneous LE and BR/EDR to Same
+					    Device Capable (Host) */
+
 /*
  * SDP PDU
  */
diff --git a/src/adapter.c b/src/adapter.c
index 87a8beb..2c7b174 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -57,15 +57,6 @@
 #include "storage.h"
 #include "att.h"
 
-/* Flags Descriptions */
-#define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
-#define EIR_GEN_DISC                0x02 /* LE General Discoverable Mode */
-#define EIR_BREDR_UNSUP             0x04 /* BR/EDR Not Supported */
-#define EIR_SIM_CONTROLLER          0x08 /* Simultaneous LE and BR/EDR to Same
-					    Device Capable (Controller) */
-#define EIR_SIM_HOST                0x10 /* Simultaneous LE and BR/EDR to Same
-					    Device Capable (Host) */
-
 #define ADV_TYPE_IND		0x00
 #define ADV_TYPE_DIRECT_IND	0x01
 
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 6e5117f..4453e7b 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -42,6 +42,7 @@
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
 
+#include "sdpd.h"
 #include "textfile.h"
 #include "csr.h"
 
@@ -195,10 +196,11 @@ static void cmd_scan(int ctl, int hdev, char *opt)
 	}
 }
 
-static void cmd_le_adv(int ctl, int hdev, char *opt)
+static void cmd_le_adv_on(int ctl, int hdev, char *opt)
 {
 	struct hci_request rq;
 	le_set_advertise_enable_cp advertise_cp;
+	le_set_advertising_data_cp data_cp;
 	uint8_t status;
 	int dd, ret;
 
@@ -211,11 +213,32 @@ static void cmd_le_adv(int ctl, int hdev, char *opt)
 		exit(1);
 	}
 
+	memset(&data_cp, 0, sizeof(data_cp));
+	if (opt == NULL || strcasecmp(opt, "peripheral") == 0) {
+		data_cp.length = 3;
+		data_cp.data[0] = 2;
+		data_cp.data[1] = EIR_FLAGS;
+		data_cp.data[2] = EIR_GEN_DISC | EIR_BREDR_UNSUP;
+	}
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_SET_ADVERTISING_DATA;
+	rq.cparam = &data_cp;
+	rq.clen = LE_SET_ADVERTISING_DATA_CP_SIZE;
+	rq.rparam = &status;
+	rq.rlen = 1;
+
+	ret = hci_send_req(dd, &rq, 1000);
+	if (status || ret < 0) {
+		fprintf(stderr, "Can't set paremeter flags on hci%d: %s (%d)\n",
+						hdev, strerror(errno), errno);
+		hci_close_dev(dd);
+		exit(1);
+	}
+
 	memset(&advertise_cp, 0, sizeof(advertise_cp));
-	if (strcmp(opt, "noleadv") == 0)
-		advertise_cp.enable = 0x00;
-	else
-		advertise_cp.enable = 0x01;
+	advertise_cp.enable = 0x01;
 
 	memset(&rq, 0, sizeof(rq));
 	rq.ogf = OGF_LE_CTL;
@@ -225,10 +248,46 @@ static void cmd_le_adv(int ctl, int hdev, char *opt)
 	rq.rparam = &status;
 	rq.rlen = 1;
 
-	ret = hci_send_req(dd, &rq, 100);
-	if (status || ret < 0)
+	ret = hci_send_req(dd, &rq, 1000);
+	hci_close_dev(dd);
+	if (status || ret < 0) {
 		fprintf(stderr, "Can't set advertise mode on hci%d: %s (%d)\n",
 						hdev, strerror(errno), errno);
+		exit(1);
+	}
+}
+
+static void cmd_le_adv_off(int ctl, int hdev, char *opt)
+{
+	struct hci_request rq;
+	le_set_advertise_enable_cp advertise_cp;
+	uint8_t status;
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
+	memset(&advertise_cp, 0, sizeof(advertise_cp));
+	advertise_cp.enable = 0x00;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf = OGF_LE_CTL;
+	rq.ocf = OCF_LE_SET_ADVERTISE_ENABLE;
+	rq.cparam = &advertise_cp;
+	rq.clen = LE_SET_ADVERTISE_ENABLE_CP_SIZE;
+	rq.rparam = &status;
+	rq.rlen = 1;
+
+	ret = hci_send_req(dd, &rq, 1000);
+	if (status || ret < 0)
+		fprintf(stderr, "Can't disable advertise mode on hci%d: "
+				"%s (%d)\n", hdev, strerror(errno), errno);
 
 	hci_close_dev(dd);
 }
@@ -1879,8 +1938,8 @@ static struct {
 	{ "revision",	cmd_revision,	0,		"Display revision information" },
 	{ "block",	cmd_block,	"<bdaddr>",	"Add a device to the blacklist" },
 	{ "unblock",	cmd_unblock,	"<bdaddr>",	"Remove a device from the blacklist" },
-	{ "leadv",	cmd_le_adv,	0,		"Enable LE advertising" },
-	{ "noleadv",	cmd_le_adv,	0,		"Disable LE advertising" },
+	{ "leadv",	cmd_le_adv_on,	"role",		"Enable LE advertising" },
+	{ "noleadv",	cmd_le_adv_off,	0,		"Disable LE advertising" },
 	{ "lestates",	cmd_le_states,	0,		"Display the supported LE states" },
 	{ NULL, NULL, 0 }
 };
-- 
1.7.3.2

