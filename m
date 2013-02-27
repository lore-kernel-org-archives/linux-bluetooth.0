Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/9] AVRCP: Fix changing track metadata too many times
Date: Wed, 27 Feb 2013 15:15:57 +0200
Message-Id: <1361970961-14300-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1361970961-14300-1-git-send-email-luiz.dentz@gmail.com>
References: <1361970961-14300-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Certain stacks may respond to GetPlayStatus before GetItemAttributes
(e.g iOS 6), which may cause Track to be changed due to duration being
different.

To fix this the code now only attempt to do GetPlayStatus once
GetItemAttributes completes, in addition to this do not require a exact
match of the duration because they can be different as can be observed
bellow:

> L2CAP(d): cid 0x0044 len 141 ctrl 0x0c16 fcs 0xa5ad [psm 27]
    I-frame: Unsegmented TxSeq 11 ReqSeq 12
    AVCTP Browsing: Response : pt 0x00 transaction 11 pid 0x110e
      AVRCP: GetItemAttributes: len 0x0083
...
        AttributeID: 0x00000007 (Track duration)
        CharsetID: 0x006a (UTF-8)
        AttributeLength: 0x0006 (6)
        AttributeValue: 222641
...
> L2CAP(d): cid 0x0043 len 22 [psm 23]
    AVCTP Control: Response : pt 0x00 transaction 2 pid 0x110e
      AV/C: Stable: address 0x48 opcode 0x00
        Subunit: Panel
        Opcode: Vendor Dependent
        Company ID: 0x001958
        AVRCP: GetPlayStatus: pt Single len 0x0009
          SongLength: 0x00036597 (222615 miliseconds)
          SongPosition: 0x00000000 (0 miliconds)
          PlayStatus: 0x02 (PAUSED)
---
 profiles/audio/avrcp.c  |  6 ++++--
 profiles/audio/player.c | 11 +++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index b14d10c..32c9fd5 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1844,6 +1844,8 @@ static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
 
 	avrcp_parse_attribute_list(player, &pdu->params[1], count);
 
+	avrcp_get_play_status(session);
+
 	return FALSE;
 }
 
@@ -2006,6 +2008,8 @@ static gboolean avrcp_get_item_attributes_rsp(struct avctp *conn,
 
 	avrcp_parse_attribute_list(player, &pdu->params[2], count);
 
+	avrcp_get_play_status(session);
+
 	return FALSE;
 }
 
@@ -2180,8 +2184,6 @@ static void avrcp_track_changed(struct avrcp *session,
 		avrcp_get_item_attributes(session, uid);
 	} else
 		avrcp_get_element_attributes(session);
-
-	avrcp_get_play_status(session);
 }
 
 static void avrcp_setting_changed(struct avrcp *session,
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 44452ac..e10cf0c 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -791,13 +791,16 @@ void media_player_set_duration(struct media_player *mp, uint32_t duration)
 
 	DBG("%u", duration);
 
-	value = g_strdup_printf("%u", duration);
+	/* Only update duration if track exists */
+	if (g_hash_table_size(mp->track) == 0)
+		return;
 
+	/* Ignore if duration is already set */
 	curval = g_hash_table_lookup(mp->track, "Duration");
-	if (g_strcmp0(curval, value) == 0) {
-		g_free(value);
+	if (curval != NULL)
 		return;
-	}
+
+	value = g_strdup_printf("%u", duration);
 
 	g_hash_table_replace(mp->track, g_strdup("Duration"), value);
 
-- 
1.8.1.2

