Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 03/22] Replace bt_get_be64() by get_be64()
Date: Mon, 24 Mar 2014 16:25:24 -0300
Message-Id: <1395689143-11091-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avrcp-lib.c    | 2 +-
 monitor/sdp.c          | 2 +-
 profiles/audio/avrcp.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 5e678ea..934106b 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -506,7 +506,7 @@ static ssize_t get_element_attributes(struct avrcp *session,
 	if (!params || params_len != 9 + params[8] * 4)
 		return -EINVAL;
 
-	uid = bt_get_be64(params);
+	uid = get_be64(params);
 	number = params[8];
 
 	for (i = 0; i < number; i++) {
diff --git a/monitor/sdp.c b/monitor/sdp.c
index d729e1f..e997ca5 100644
--- a/monitor/sdp.c
+++ b/monitor/sdp.c
@@ -98,7 +98,7 @@ static void print_uint(uint8_t indent, const uint8_t *data, uint32_t size)
 		break;
 	case 8:
 		print_field("%*c0x%16.16" PRIx64, indent, ' ',
-							bt_get_be64(data));
+							get_be64(data));
 		break;
 	default:
 		packet_hexdump(data, size);
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 6772984..ebd10a9 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2126,7 +2126,7 @@ static struct media_item *parse_media_element(struct avrcp *session,
 	if (len < 13)
 		return NULL;
 
-	uid = bt_get_be64(&operands[0]);
+	uid = get_be64(&operands[0]);
 
 	namelen = MIN(get_be16(&operands[11]), sizeof(name) - 1);
 	if (namelen > 0) {
@@ -2161,7 +2161,7 @@ static struct media_item *parse_media_folder(struct avrcp *session,
 	if (len < 12)
 		return NULL;
 
-	uid = bt_get_be64(&operands[0]);
+	uid = get_be64(&operands[0]);
 	type = operands[8];
 	playable = operands[9];
 
@@ -3072,7 +3072,7 @@ static void avrcp_track_changed(struct avrcp *session,
 {
 	if (session->browsing_id) {
 		struct avrcp_player *player = session->controller->player;
-		player->uid = bt_get_be64(&pdu->params[1]);
+		player->uid = get_be64(&pdu->params[1]);
 		avrcp_get_item_attributes(session, player->uid);
 	} else
 		avrcp_get_element_attributes(session);
-- 
1.8.3.1

