Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] unit/test-avrcp: Remove DBG calls
Date: Fri, 27 Mar 2015 10:49:53 +0200
Message-Id: <1427446194-5646-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1427446194-5646-1-git-send-email-luiz.dentz@gmail.com>
References: <1427446194-5646-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-avrcp.c | 70 -------------------------------------------------------
 1 file changed, 70 deletions(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index b0404c9..024e38e 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -200,8 +200,6 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 	ssize_t len;
 	int fd;
 
-	DBG("");
-
 	pdu = &context->data->pdu_list[context->pdu_offset++];
 
 	g_assert(!pdu->browse);
@@ -241,8 +239,6 @@ static gboolean browse_test_handler(GIOChannel *channel, GIOCondition cond,
 	ssize_t len;
 	int fd;
 
-	DBG("");
-
 	pdu = &context->data->pdu_list[context->pdu_offset++];
 
 	g_assert(pdu->browse);
@@ -277,8 +273,6 @@ static struct context *create_context(uint16_t version, gconstpointer data)
 	GIOChannel *channel;
 	int err, sv[2];
 
-	DBG("");
-
 	/* Control channel setup */
 
 	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
@@ -339,39 +333,29 @@ static void test_dummy(gconstpointer data)
 
 static bool handle_play(struct avrcp *session, bool pressed, void *user_data)
 {
-	DBG("");
-
 	return true;
 }
 
 static bool handle_volume_up(struct avrcp *session, bool pressed,
 							void *user_data)
 {
-	DBG("");
-
 	return true;
 }
 
 static bool handle_channel_up(struct avrcp *session, bool pressed,
 							void *user_data)
 {
-	DBG("");
-
 	return true;
 }
 
 static bool handle_select(struct avrcp *session, bool pressed, void *user_data)
 {
-	DBG("");
-
 	return true;
 }
 
 static bool handle_vendor_uniq(struct avrcp *session, bool pressed,
 								void *user_data)
 {
-	DBG("");
-
 	return true;
 }
 
@@ -393,8 +377,6 @@ static int get_capabilities(struct avrcp *session, uint8_t transaction,
 static int list_attributes(struct avrcp *session, uint8_t transaction,
 							void *user_data)
 {
-	DBG("");
-
 	avrcp_list_player_attributes_rsp(session, transaction, 0, NULL);
 
 	return 0;
@@ -406,8 +388,6 @@ static int get_attribute_text(struct avrcp *session, uint8_t transaction,
 {
 	const char *text[number];
 
-	DBG("");
-
 	if (number) {
 		memset(text, 0, number);
 		text[0] = "equalizer";
@@ -422,8 +402,6 @@ static int get_attribute_text(struct avrcp *session, uint8_t transaction,
 static int list_values(struct avrcp *session, uint8_t transaction,
 						uint8_t attr, void *user_data)
 {
-	DBG("");
-
 	avrcp_list_player_values_rsp(session, transaction, 0, NULL);
 
 	return -EINVAL;
@@ -435,8 +413,6 @@ static int get_value_text(struct avrcp *session, uint8_t transaction,
 {
 	const char *text[number];
 
-	DBG("");
-
 	if (number) {
 		memset(text, 0, number);
 		text[0] = "on";
@@ -453,8 +429,6 @@ static int get_value(struct avrcp *session, uint8_t transaction,
 {
 	uint8_t values[number];
 
-	DBG("");
-
 	memset(values, 0, number);
 
 	avrcp_get_current_player_value_rsp(session, transaction, number, attrs,
@@ -467,8 +441,6 @@ static int set_value(struct avrcp *session, uint8_t transaction,
 			uint8_t number, uint8_t *attrs, uint8_t *values,
 			void *user_data)
 {
-	DBG("");
-
 	avrcp_set_player_value_rsp(session, transaction);
 
 	return 0;
@@ -477,8 +449,6 @@ static int set_value(struct avrcp *session, uint8_t transaction,
 static int get_play_status(struct avrcp *session, uint8_t transaction,
 							void *user_data)
 {
-	DBG("");
-
 	avrcp_get_play_status_rsp(session, transaction, 0xaaaaaaaa, 0xbbbbbbbb,
 									0x00);
 
@@ -491,8 +461,6 @@ static int get_element_attributes(struct avrcp *session, uint8_t transaction,
 {
 	struct context *context = user_data;
 
-	DBG("");
-
 	if (g_str_has_prefix(context->data->test_name, "/TP/RCR")) {
 		uint8_t params[1024];
 
@@ -513,8 +481,6 @@ static int track_changed(struct avrcp *session, uint8_t transaction,
 	struct context *context = user_data;
 	uint64_t track;
 
-	DBG("");
-
 	if (g_str_equal(context->data->test_name, "/TP/NFY/BV-05-C") ||
 		g_str_equal(context->data->test_name, "/TP/NFY/BV-08-C"))
 		memset(&track, 0, sizeof(track));
@@ -537,8 +503,6 @@ static int settings_changed(struct avrcp *session, uint8_t transaction,
 {
 	uint8_t settings[3];
 
-	DBG("");
-
 	settings[0] = 0x01;
 	settings[1] = 0x01;
 	settings[2] = 0x02;
@@ -557,8 +521,6 @@ static int settings_changed(struct avrcp *session, uint8_t transaction,
 static int available_players_changed(struct avrcp *session, uint8_t transaction,
 					uint32_t interval, void *user_data)
 {
-	DBG("");
-
 	avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_INTERIM,
 					AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED,
 					NULL, 0);
@@ -575,8 +537,6 @@ static int addressed_player_changed(struct avrcp *session, uint8_t transaction,
 {
 	uint16_t player[2];
 
-	DBG("");
-
 	player[0] = 0x0001;
 	player[1] = 0x0001;
 
@@ -600,8 +560,6 @@ static int uids_changed(struct avrcp *session, uint8_t transaction,
 	struct context *context = user_data;
 	uint16_t counter;
 
-	DBG("");
-
 	if (g_str_equal(context->data->test_name, "/TP/MCN/CB/BV-09-C"))
 		counter = 0x0000;
 	else
@@ -628,8 +586,6 @@ static int now_playing_content_changed(struct avrcp *session,
 					uint8_t transaction, uint32_t interval,
 					void *user_data)
 {
-	DBG("");
-
 	avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_INTERIM,
 					AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED,
 					NULL, 0);
@@ -646,8 +602,6 @@ static int volume_changed(struct avrcp *session, uint8_t transaction,
 {
 	uint8_t volume = 0x00;
 
-	DBG("");
-
 	avrcp_register_notification_rsp(session, transaction, AVC_CTYPE_INTERIM,
 					AVRCP_EVENT_VOLUME_CHANGED,
 					&volume, sizeof(volume));
@@ -665,8 +619,6 @@ static int register_notification(struct avrcp *session, uint8_t transaction,
 					uint8_t event, uint32_t interval,
 					void *user_data)
 {
-	DBG("");
-
 	switch (event) {
 	case AVRCP_EVENT_TRACK_CHANGED:
 		return track_changed(session, transaction, interval, user_data);
@@ -695,8 +647,6 @@ static int register_notification(struct avrcp *session, uint8_t transaction,
 static int set_volume(struct avrcp *session, uint8_t transaction,
 					uint8_t volume, void *user_data)
 {
-	DBG("");
-
 	avrcp_set_volume_rsp(session, transaction, volume);
 
 	return 0;
@@ -708,8 +658,6 @@ static int set_addressed(struct avrcp *session, uint8_t transaction,
 	struct context *context = user_data;
 	uint8_t status;
 
-	DBG("");
-
 	if (g_str_equal(context->data->test_name, "/TP/MPS/BI-01-C"))
 		status = AVRCP_STATUS_INVALID_PLAYER_ID;
 	else
@@ -726,8 +674,6 @@ static int set_browsed(struct avrcp *session, uint8_t transaction,
 	struct context *context = user_data;
 	const char *folders[1] = { "Filesystem" };
 
-	DBG("");
-
 	if (g_str_equal(context->data->test_name, "/TP/MPS/BI-02-C"))
 		avrcp_set_browsed_player_rsp(session, transaction,
 						AVRCP_STATUS_INVALID_PLAYER_ID,
@@ -747,8 +693,6 @@ static int get_folder_items(struct avrcp *session, uint8_t transaction,
 {
 	struct context *context = user_data;
 
-	DBG("");
-
 	if (g_str_equal(context->data->test_name, "/TP/MCN/CB/BI-02-C"))
 		return -ERANGE;
 
@@ -765,8 +709,6 @@ static int change_path(struct avrcp *session, uint8_t transaction,
 					uint16_t counter, uint8_t direction,
 					uint64_t uid, void *user_data)
 {
-	DBG("");
-
 	if (!uid)
 		return -ENOTDIR;
 
@@ -783,8 +725,6 @@ static int get_item_attributes(struct avrcp *session, uint8_t transaction,
 	struct context *context = user_data;
 	uint8_t status;
 
-	DBG("");
-
 	if (g_str_equal(context->data->test_name, "/TP/MCN/CB/BI-05-C"))
 		status = AVRCP_STATUS_UID_CHANGED;
 	else
@@ -799,8 +739,6 @@ static int get_item_attributes(struct avrcp *session, uint8_t transaction,
 static int play_item(struct avrcp *session, uint8_t transaction, uint8_t scope,
 			uint64_t uid, uint16_t counter, void *user_data)
 {
-	DBG("");
-
 	if (!uid)
 		return -ENOENT;
 
@@ -812,8 +750,6 @@ static int play_item(struct avrcp *session, uint8_t transaction, uint8_t scope,
 static int search(struct avrcp *session, uint8_t transaction,
 					const char *string, void *user_data)
 {
-	DBG("");
-
 	avrcp_search_rsp(session, transaction, AVRCP_STATUS_SUCCESS, 0xaabb, 0);
 
 	return 0;
@@ -823,8 +759,6 @@ static int add_to_now_playing(struct avrcp *session, uint8_t transaction,
 				uint8_t scope, uint64_t uid, uint16_t counter,
 				void *user_data)
 {
-	DBG("");
-
 	if (!uid)
 		return -ENOENT;
 
@@ -873,8 +807,6 @@ static void get_folder_items_rsp(struct avrcp *session, int err,
 {
 	struct context *context = user_data;
 
-	DBG("");
-
 	g_assert_cmpint(err, ==, 0);
 	g_assert_cmpint(counter, ==, 0xabcd);
 	g_assert_cmpint(number, ==, 0);
@@ -899,8 +831,6 @@ static bool register_notification_rsp(struct avrcp *session, int err,
 {
 	struct context *context = user_data;
 
-	DBG("");
-
 	g_assert_cmpint(err, ==, 0);
 
 	switch (event) {
-- 
2.1.0

