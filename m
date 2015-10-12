Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor/avctp: Decode player features
Date: Mon, 12 Oct 2015 17:24:07 +0300
Message-Id: <1444659847-1725-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This decodes the bits related to browsing channel which is useful to
debug:

> ACL Data RX: Handle 256 flags 0x02 dlen 68
      Channel: 69 len 64 ctrl 0x0100 [PSM 27 mode 3] {chan 5}
      I-frame: Unsegmented TxSeq 0 ReqSeq 1
      AVCTP Browsing: Response: type 0x00 label 0 PID 0x110e
        AVRCP: GetFolderItems: len 0x0036
          Status: 0x04 (Success)
          UIDCounter: 0x0000 (0)
          NumOfItems: 0x0001 (1)
          Item: 0x01 (Media Player)
          Length: 0x002e (46)
          PlayerID: 0x0001 (1)
          PlayerType: 0x0001 (Audio)
          PlayerSubType: 0x00000000 (None)
          PlayStatus: 0x01 (PLAYING)
          Features: 0x00000000003700050000000000000000
            Advanced Control Player: yes
            Browsing: no
            Searching: no
            AddToNowPlaying: no
            Unique UIDs: no
            OnlyBrowsableWhenAddressed: no
            OnlySearchableWhenAddressed: no
            NowPlaying: no
            UIDPersistency: no
---
 monitor/avctp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index d06640e..ccbfa66 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -1813,6 +1813,29 @@ response:
 	return true;
 }
 
+
+static void print_features(uint8_t features[16], uint8_t indent)
+{
+	print_field("%*cAdvanced Control Player: %s", indent, ' ',
+				features[7] & (1 << 2) ? "yes" : "no");
+	print_field("%*cBrowsing: %s", indent, ' ',
+				features[7] & (1 << 3) ? "yes" : "no");
+	print_field("%*cSearching: %s", indent, ' ',
+				features[7] & (1 << 4) ? "yes" : "no");
+	print_field("%*cAddToNowPlaying: %s", indent, ' ',
+				features[7] & (1 << 5) ? "yes" : "no");
+	print_field("%*cUnique UIDs: %s", indent, ' ',
+				features[7] & (1 << 6) ? "yes" : "no");
+	print_field("%*cOnlyBrowsableWhenAddressed: %s", indent, ' ',
+				features[7] & (1 << 7) ? "yes" : "no");
+	print_field("%*cOnlySearchableWhenAddressed: %s", indent, ' ',
+				features[8] & (1 << 0) ? "yes" : "no");
+	print_field("%*cNowPlaying: %s", indent, ' ',
+				features[8] & (1 << 1) ? "yes" : "no");
+	print_field("%*cUIDPersistency: %s", indent, ' ',
+				features[8] & (1 << 2) ? "yes" : "no");
+}
+
 static bool avrcp_media_player_item(struct avctp_frame *avctp_frame,
 							uint8_t indent)
 {
@@ -1856,6 +1879,8 @@ static bool avrcp_media_player_item(struct avctp_frame *avctp_frame,
 
 	printf("\n");
 
+	print_features(features, indent + 2);
+
 	if (!l2cap_frame_get_be16(frame, &charset))
 		return false;
 
-- 
2.4.3

