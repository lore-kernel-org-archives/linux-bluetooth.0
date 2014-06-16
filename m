Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 6/6] profile/health: Free sdp list after adding it to record
Date: Mon, 16 Jun 2014 18:01:40 +0300
Message-Id: <1402930900-24209-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402930900-24209-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402930900-24209-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/health/hdp_util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 58770b5..47c464e 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -652,6 +652,8 @@ static gboolean register_service_sup_features(GSList *app_list,
 		return FALSE;
 	}
 
+	sdp_list_free(sup_features, free_hdp_list);
+
 	return TRUE;
 }
 
-- 
1.9.1

