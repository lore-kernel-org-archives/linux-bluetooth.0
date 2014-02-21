Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/avrcp: Use NULL for zero pointers
Date: Fri, 21 Feb 2014 13:27:48 +0200
Message-Id: <1392982068-23162-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index 8ac9e2f..acffd56 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -222,7 +222,7 @@ static sdp_record_t *avrcp_record(void)
 	features = sdp_data_alloc(SDP_UINT16, &feat);
 	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
 
-	sdp_set_info_attr(record, "AVRCP TG", 0, 0);
+	sdp_set_info_attr(record, "AVRCP TG", NULL, NULL);
 
 	sdp_data_free(psm);
 	sdp_data_free(version);
-- 
1.8.3.2

