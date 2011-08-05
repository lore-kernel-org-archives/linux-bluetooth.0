Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 02/23] avrcp: use C99 instead of gcc extension
Date: Fri,  5 Aug 2011 15:15:11 -0300
Message-Id: <1312568132-21112-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index c3ef737..1ec736f 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -134,7 +134,7 @@ struct avrcp_spec_avc_pdu {
 	uint8_t packet_type:2;
 	uint8_t rsvd:6;
 	uint16_t params_len;
-	uint8_t params[0];
+	uint8_t params[];
 } __attribute__ ((packed));
 #define AVRCP_SPECAVCPDU_HEADER_LENGTH 7
 
@@ -164,7 +164,7 @@ struct avrcp_spec_avc_pdu {
 	uint8_t rsvd:6;
 	uint8_t packet_type:2;
 	uint16_t params_len;
-	uint8_t params[0];
+	uint8_t params[];
 } __attribute__ ((packed));
 #define AVRCP_SPECAVCPDU_HEADER_LENGTH 7
 
-- 
1.7.6

