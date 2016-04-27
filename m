Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marek Kasik <mkasik@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marek Kasik <mkasik@redhat.com>
Subject: [PATCH BlueZ v2] audio/avrcp: Don't overflow uint32_t
Date: Wed, 27 Apr 2016 13:07:36 +0200
Message-Id: <1461755256-6444-1-git-send-email-mkasik@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't overflow uint32_t when checking whether maximal number of items
was already processed.
This happens when avrcp_handle_media_player_list() is called
with start_item = 0x0 and end_item = UINT32_MAX which is caused
by calling of avrcp_get_media_player_list(). Empty list is returned
in that case.
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 70c184b..3c9142b 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1895,7 +1895,7 @@ static void avrcp_handle_media_player_list(struct avrcp *session,
 		struct player_item *item;
 		uint16_t namelen;
 
-		if (rsp->num_items == (end_item - start_item) + 1)
+		if (rsp->num_items == ((uint64_t) end_item - start_item) + 1)
 			break;
 
 		folder = (void *)&pdu->params[pdu->param_len];
-- 
2.7.4

