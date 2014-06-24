Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] HDP: Fix checking always constant error code
Date: Tue, 24 Jun 2014 15:07:41 +0300
Message-Id: <1403611666-26060-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403611666-26060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403611666-26060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

sdp_set_access_protos() always returns 0, there is no sense to check for
error code. Fixes compile warnings.
---
 profiles/health/hdp_util.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 47c464e..75ae439 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -425,11 +425,8 @@ static gboolean register_service_protocols(struct hdp_adapter *adapter,
 		goto end;
 	}
 
-	if (sdp_set_access_protos(sdp_record, access_proto_list) < 0) {
-		ret = FALSE;
-		goto end;
-	}
 	ret = TRUE;
+	sdp_set_access_protos(sdp_record, access_proto_list);
 
 end:
 	if (l2cap_list != NULL)
-- 
1.8.3.2

