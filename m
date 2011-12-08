Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hciemu v2 1/2] Process Read Local AMP Info in hciemu
Date: Thu,  8 Dec 2011 10:54:36 +0200
Message-Id: <1323334477-32179-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add processing of Read Local AMP Info in hciemu, the values returned are
used to emulate AMP HCI.
---
 test/hciemu.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/test/hciemu.c b/test/hciemu.c
index f2879ba..ccd6cc3 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -45,6 +45,7 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
+#include <bluetooth/l2cap.h>
 
 #define VHCI_DEV		"/dev/vhci"
 
@@ -779,6 +780,36 @@ static void hci_info_param(uint16_t ocf, int plen, uint8_t *data)
 	}
 }
 
+static void hci_status_param(uint16_t ocf, int plen, uint8_t *data)
+{
+	read_local_amp_info_rp ai;
+	uint8_t status;
+
+	const uint16_t ogf = OGF_STATUS_PARAM;
+
+	switch (ocf) {
+	case OCF_READ_LOCAL_AMP_INFO:
+		memset(&ai, 0, sizeof(ai));
+
+		/* BT only */
+		ai.amp_status = 0x01;
+		ai.max_pdu_size = htobl(L2CAP_DEFAULT_MTU);
+		ai.controller_type = HCI_AMP;
+		ai.max_amp_assoc_length = htobl(HCI_MAX_ACL_SIZE);
+		/* No flushing at all */
+		ai.max_flush_timeout = 0xFFFFFFFF;
+		ai.best_effort_flush_timeout = 0xFFFFFFFF;
+
+		command_complete(ogf, ocf, sizeof(ai), &ai);
+		break;
+
+	default:
+		status = 0x01;
+		command_complete(ogf, ocf, 1, &status);
+		break;
+	}
+}
+
 static void hci_command(uint8_t *data)
 {
 	hci_command_hdr *ch;
@@ -808,6 +839,10 @@ static void hci_command(uint8_t *data)
 	case OGF_INFO_PARAM:
 		hci_info_param(ocf, ch->plen, ptr);
 		break;
+
+	case OGF_STATUS_PARAM:
+		hci_status_param(ocf, ch->plen, ptr);
+		break;
 	}
 }
 
-- 
1.7.4.1

