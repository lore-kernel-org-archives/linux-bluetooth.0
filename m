Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 19/62] Replace bt_put_be64() by get_be64()
Date: Thu, 20 Mar 2014 11:42:44 -0300
Message-Id: <1395326607-27068-20-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/avrcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 1d439ec..da2a746 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2449,7 +2449,7 @@ static void avrcp_get_item_attributes(struct avrcp *session, uint64_t uid)
 
 	pdu->pdu_id = AVRCP_GET_ITEM_ATTRIBUTES;
 	pdu->params[0] = 0x03;
-	bt_put_be64(uid, &pdu->params[1]);
+	put_be64(uid, &pdu->params[1]);
 	put_be16(player->uid_counter, &pdu->params[9]);
 	pdu->param_len = htons(12);
 
@@ -2636,7 +2636,7 @@ static void avrcp_change_path(struct avrcp *session, uint8_t direction,
 	memset(buf, 0, sizeof(buf));
 	put_be16(player->uid_counter, &pdu->params[0]);
 	pdu->params[2] = direction;
-	bt_put_be64(uid, &pdu->params[3]);
+	put_be64(uid, &pdu->params[3]);
 	pdu->pdu_id = AVRCP_CHANGE_PATH;
 	pdu->param_len = htons(11);
 
@@ -2738,7 +2738,7 @@ static void avrcp_play_item(struct avrcp *session, uint64_t uid)
 	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
 
 	pdu->params[0] = player->scope;
-	bt_put_be64(uid, &pdu->params[1]);
+	put_be64(uid, &pdu->params[1]);
 	put_be16(player->uid_counter, &pdu->params[9]);
 
 	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
@@ -2784,7 +2784,7 @@ static void avrcp_add_to_nowplaying(struct avrcp *session, uint64_t uid)
 	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
 
 	pdu->params[0] = player->scope;
-	bt_put_be64(uid, &pdu->params[1]);
+	put_be64(uid, &pdu->params[1]);
 	put_be16(player->uid_counter, &pdu->params[9]);
 
 	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
-- 
1.8.3.1

