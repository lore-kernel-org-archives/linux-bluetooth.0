Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] AVRCP: Add support for sending SetAbsoluteVolume
Date: Fri, 25 May 2012 18:02:47 +0300
Message-Id: <1337958168-9875-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
References: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Once the transport volume is changed update the remote volume by sending
SetAbsoluteVolume:

< AVCTP: Command : pt 0x00 transaction 9 pid 0x110e
    AV/C: Changed: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: SetAbsoluteVolume: pt Single len 0x0001
        Volume: 100.00% (127/127)
> AVCTP: Response : pt 0x00 transaction 9 pid 0x110e
    AV/C: Accepted: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: SetAbsoluteVolume: pt Single len 0x0001
        Volume: 100.00% (127/127)
---
 audio/avrcp.c     |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/avrcp.h     |    2 ++
 audio/transport.c |   16 ++++++++++++++++
 3 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 30d696a..b7be9e2 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -87,6 +87,7 @@
 #define AVRCP_REGISTER_NOTIFICATION	0x31
 #define AVRCP_REQUEST_CONTINUING	0x40
 #define AVRCP_ABORT_CONTINUING		0x41
+#define AVRCP_SET_ABSOLUTE_VOLUME	0x50
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -1412,3 +1413,55 @@ void avrcp_unregister_player(struct avrcp_player *player)
 
 	player_destroy(player);
 }
+
+static gboolean avrcp_handle_set_volume(struct avctp *session,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	struct avrcp_header *pdu = (void *) operands;
+	uint8_t volume;
+
+	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED)
+		return FALSE;
+
+	volume = pdu->params[0] & 0x7F;
+
+	player->cb->set_volume(volume, player->dev, player->user_data);
+
+	return FALSE;
+}
+
+int avrcp_set_volume(struct audio_device *dev, uint8_t volume)
+{
+	struct avrcp_server *server;
+	struct avrcp_player *player;
+	uint8_t buf[AVRCP_HEADER_LENGTH + 1];
+	struct avrcp_header *pdu = (void *) buf;
+
+	server = find_server(servers, &dev->src);
+	if (server == NULL)
+		return -EINVAL;
+
+	player = server->active_player;
+	if (player == NULL)
+		return -ENOTSUP;
+
+	if (player->session == NULL)
+		return -ENOTCONN;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+
+	pdu->pdu_id = AVRCP_SET_ABSOLUTE_VOLUME;
+	pdu->params[0] = volume;
+	pdu->params_len = htons(1);
+
+	DBG("volume=%u", volume);
+
+	return avctp_send_vendordep_req(player->session, AVC_CTYPE_CONTROL,
+					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
+					avrcp_handle_set_volume, player);
+}
diff --git a/audio/avrcp.h b/audio/avrcp.h
index b520ef6..bf11a6c 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -93,6 +93,7 @@ void avrcp_unregister(const bdaddr_t *src);
 
 gboolean avrcp_connect(struct audio_device *dev);
 void avrcp_disconnect(struct audio_device *dev);
+int avrcp_set_volume(struct audio_device *dev, uint8_t volume);
 
 struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
 						struct avrcp_player_cb *cb,
@@ -102,4 +103,5 @@ void avrcp_unregister_player(struct avrcp_player *player);
 
 int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data);
 
+
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
diff --git a/audio/transport.c b/audio/transport.c
index ac9d358..bf86390 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -43,6 +43,7 @@
 #include "a2dp.h"
 #include "headset.h"
 #include "gateway.h"
+#include "avrcp.h"
 
 #ifndef DBUS_TYPE_UNIX_FD
 #define DBUS_TYPE_UNIX_FD -1
@@ -753,6 +754,21 @@ static int set_property_a2dp(struct media_transport *transport,
 
 		/* FIXME: send new delay */
 		return 0;
+	} else if (g_strcmp0(property, "Volume") == 0) {
+		uint16_t volume;
+
+		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(value, &volume);
+
+		if (volume > 127)
+			return -EINVAL;
+
+		if (transport->volume == volume)
+			return 0;
+
+		return avrcp_set_volume(transport->device, volume);
 	}
 
 	return -EINVAL;
-- 
1.7.7.6

