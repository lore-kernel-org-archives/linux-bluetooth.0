Return-Path: <cyrus@holtmann.org>
From: y@google.com
To: linux-bluetooth@vger.kernel.org
Cc: Jaikumar Ganesh <jaikumar@google.com>
Subject: [PATCH] Fix Headset Audio gateway SDP record.
Date: Tue, 21 Sep 2010 16:50:00 -0700
Message-Id: <1285113000-14247-1-git-send-email-y>
In-Reply-To: <n>
References: <n>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jaikumar Ganesh <jaikumar@google.com>

Headset Audio Gateway does not have the Supported Features
in the SDP records according to the HSP specification.
---
 tools/sdptool.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index d06b159..140a46a 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -1477,8 +1477,7 @@ static int add_headset_ag(sdp_session_t *session, svc_info_t *si)
 	sdp_list_t *aproto, *proto[2];
 	sdp_record_t record;
 	uint8_t u8 = si->channel ? si->channel : 7;
-	uint16_t u16 = 0x17;
-	sdp_data_t *channel, *features;
+	sdp_data_t *channel;
 	uint8_t netid = si->network ? si->network : 0x01; // ???? profile document
 	sdp_data_t *network = sdp_data_alloc(SDP_UINT8, &netid);
 	int ret = 0;
@@ -1511,9 +1510,6 @@ static int add_headset_ag(sdp_session_t *session, svc_info_t *si)
 	proto[1] = sdp_list_append(proto[1], channel);
 	apseq = sdp_list_append(apseq, proto[1]);
 
-	features = sdp_data_alloc(SDP_UINT16, &u16);
-	sdp_attr_add(&record, SDP_ATTR_SUPPORTED_FEATURES, features);
-
 	aproto = sdp_list_append(0, apseq);
 	sdp_set_access_protos(&record, aproto);
 
-- 
1.6.5.7

