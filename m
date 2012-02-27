Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] hciemu: Always initialize status in hci_host_control
Date: Mon, 27 Feb 2012 13:03:51 +0100
Message-ID: <1330344231-22823-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Assign 0x00 to status on intialization instead of assigning it in each
switch case. This helps to avoid errors when one forget to proper
intialize status in new case.

This fix following compilation error:

  CC     test/hciemu.o
cc1: warnings being treated as errors
test/hciemu.c: In function ‘hci_host_control’:
test/hciemu.c:786: error: ‘status’ may be used uninitialized in this function
make[1]: *** [test/hciemu.o] Error 1
---
 test/hciemu.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/test/hciemu.c b/test/hciemu.c
index ffe04f8..69e21f5 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -662,24 +662,21 @@ static void hci_host_control(uint16_t ocf, int plen, uint8_t *data)
 	read_ext_inquiry_response_rp ir;
 	read_simple_pairing_mode_rp pm;
 	read_le_host_supported_rp hs;
-	uint8_t status;
+	uint8_t status = 0x00;
 
 	const uint16_t ogf = OGF_HOST_CTL;
 
 	switch (ocf) {
 	case OCF_RESET:
-		status = 0x00;
 		reset_vdev();
 		command_complete(ogf, ocf, 1, &status);
 		break;
 
 	case OCF_SET_EVENT_FLT:
-		status = 0x00;
 		command_complete(ogf, ocf, 1, &status);
 		break;
 
 	case OCF_CHANGE_LOCAL_NAME:
-		status = 0x00;
 		memcpy(vdev.name, data, sizeof(vdev.name));
 		command_complete(ogf, ocf, 1, &status);
 		break;
@@ -692,7 +689,6 @@ static void hci_host_control(uint16_t ocf, int plen, uint8_t *data)
 
 	case OCF_WRITE_CONN_ACCEPT_TIMEOUT:
 	case OCF_WRITE_PAGE_TIMEOUT:
-		status = 0x00;
 		command_complete(ogf, ocf, 1, &status);
 		break;
 
@@ -703,18 +699,15 @@ static void hci_host_control(uint16_t ocf, int plen, uint8_t *data)
 		break;
 
 	case OCF_WRITE_SCAN_ENABLE:
-		status = 0x00;
 		vdev.scan_enable = scan_enable(data);
 		command_complete(ogf, ocf, 1, &status);
 		break;
 
 	case OCF_WRITE_AUTH_ENABLE:
-		status = 0x00;
 		command_complete(ogf, ocf, 1, &status);
 		break;
 
 	case OCF_WRITE_ENCRYPT_MODE:
-		status = 0x00;
 		command_complete(ogf, ocf, 1, &status);
 		break;
 
@@ -725,7 +718,6 @@ static void hci_host_control(uint16_t ocf, int plen, uint8_t *data)
 		break;
 
 	case OCF_WRITE_CLASS_OF_DEV:
-		status = 0x00;
 		memcpy(vdev.dev_class, data, 3);
 		command_complete(ogf, ocf, 1, &status);
 		break;
@@ -737,7 +729,6 @@ static void hci_host_control(uint16_t ocf, int plen, uint8_t *data)
 		break;
 
 	case OCF_WRITE_INQUIRY_MODE:
-		status = 0x00;
 		vdev.inq_mode = data[0];
 		command_complete(ogf, ocf, 1, &status);
 		break;
@@ -750,7 +741,6 @@ static void hci_host_control(uint16_t ocf, int plen, uint8_t *data)
 		break;
 
 	case OCF_WRITE_EXT_INQUIRY_RESPONSE:
-		status = 0x00;
 		vdev.eir_fec = data[0];
 		memcpy(vdev.eir_data, data + 1, HCI_MAX_EIR_LENGTH);
 		command_complete(ogf, ocf, 1, &status);
@@ -763,7 +753,6 @@ static void hci_host_control(uint16_t ocf, int plen, uint8_t *data)
 		break;
 
 	case OCF_WRITE_SIMPLE_PAIRING_MODE:
-		status = 0x00;
 		vdev.ssp_mode = data[0];
 		command_complete(ogf, ocf, 1, &status);
 		break;
@@ -776,7 +765,6 @@ static void hci_host_control(uint16_t ocf, int plen, uint8_t *data)
 		break;
 
 	case OCF_WRITE_LE_HOST_SUPPORTED:
-		status = 0x00;
 		vdev.le_mode = data[0];
 		vdev.le_simul = data[1];
 		command_complete(ogf, ocf, 1, &status);
-- 
on behalf of ST-Ericsson

