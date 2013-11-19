Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/a2dp: Use sdp_data_free for freeing sdp data types
Date: Tue, 19 Nov 2013 11:27:44 +0200
Message-Id: <1384853264-10924-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384853264-10924-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384853264-10924-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/a2dp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 7f16be8..74d0082 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -312,8 +312,8 @@ static sdp_record_t *a2dp_record(void)
 
 	sdp_set_info_attr(record, "Audio Source", NULL, NULL);
 
-	free(psm);
-	free(version);
+	sdp_data_free(psm);
+	sdp_data_free(version);
 	sdp_list_free(proto[0], NULL);
 	sdp_list_free(proto[1], NULL);
 	sdp_list_free(apseq, NULL);
-- 
1.7.10.4

