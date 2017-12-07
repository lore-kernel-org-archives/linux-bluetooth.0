Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 5/9] tools/btpclient: Add initial support for GAP service
Date: Thu,  7 Dec 2017 15:21:39 +0100
Message-Id: <20171207142143.27324-6-szymon.janc@codecoup.pl>
In-Reply-To: <20171207142143.27324-1-szymon.janc@codecoup.pl>
References: <20171207142143.27324-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to get list of supported commands and present adapters.
---
 tools/btpclient.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 3a4971eeb..e63159824 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -49,6 +49,69 @@ static struct l_queue *devices;
 static char *socket_path;
 static struct btp *btp;
 
+static bool gap_service_registered;
+
+static void btp_gap_read_commands(uint16_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	uint16_t commands = 0;
+
+	if (index != BTP_INDEX_NON_CONTROLLER) {
+		btp_send_error(btp, BTP_GAP_SERVICE, index,
+						BTP_ERROR_INVALID_INDEX);
+		return;
+	}
+
+	commands |= (1 << BTP_OP_GAP_READ_SUPPORTED_COMMANDS);
+	commands |= (1 << BTP_OP_GAP_READ_CONTROLLER_INDEX_LIST);
+
+	commands = L_CPU_TO_LE16(commands);
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_SUPPORTED_COMMANDS,
+			BTP_INDEX_NON_CONTROLLER, sizeof(commands), &commands);
+}
+
+static void btp_gap_read_controller_index(uint16_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	const struct l_queue_entry *entry;
+	struct btp_gap_read_index_rp *rp;
+	uint8_t cnt;
+	int i;
+
+	if (index != BTP_INDEX_NON_CONTROLLER) {
+		btp_send_error(btp, BTP_GAP_SERVICE, index,
+						BTP_ERROR_INVALID_INDEX);
+		return;
+	}
+
+	cnt = l_queue_length(adapters);
+
+	rp = l_malloc(sizeof(*rp) + cnt);
+
+	rp->num = cnt;
+
+	for (i = 0, entry = l_queue_get_entries(adapters); entry;
+						i++, entry = entry->next) {
+		struct btp_adapter *adapter = entry->data;
+
+		rp->indexes[i] = adapter->index;
+	}
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_CONTROLLER_INDEX_LIST,
+			BTP_INDEX_NON_CONTROLLER, sizeof(*rp) + cnt, rp);
+}
+
+static void register_gap_service(void)
+{
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_READ_SUPPORTED_COMMANDS,
+					btp_gap_read_commands, NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE,
+				BTP_OP_GAP_READ_CONTROLLER_INDEX_LIST,
+				btp_gap_read_controller_index, NULL, NULL);
+}
+
 static void btp_core_read_commands(uint16_t index, const void *param,
 					uint16_t length, void *user_data)
 {
@@ -81,6 +144,7 @@ static void btp_core_read_services(uint16_t index, const void *param,
 	}
 
 	services |= (1 << BTP_CORE_SERVICE);
+	services |= (1 << BTP_GAP_SERVICE);
 
 	btp_send(btp, BTP_CORE_SERVICE, BTP_OP_CORE_READ_SUPPORTED_SERVICES,
 			BTP_INDEX_NON_CONTROLLER, sizeof(services), &services);
@@ -89,24 +153,76 @@ static void btp_core_read_services(uint16_t index, const void *param,
 static void btp_core_register(uint16_t index, const void *param,
 					uint16_t length, void *user_data)
 {
+	const struct btp_core_register_cp  *cp = param;
+
+	if (length < sizeof(*cp))
+		goto failed;
+
 	if (index != BTP_INDEX_NON_CONTROLLER) {
 		btp_send_error(btp, BTP_CORE_SERVICE, index,
 						BTP_ERROR_INVALID_INDEX);
 		return;
 	}
 
+	switch (cp->service_id) {
+	case BTP_GAP_SERVICE:
+		if (gap_service_registered)
+			goto failed;
+
+		register_gap_service();
+		gap_service_registered = true;
+		break;
+	case BTP_GATT_SERVICE:
+	case BTP_L2CAP_SERVICE:
+	case BTP_MESH_NODE_SERVICE:
+	case BTP_CORE_SERVICE:
+	default:
+		goto failed;
+	}
+
+	btp_send(btp, BTP_CORE_SERVICE, BTP_OP_CORE_REGISTER,
+					BTP_INDEX_NON_CONTROLLER, 0, NULL);
+	return;
+
+failed:
 	btp_send_error(btp, BTP_CORE_SERVICE, index, BTP_ERROR_FAIL);
 }
 
 static void btp_core_unregister(uint16_t index, const void *param,
 					uint16_t length, void *user_data)
 {
+	const struct btp_core_unregister_cp  *cp = param;
+
+	if (length < sizeof(*cp))
+		goto failed;
+
 	if (index != BTP_INDEX_NON_CONTROLLER) {
 		btp_send_error(btp, BTP_CORE_SERVICE, index,
 						BTP_ERROR_INVALID_INDEX);
 		return;
 	}
 
+	switch (cp->service_id) {
+	case BTP_GAP_SERVICE:
+		if (!gap_service_registered)
+			goto failed;
+
+		btp_unregister_service(btp, BTP_GAP_SERVICE);
+		gap_service_registered = false;
+		break;
+	case BTP_GATT_SERVICE:
+	case BTP_L2CAP_SERVICE:
+	case BTP_MESH_NODE_SERVICE:
+	case BTP_CORE_SERVICE:
+	default:
+		goto failed;
+	}
+
+	btp_send(btp, BTP_CORE_SERVICE, BTP_OP_CORE_UNREGISTER,
+					BTP_INDEX_NON_CONTROLLER, 0, NULL);
+	return;
+
+failed:
 	btp_send_error(btp, BTP_CORE_SERVICE, index, BTP_ERROR_FAIL);
 }
 
-- 
2.14.3

