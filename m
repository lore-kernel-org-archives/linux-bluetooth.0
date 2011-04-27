Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH] Use HCI_MAX_EIR_LENGTH instead of hard-coded value
Date: Wed, 27 Apr 2011 16:21:03 -0400
Message-Id: <1303935663-31142-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---

NOTE: the constants EIR_DATA_LENGTH and HCI_MAX_EIR_LENGTH are duplicated.
This will be fixed in next patches of discovery cleanup.

 lib/hci.c         |    4 ++--
 plugins/hciops.c  |    2 +-
 src/storage.c     |    4 ++--
 test/hciemu.c     |    6 +++---
 tools/hciconfig.c |   10 +++++-----
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index eb00730..b122313 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -2291,7 +2291,7 @@ int hci_read_ext_inquiry_response(int dd, uint8_t *fec, uint8_t *data, int to)
 	}
 
 	*fec = rp.fec;
-	memcpy(data, rp.data, 240);
+	memcpy(data, rp.data, HCI_MAX_EIR_LENGTH);
 
 	return 0;
 }
@@ -2304,7 +2304,7 @@ int hci_write_ext_inquiry_response(int dd, uint8_t fec, uint8_t *data, int to)
 
 	memset(&cp, 0, sizeof(cp));
 	cp.fec = fec;
-	memcpy(cp.data, data, 240);
+	memcpy(cp.data, data, HCI_MAX_EIR_LENGTH);
 
 	memset(&rq, 0, sizeof(rq));
 	rq.ogf    = OGF_HOST_CTL;
diff --git a/plugins/hciops.c b/plugins/hciops.c
index 2b9be3f..d1156e2 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -96,7 +96,7 @@ static struct dev_info {
 	int sk;
 	bdaddr_t bdaddr;
 	char name[249];
-	uint8_t eir[240];
+	uint8_t eir[HCI_MAX_EIR_LENGTH];
 	uint8_t features[8];
 	uint8_t ssp_mode;
 
diff --git a/src/storage.c b/src/storage.c
index 28aea30..d416d75 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -368,7 +368,7 @@ int write_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t *data)
 	int i;
 
 	memset(str, 0, sizeof(str));
-	for (i = 0; i < 240; i++)
+	for (i = 0; i < HCI_MAX_EIR_LENGTH; i++)
 		sprintf(str + (i * 2), "%2.2X", data[i]);
 
 	create_filename(filename, PATH_MAX, local, "eir");
@@ -402,7 +402,7 @@ int read_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t *data)
 		return -EIO;
 	}
 
-	for (i = 0; i < 240; i++)
+	for (i = 0; i < HCI_MAX_EIR_LENGTH; i++)
 		sscanf(str + (i * 2), "%02hhX", &data[i]);
 
 	free(str);
diff --git a/test/hciemu.c b/test/hciemu.c
index 9950372..66f99a9 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -68,7 +68,7 @@ struct vhci_device {
 	uint8_t		dev_class[3];
 	uint8_t		inq_mode;
 	uint8_t		eir_fec;
-	uint8_t		eir_data[240];
+	uint8_t		eir_data[HCI_MAX_EIR_LENGTH];
 	uint16_t	acl_cnt;
 	bdaddr_t	bdaddr;
 	int		fd;
@@ -714,14 +714,14 @@ static void hci_host_control(uint16_t ocf, int plen, uint8_t *data)
 	case OCF_READ_EXT_INQUIRY_RESPONSE:
 		ir.status = 0x00;
 		ir.fec = vdev.eir_fec;
-		memcpy(ir.data, vdev.eir_data, 240);
+		memcpy(ir.data, vdev.eir_data, HCI_MAX_EIR_LENGTH);
 		command_complete(ogf, ocf, sizeof(ir), &ir);
 		break;
 
 	case OCF_WRITE_EXT_INQUIRY_RESPONSE:
 		status = 0x00;
 		vdev.eir_fec = data[0];
-		memcpy(vdev.eir_data, data + 1, 240);
+		memcpy(vdev.eir_data, data + 1, HCI_MAX_EIR_LENGTH);
 		command_complete(ogf, ocf, 1, &status);
 		break;
 
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 3db70a4..cbd0d0e 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -1252,7 +1252,7 @@ static void cmd_inq_data(int ctl, int hdev, char *opt)
 	}
 
 	if (opt) {
-		uint8_t fec = 0, data[240];
+		uint8_t fec = 0, data[HCI_MAX_EIR_LENGTH];
 		char tmp[3];
 		int i, size;
 
@@ -1260,8 +1260,8 @@ static void cmd_inq_data(int ctl, int hdev, char *opt)
 
 		memset(tmp, 0, sizeof(tmp));
 		size = (strlen(opt) + 1) / 2;
-		if (size > 240)
-			size = 240;
+		if (size > HCI_MAX_EIR_LENGTH)
+			size = HCI_MAX_EIR_LENGTH;
 
 		for (i = 0; i < size; i++) {
 			memcpy(tmp, opt + (i * 2), 2);
@@ -1274,7 +1274,7 @@ static void cmd_inq_data(int ctl, int hdev, char *opt)
 			exit(1);
 		}
 	} else {
-		uint8_t fec, data[240], len, type, *ptr;
+		uint8_t fec, data[HCI_MAX_EIR_LENGTH], len, type, *ptr;
 		char *str;
 
 		if (hci_read_ext_inquiry_response(dd, &fec, data, 1000) < 0) {
@@ -1285,7 +1285,7 @@ static void cmd_inq_data(int ctl, int hdev, char *opt)
 
 		print_dev_hdr(&di);
 		printf("\tFEC %s\n\t\t", fec ? "enabled" : "disabled");
-		for (i = 0; i < 240; i++)
+		for (i = 0; i < HCI_MAX_EIR_LENGTH; i++)
 			printf("%02x%s%s", data[i], (i + 1) % 8 ? "" : " ",
 				(i + 1) % 16 ? " " : (i < 239 ? "\n\t\t" : "\n"));
 
-- 
1.7.0.4

