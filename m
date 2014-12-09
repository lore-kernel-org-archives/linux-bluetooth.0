Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH ] android/socket: Add PBAP supported features bits
Date: Tue, 09 Dec 2014 18:21:27 +0530
Message-id: <1418129488-12353-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add PBAP supported features in sdp record.
---
 android/socket.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 2b836e9..f2cfd07 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -58,6 +58,8 @@
 /* Hardcoded MAP stuff needed for MAS SMS Instance.*/
 #define DEFAULT_MAS_INSTANCE	0x00
 
+#define DEFAULT_PBAP_SUPPORTED_FEATURES 0x00000003
+
 #define MAP_MSG_TYPE_SMS_GSM	0x02
 #define MAP_MSG_TYPE_SMS_CDMA	0x04
 #define DEFAULT_MAS_MSG_TYPE	(MAP_MSG_TYPE_SMS_GSM | MAP_MSG_TYPE_SMS_CDMA)
@@ -287,6 +289,7 @@ static sdp_record_t *create_pbap_record(uint8_t chan, const char *svc_name)
 	sdp_list_t *seq;
 	sdp_profile_desc_t profile[1];
 	uint8_t formats = 0x01;
+	uint8_t supft = DEFAULT_PBAP_SUPPORTED_FEATURES;
 	sdp_record_t *record;
 	uuid_t uuid;
 
@@ -304,6 +307,9 @@ static sdp_record_t *create_pbap_record(uint8_t chan, const char *svc_name)
 	sdp_attr_add_new(record, SDP_ATTR_SUPPORTED_REPOSITORIES, SDP_UINT8,
 								&formats);
 
+	sdp_attr_add_new(record, SDP_ATTR_PBAP_SUPPORTED_FEATURES, SDP_UINT32,
+								&supft);
+
 	sdp_list_free(seq, NULL);
 
 	return record;
-- 
1.9.1

