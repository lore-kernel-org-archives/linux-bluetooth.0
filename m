Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Andr=C3=A9=20Dieb=20Martins?= <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Dieb=20Martins?= <andre.dieb@signove.com>
Subject: [PATCH] Partial implementation of LE events and commands dump.
Date: Thu, 20 Jan 2011 16:18:13 -0300
Message-Id: <1295551093-6718-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 parser/hci.c |  226 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 226 insertions(+), 0 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index 014c8cd..d9bac9b 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -704,6 +704,59 @@ static char *authentication2str(uint8_t authentication)
 	}
 }
 
+static char *eventmask2str(uint8_t mask[8])
+{
+	int i;
+
+	for (i = 0; i < 7; i++) {
+		if (mask[i] != 0x00)
+			return "Reserved";
+	}
+
+	switch (mask[7]) {
+	case 0x00:
+		return "No LE events specified";
+	case 0x01:
+		return "LE Connection Complete Event";
+	case 0x02:
+		return "LE Advertising Report Event";
+	case 0x04:
+		return "LE Connection Update Complete Event";
+	case 0x08:
+		return "LE Read Remote Used Features Complete Event";
+	case 0x10:
+		return "LE Long Term Key Request Event";
+	case 0x1F:
+		return "Default";
+	default:
+		return "Reserved";
+	}
+}
+
+static char *lefeatures2str(uint8_t features[8])
+{
+	if (features[0] & 0x01)
+		return "Link Layer supports LE Encryption";
+
+	return "RFU";
+}
+
+static char *filterpolicy2str(uint8_t policy)
+{
+	switch (policy) {
+	case 0x00:
+		return "Allow scan from any, connection from any";
+	case 0x01:
+		return "Allow scan from white list, connection from any";
+	case 0x02:
+		return "Allow scan from any, connection from white list";
+	case 0x03:
+		return "Allow scan and connection from white list";
+	default:
+		return "Reserved";
+	}
+}
+
 static inline void ext_inquiry_response_dump(int level, struct frame *frm)
 {
 	void *ptr = frm->ptr;
@@ -1499,6 +1552,85 @@ static inline void le_create_connection_dump(int level, struct frame *frm)
 	printf("bdaddr %s type %d\n", addr, cp->peer_bdaddr_type);
 }
 
+static inline void le_set_event_mask_dump(int level, struct frame *frm)
+{
+	int i;
+	le_set_event_mask_cp *cp = frm->ptr;
+
+	p_indent(level, frm);
+	printf("mask 0x");
+	for (i = 0; i < 8; i++)
+		printf("%.2x", cp->mask[i]);
+
+	printf(" (%s)\n", eventmask2str(cp->mask));
+}
+
+static inline void le_set_random_address_dump(int level, struct frame *frm)
+{
+	char addr[18];
+	le_set_random_address_cp *cp = frm->ptr;
+
+	p_indent(level, frm);
+	p_ba2str(&cp->bdaddr, addr);
+	printf("bdaddr %s\n", addr);
+}
+
+
+static inline void le_set_advertising_parameters_dump(int level, struct frame *frm)
+{
+	char addr[18];
+	le_set_advertising_parameters_cp *cp = frm->ptr;
+
+	p_indent(level, frm);
+	printf("min 0x%04xms max 0x%04xms\n", cp->min_interval, cp->max_interval);
+
+	p_indent(level, frm);
+	printf("type 0x%02x (%s) ownbdaddr 0x%02x (%s)\n", cp->advtype,
+			evttype2str(cp->advtype), cp->own_bdaddr_type,
+			bdaddrtype2str(cp->own_bdaddr_type));
+
+	p_indent(level, frm);
+	p_ba2str(&cp->direct_bdaddr, addr);
+	printf("directbdaddr 0x%02x (%s) %s\n", cp->direct_bdaddr_type,
+			bdaddrtype2str(cp->direct_bdaddr_type), addr);
+
+	p_indent(level, frm);
+	printf("channelmap 0x%02x filterpolicy 0x%02x (%s)\n",
+			cp->chan_map, cp->filter, filterpolicy2str(cp->filter));
+}
+
+static inline void le_set_scan_parameters_dump(int level, struct frame *frm)
+{
+	le_set_scan_parameters_cp *cp = frm->ptr;
+
+	p_indent(level, frm);
+	printf("type 0x%02x (%s)\n", cp->type,
+		cp->type == 0x00 ? "passive" : "active");
+
+	p_indent(level, frm);
+	printf("interval %04xms window %04xms\n", cp->interval, cp->window);
+
+	p_indent(level, frm);
+	printf("own address: 0x%02x (%s) policy: %s\n", cp->own_bdaddr_type,
+			bdaddrtype2str(cp->own_bdaddr_type),
+		(cp->filter == 0x00 ? "All" :
+			(cp->filter == 0x01 ? "white list only" : "reserved")));
+}
+
+static inline void le_set_scan_enable_dump(int level, struct frame *frm)
+{
+	le_set_scan_enable_cp *cp = frm->ptr;
+
+	p_indent(level, frm);
+	printf("value 0x%02x (%s)\n", cp->enable,
+		(cp->enable == 0x00 ? "scanning disabled" :
+		"scanning enabled"));
+
+	p_indent(level, frm);
+	printf("filter duplicates 0x%02x (%s)\n", cp->filter_dup,
+		(cp->filter_dup == 0x00 ? "disabled" : "enabled"));
+}
+
 static inline void command_dump(int level, struct frame *frm)
 {
 	hci_command_hdr *hdr = frm->ptr;
@@ -1790,6 +1922,25 @@ static inline void command_dump(int level, struct frame *frm)
 
 	case OGF_LE_CTL:
 		switch (ocf) {
+		case OCF_LE_SET_EVENT_MASK:
+			le_set_event_mask_dump(level + 1, frm);
+			return;
+		case OCF_LE_READ_BUFFER_SIZE:
+		case OCF_LE_READ_LOCAL_SUPPORTED_FEATURES:
+		case OCF_LE_READ_ADVERTISING_CHANNEL_TX_POWER:
+			return;
+		case OCF_LE_SET_RANDOM_ADDRESS:
+			le_set_random_address_dump(level + 1, frm);
+			return;
+		case OCF_LE_SET_ADVERTISING_PARAMETERS:
+			le_set_advertising_parameters_dump(level + 1, frm);
+			return;
+		case OCF_LE_SET_SCAN_PARAMETERS:
+			le_set_scan_parameters_dump(level + 1, frm);
+			return;
+		case OCF_LE_SET_SCAN_ENABLE:
+			le_set_scan_enable_dump(level + 1, frm);
+			return;
 		case OCF_LE_CREATE_CONN:
 			le_create_connection_dump(level + 1, frm);
 			return;
@@ -2455,6 +2606,50 @@ static inline void write_remote_amp_assoc_dump(int level, struct frame *frm)
 	}
 }
 
+static inline void le_read_buffer_size_response_dump(int level, struct frame *frm)
+{
+	le_read_buffer_size_rp *rp = frm->ptr;
+
+	p_indent(level, frm);
+	printf("status 0x%2.2x pktlen 0x%4.4x maxpkt 0x%2.2x\n", rp->status,
+			rp->pkt_len, rp->max_pkt);
+
+	if (rp->status > 0) {
+		p_indent(level, frm);
+		printf("Error: %s\n", status2str(rp->status));
+	}
+}
+
+static inline void le_read_local_supported_features_dump(int level, struct frame *frm)
+{
+	int i;
+	le_read_local_supported_features_rp *rp = frm->ptr;
+
+	p_indent(level, frm);
+	printf("status 0x%2.2x features 0x", rp->status);
+	for (i = 0; i < 8; i++)
+		printf("%2.2x", rp->features[i]);
+	printf(" (%s)\n", lefeatures2str(rp->features));
+
+	if (rp->status > 0) {
+		p_indent(level, frm);
+		printf("Error: %s\n", status2str(rp->status));
+	}
+}
+
+static inline void le_read_advertising_channel_tx_power_dump(int level, struct frame *frm)
+{
+	le_read_advertising_channel_tx_power_rp *rp = frm->ptr;
+
+	p_indent(level, frm);
+	printf("status 0x%2.2x level 0x%x (dBm)\n", rp->status, rp->level);
+
+	if (rp->status > 0) {
+		p_indent(level, frm);
+		printf("Error: %s\n", status2str(rp->status));
+	}
+}
+
 static inline void cmd_complete_dump(int level, struct frame *frm)
 {
 	evt_cmd_complete *evt = frm->ptr;
@@ -2700,6 +2895,37 @@ static inline void cmd_complete_dump(int level, struct frame *frm)
 			return;
 		}
 		break;
+
+	case OGF_LE_CTL:
+		switch (ocf) {
+		case OCF_LE_SET_EVENT_MASK:
+		case OCF_LE_SET_RANDOM_ADDRESS:
+		case OCF_LE_SET_ADVERTISING_PARAMETERS:
+		case OCF_LE_SET_ADVERTISING_DATA:
+		case OCF_LE_SET_SCAN_RESPONSE_DATA:
+		case OCF_LE_SET_ADVERTISE_ENABLE:
+		case OCF_LE_SET_SCAN_PARAMETERS:
+		case OCF_LE_SET_SCAN_ENABLE:
+		case OCF_LE_CREATE_CONN:
+		case OCF_LE_CLEAR_WHITE_LIST:
+		case OCF_LE_ADD_DEVICE_TO_WHITE_LIST:
+		case OCF_LE_REMOVE_DEVICE_FROM_WHITE_LIST:
+		case OCF_LE_SET_HOST_CHANNEL_CLASSIFICATION:
+		case OCF_LE_RECEIVER_TEST:
+		case OCF_LE_TRANSMITTER_TEST:
+			status_response_dump(level, frm);
+			return;
+		case OCF_LE_READ_BUFFER_SIZE:
+			le_read_buffer_size_response_dump(level, frm);
+			return;
+		case OCF_LE_READ_LOCAL_SUPPORTED_FEATURES:
+			le_read_local_supported_features_dump(level, frm);
+			return;
+		case OCF_LE_READ_ADVERTISING_CHANNEL_TX_POWER:
+			le_read_advertising_channel_tx_power_dump(level, frm);
+			return;
+		}
+		break;
 	}
 
 	raw_dump(level, frm);
-- 
1.7.1

