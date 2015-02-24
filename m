Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] android/socket: Add fake service for SDP testing
Date: Tue, 24 Feb 2015 13:05:59 +0100
Message-Id: <1424779561-12403-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds fake L2CAP based service that adds SDP records required
for passing SDP qualification tests.

L2CAP sockets are currently not used in Android so it should be safe
to use it.
---
 android/socket.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index ec78dcd..15e1bfc 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -98,6 +98,10 @@ static GList *connections = NULL;
 
 static struct rfcomm_channel servers[RFCOMM_CHANNEL_MAX + 1];
 
+static uint32_t test_sdp_record_uuid16 = 0;
+static uint32_t test_sdp_record_uuid32 = 0;
+static uint32_t test_sdp_record_uuid128 = 0;
+
 static int rfsock_set_buffer(struct rfcomm_sock *rfsock)
 {
 	socklen_t len = sizeof(int);
@@ -878,6 +882,113 @@ failed:
 	return HAL_STATUS_FAILED;
 }
 
+static uint32_t add_test_record(uuid_t *uuid)
+{
+	sdp_record_t *record;
+	sdp_list_t *svclass_id;
+	sdp_list_t *seq, *pbg_seq, *proto_seq, *ap_seq;
+	sdp_list_t *proto, *proto1, *aproto;
+	uuid_t l2cap_uuid, pbg_uuid, ap_uuid;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return 0;
+
+	record->handle =  sdp_next_handle();
+
+	svclass_id = sdp_list_append(NULL, uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto = sdp_list_append(NULL, &l2cap_uuid);
+	seq = sdp_list_append(NULL, proto);
+
+	proto_seq = sdp_list_append(NULL, seq);
+	sdp_set_access_protos(record, proto_seq);
+
+	sdp_uuid16_create(&pbg_uuid, PUBLIC_BROWSE_GROUP);
+	pbg_seq = sdp_list_append(NULL, &pbg_uuid);
+	sdp_set_browse_groups(record, pbg_seq);
+
+	/* Additional Protocol Descriptor List */
+	sdp_uuid16_create(&ap_uuid, L2CAP_UUID);
+	proto1 = sdp_list_append(NULL, &ap_uuid);
+	ap_seq = sdp_list_append(NULL, proto1);
+	aproto = sdp_list_append(NULL, ap_seq);
+	sdp_set_add_access_protos(record, aproto);
+
+	sdp_set_service_id(record, *uuid);
+	sdp_set_record_state(record, 0);
+	sdp_set_service_ttl(record, 0);
+	sdp_set_service_avail(record, 0);
+	sdp_set_url_attr(record, "http://www.bluez.org",
+				"http://www.bluez.org", "http://www.bluez.org");
+
+	sdp_list_free(proto, NULL);
+	sdp_list_free(seq, NULL);
+	sdp_list_free(proto_seq, NULL);
+	sdp_list_free(pbg_seq, NULL);
+	sdp_list_free(svclass_id, NULL);
+
+	if (bt_adapter_add_record(record, 0) < 0) {
+		sdp_record_free(record);
+		return 0;
+	}
+
+	return record->handle;
+}
+
+static void test_sdp_cleanup(void)
+{
+	if (test_sdp_record_uuid16) {
+		bt_adapter_remove_record(test_sdp_record_uuid16);
+		test_sdp_record_uuid16 = 0;
+	}
+
+	if (test_sdp_record_uuid32) {
+		bt_adapter_remove_record(test_sdp_record_uuid32);
+		test_sdp_record_uuid32 = 0;
+	}
+
+	if (test_sdp_record_uuid128) {
+		bt_adapter_remove_record(test_sdp_record_uuid128);
+		test_sdp_record_uuid128 = 0;
+	}
+}
+
+static void test_sdp_init(void)
+{
+	char uuid128[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+				0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	uuid_t u;
+
+	sdp_uuid16_create(&u, 0xffff);
+	test_sdp_record_uuid16 = add_test_record(&u);
+
+	sdp_uuid32_create(&u, 0xffffffff);
+	test_sdp_record_uuid32 = add_test_record(&u);
+
+	sdp_uuid128_create(&u, uuid128);
+	test_sdp_record_uuid128 = add_test_record(&u);
+}
+
+static uint8_t l2cap_listen(int chan, const uint8_t *name, const uint8_t *uuid,
+						uint8_t flags, int *hal_sock)
+{
+	/* TODO be more strict here? */
+	if (strcmp("BlueZ", (const char *) name)) {
+		error("socket: Only SDP test supported on L2CAP");
+		return HAL_STATUS_UNSUPPORTED;
+	}
+
+	test_sdp_cleanup();
+	test_sdp_init();
+
+	*hal_sock = -1;
+
+	return HAL_STATUS_SUCCESS;
+}
+
 static void handle_listen(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_socket_listen *cmd = buf;
@@ -889,8 +1000,11 @@ static void handle_listen(const void *buf, uint16_t len)
 		status = rfcomm_listen(cmd->channel, cmd->name, cmd->uuid,
 							cmd->flags, &hal_sock);
 		break;
-	case HAL_SOCK_SCO:
 	case HAL_SOCK_L2CAP:
+		status = l2cap_listen(cmd->channel, cmd->name, cmd->uuid,
+							cmd->flags, &hal_sock);
+		break;
+	case HAL_SOCK_SCO:
 		status = HAL_STATUS_UNSUPPORTED;
 		break;
 	default:
@@ -1193,6 +1307,8 @@ void bt_socket_unregister(void)
 
 	DBG("");
 
+	test_sdp_cleanup();
+
 	g_list_free_full(connections, cleanup_rfsock);
 
 	for (ch = 0; ch <= RFCOMM_CHANNEL_MAX; ch++)
-- 
1.9.3

