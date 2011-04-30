Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 03/16] Add 'discov_state' field to struct dev_info
Date: Fri, 29 Apr 2011 21:27:19 -0300
Message-Id: <1304123252-14464-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need to track the current discovering state (HALTED, INQUIRY or SCAN)
of the adapter in hciops layer during the discovery procedure. This will
help us to properly update the state of btd_adapter and emit the property
"Discovering" correctly.
---
 plugins/hciops.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 14c973f..dfd00b1 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -52,6 +52,10 @@
 #include "manager.h"
 #include "oob.h"
 
+#define DISCOV_HALTED 0
+#define DISCOV_INQ 1
+#define DISCOV_SCAN 2
+
 static int child_pipe[2] = { -1, -1 };
 
 static guint child_io_id = 0;
@@ -102,6 +106,8 @@ static struct dev_info {
 
 	int8_t tx_power;
 
+	int discov_state;
+
 	uint32_t current_cod;
 	uint32_t wanted_cod;
 	uint32_t pending_cod;
@@ -135,6 +141,34 @@ static struct dev_info {
 	GSList *connections;
 } *devs = NULL;
 
+static inline int get_state(int index)
+{
+	struct dev_info *dev = &devs[index];
+
+	return dev->discov_state;
+}
+
+static void set_state(int index, int state)
+{
+	struct dev_info *dev = &devs[index];
+
+	if (dev->discov_state == state)
+		return;
+
+	dev->discov_state = state;
+
+	DBG("hci%d: new state %d", index, dev->discov_state);
+
+	switch (dev->discov_state) {
+	case DISCOV_HALTED:
+		break;
+	case DISCOV_INQ:
+		break;
+	case DISCOV_SCAN:
+		break;
+	}
+}
+
 static int ignore_device(struct hci_dev_info *di)
 {
 	return hci_test_bit(HCI_RAW, &di->flags) || di->type >> 4 != HCI_BREDR;
@@ -153,6 +187,7 @@ static struct dev_info *init_dev_info(int index, int sk, gboolean registered,
 	dev->registered = registered;
 	dev->already_up = already_up;
 	dev->io_capability = 0x03; /* No Input No Output */
+	dev->discov_state = DISCOV_HALTED;
 
 	return dev;
 }
@@ -1713,14 +1748,23 @@ static void read_bd_addr_complete(int index, read_bd_addr_rp *rp)
 		init_adapter(index);
 }
 
+static inline void cs_inquiry_evt(int index, uint8_t status)
+{
+	if (status) {
+		error("Inquiry Failed with status 0x%02x", status);
+		return;
+	}
+
+	set_state(index, DISCOV_INQ);
+}
+
 static inline void cmd_status(int index, void *ptr)
 {
-	struct dev_info *dev = &devs[index];
 	evt_cmd_status *evt = ptr;
 	uint16_t opcode = btohs(evt->opcode);
 
 	if (opcode == cmd_opcode_pack(OGF_LINK_CTL, OCF_INQUIRY))
-		start_inquiry(&dev->bdaddr, evt->status, FALSE);
+		cs_inquiry_evt(index, evt->status);
 }
 
 static void read_scan_complete(int index, uint8_t status, void *ptr)
@@ -1841,6 +1885,42 @@ static void read_local_oob_data_complete(int index, uint8_t status,
 		oob_read_local_data_complete(adapter, rp->hash, rp->randomizer);
 }
 
+static inline void inquiry_complete_evt(int index, uint8_t status)
+{
+	if (status) {
+		error("Inquiry Failed with status 0x%02x", status);
+		return;
+	}
+
+	set_state(index, DISCOV_HALTED);
+}
+
+static inline void cc_inquiry_cancel(int index, uint8_t status)
+{
+	if (status) {
+		error("Inquiry Cancel Failed with status 0x%02x", status);
+		return;
+	}
+
+	set_state(index, DISCOV_HALTED);
+}
+
+static inline void cc_le_set_scan_enable(int index, uint8_t status)
+{
+	int state;
+
+	if (status) {
+		error("LE Set Scan Enable Failed with status 0x%02x", status);
+		return;
+	}
+
+	state = get_state(index);
+	if (state == DISCOV_SCAN)
+		set_state(index, DISCOV_HALTED);
+	else
+		set_state(index, DISCOV_SCAN);
+}
+
 static inline void cmd_complete(int index, void *ptr)
 {
 	struct dev_info *dev = &devs[index];
@@ -1872,13 +1952,13 @@ static inline void cmd_complete(int index, void *ptr)
 		inquiry_complete(&dev->bdaddr, status, TRUE);
 		break;
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_INQUIRY_CANCEL):
-		inquiry_complete(&dev->bdaddr, status, FALSE);
+		cc_inquiry_cancel(index, status);
 		break;
 	case cmd_opcode_pack(OGF_HOST_CTL, OCF_WRITE_LE_HOST_SUPPORTED):
 		write_le_host_complete(index, status);
 		break;
 	case cmd_opcode_pack(OGF_LE_CTL, OCF_LE_SET_SCAN_ENABLE):
-		btd_event_le_set_scan_enable_complete(&dev->bdaddr, status);
+		cc_le_set_scan_enable(index, status);
 		break;
 	case cmd_opcode_pack(OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME):
 		if (!status)
@@ -2373,7 +2453,7 @@ static gboolean io_security_event(GIOChannel *chan, GIOCondition cond,
 
 	case EVT_INQUIRY_COMPLETE:
 		evt = (evt_cmd_status *) ptr;
-		inquiry_complete(&dev->bdaddr, evt->status, FALSE);
+		inquiry_complete_evt(index, evt->status);
 		break;
 
 	case EVT_INQUIRY_RESULT:
-- 
1.7.1

