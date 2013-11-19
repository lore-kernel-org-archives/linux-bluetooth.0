Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/a2sp: trivial: Use NULL for zero pointer
Date: Tue, 19 Nov 2013 11:27:43 +0200
Message-Id: <1384853264-10924-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/a2dp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index b0cb9b5..7f16be8 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -310,7 +310,7 @@ static sdp_record_t *a2dp_record(void)
 	features = sdp_data_alloc(SDP_UINT16, &feat);
 	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
 
-	sdp_set_info_attr(record, "Audio Source", 0, 0);
+	sdp_set_info_attr(record, "Audio Source", NULL, NULL);
 
 	free(psm);
 	free(version);
-- 
1.7.10.4

