Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH ] android/socket: Add MAP supported features bits
Date: Tue, 09 Dec 2014 18:21:28 +0530
Message-id: <1418129488-12353-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1418129488-12353-1-git-send-email-gowtham.ab@samsung.com>
References: <1418129488-12353-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add MAP supported features in sdp record.
---
 android/socket.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index f2cfd07..d89c8c2 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -58,6 +58,7 @@
 /* Hardcoded MAP stuff needed for MAS SMS Instance.*/
 #define DEFAULT_MAS_INSTANCE	0x00
 
+#define DEFAULT_MAP_SUPPORTED_FEATURES 0x0000001f
 #define DEFAULT_PBAP_SUPPORTED_FEATURES 0x00000003
 
 #define MAP_MSG_TYPE_SMS_GSM	0x02
@@ -321,6 +322,7 @@ static sdp_record_t *create_mas_record(uint8_t chan, const char *svc_name)
 	sdp_profile_desc_t profile[1];
 	uint8_t minst = DEFAULT_MAS_INSTANCE;
 	uint8_t mtype = DEFAULT_MAS_MSG_TYPE;
+	uint8_t supft = DEFAULT_MAP_SUPPORTED_FEATURES;
 	sdp_record_t *record;
 	uuid_t uuid;
 
@@ -339,6 +341,9 @@ static sdp_record_t *create_mas_record(uint8_t chan, const char *svc_name)
 	sdp_attr_add_new(record, SDP_ATTR_SUPPORTED_MESSAGE_TYPES, SDP_UINT8,
 									&mtype);
 
+	sdp_attr_add_new(record, SDP_ATTR_MAP_SUPPORTED_FEATURES, SDP_UINT32,
+									&supft);
+
 	sdp_list_free(seq, NULL);
 
 	return record;
-- 
1.9.1

