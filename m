Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] audio/avrcp: Use SetAddressedPlayer when player changes
Date: Thu, 18 Aug 2016 15:45:27 +0300
Message-Id: <1471524327-15455-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1471524327-15455-1-git-send-email-luiz.dentz@gmail.com>
References: <1471524327-15455-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This ensures the right player id is addressed before sending commands as
a different player maybe have been set as addressed.
---
 profiles/audio/avrcp.c | 115 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 89 insertions(+), 26 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 21acee3..e20515d 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2793,6 +2793,83 @@ static void avrcp_set_player_value(struct avrcp *session, uint8_t attr,
 					avrcp_player_value_rsp, session);
 }
 
+static gboolean avrcp_set_addressed_player_rsp(struct avctp *conn, uint8_t code,
+					uint8_t subunit, uint8_t transaction,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->controller->player;
+	struct avrcp_header *pdu = (void *) operands;
+
+	if (!pdu || code != AVC_CTYPE_ACCEPTED)
+		return FALSE;
+
+	player->addressed = true;
+
+	return FALSE;
+}
+
+static void avrcp_set_addressed_player(struct avrcp *session,
+						struct avrcp_player *player)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + 2];
+	struct avrcp_header *pdu = (void *) buf;
+	uint16_t id;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_SET_ADDRESSED_PLAYER;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+	id = htons(player->id);
+	memcpy(pdu->params, &id, 2);
+	pdu->params_len = htons(2);
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_CONTROL,
+					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
+					avrcp_set_addressed_player_rsp,
+					session);
+}
+
+static void set_addressed_player(struct avrcp *session,
+					struct avrcp_player *player)
+{
+	if (!player || !player->id || player->addressed ||
+				session->controller->version < 0x0104)
+		return;
+
+	/* Set player as addressed */
+	avrcp_set_addressed_player(session, player);
+}
+
+static void set_browsed_player(struct avrcp *session,
+					struct avrcp_player *player)
+{
+	if (!player || !player->id || player->browsed)
+		return;
+
+	if (media_player_get_browsable(player->user_data))
+		avrcp_set_browsed_player(session, player);
+}
+
+static void set_ct_player(struct avrcp *session, struct avrcp_player *player)
+{
+	struct btd_service *service;
+
+	if (session->controller->player == player)
+		goto done;
+
+	session->controller->player = player;
+	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
+	control_set_player(service, player ?
+			media_player_get_path(player->user_data) : NULL);
+
+done:
+	set_addressed_player(session, player);
+	set_browsed_player(session, player);
+}
+
 static bool ct_set_setting(struct media_player *mp, const char *key,
 					const char *value, void *user_data)
 {
@@ -2808,6 +2885,8 @@ static bool ct_set_setting(struct media_player *mp, const char *key,
 	if (session->controller->version < 0x0103)
 		return false;
 
+	set_ct_player(session, player);
+
 	attr = attr_to_val(key);
 	if (attr < 0)
 		return false;
@@ -2830,6 +2909,8 @@ static int ct_press(struct avrcp_player *player, uint8_t op)
 	if (session == NULL)
 		return -ENOTCONN;
 
+	set_ct_player(session, player);
+
 	err = avctp_send_passthrough(session->conn, op);
 	if (err < 0)
 		return err;
@@ -2898,6 +2979,8 @@ static int ct_list_items(struct media_player *mp, const char *name,
 
 	session = player->sessions->data;
 
+	set_ct_player(session, player);
+
 	if (g_str_has_prefix(name, "/NowPlaying"))
 		player->scope = 0x03;
 	else if (g_str_has_suffix(name, "/search"))
@@ -2942,6 +3025,7 @@ static int ct_change_folder(struct media_player *mp, const char *path,
 	uint8_t direction;
 
 	session = player->sessions->data;
+	set_ct_player(session, player);
 	player->change_path = g_strdup(path);
 
 	direction = g_str_has_prefix(path, player->path) ? 0x01 : 0x00;
@@ -3008,6 +3092,7 @@ static int ct_search(struct media_player *mp, const char *string,
 
 	session = player->sessions->data;
 
+	set_ct_player(session, player);
 	avrcp_search(session, string);
 
 	return 0;
@@ -3048,6 +3133,7 @@ static int ct_play_item(struct media_player *mp, const char *name,
 		return -EBUSY;
 
 	session = player->sessions->data;
+	set_ct_player(session, player);
 
 	if (g_strrstr(name, "/NowPlaying"))
 		player->scope = 0x03;
@@ -3100,6 +3186,7 @@ static int ct_add_to_nowplaying(struct media_player *mp, const char *name,
 	else
 		player->scope = 0x01;
 
+	set_ct_player(session, player);
 	avrcp_add_to_nowplaying(session, uid);
 
 	return 0;
@@ -3159,6 +3246,7 @@ static int ct_get_total_numberofitems(struct media_player *mp, const char *name,
 	struct avrcp *session;
 
 	session = player->sessions->data;
+	set_ct_player(session, player);
 
 	if (session->controller->version != 0x0106) {
 		error("version not supported");
@@ -3194,32 +3282,6 @@ static const struct media_player_callback ct_cbs = {
 	.total_items = ct_get_total_numberofitems,
 };
 
-static void set_browsed_player(struct avrcp *session,
-					struct avrcp_player *player)
-{
-	if (!player || !player->id || player->browsed)
-		return;
-
-	if (media_player_get_browsable(player->user_data))
-		avrcp_set_browsed_player(session, player);
-}
-
-static void set_ct_player(struct avrcp *session, struct avrcp_player *player)
-{
-	struct btd_service *service;
-
-	if (session->controller->player == player)
-		goto done;
-
-	session->controller->player = player;
-	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
-	control_set_player(service, player ?
-			media_player_get_path(player->user_data) : NULL);
-
-done:
-	set_browsed_player(session, player);
-}
-
 static struct avrcp_player *create_ct_player(struct avrcp *session,
 								uint16_t id)
 {
@@ -3540,6 +3602,7 @@ static void avrcp_addressed_player_changed(struct avrcp *session,
 			return;
 	}
 
+	player->addressed = true;
 	player->uid_counter = get_be16(&pdu->params[3]);
 	set_ct_player(session, player);
 
-- 
2.7.4

