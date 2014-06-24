Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] HDP: Fix checking always constant error code
Date: Tue, 24 Jun 2014 15:07:42 +0300
Message-Id: <1403611666-26060-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403611666-26060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403611666-26060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Function sdp_set_add_access_protos() always returns 0, so there is no
sense to check for error code.
---
 profiles/health/hdp_util.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 75ae439..5676eee 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -473,7 +473,7 @@ static gboolean register_service_additional_protocols(
 						struct hdp_adapter *adapter,
 						sdp_record_t *sdp_record)
 {
-	gboolean ret;
+	gboolean ret = TRUE;
 	uuid_t l2cap_uuid, mcap_d_uuid;
 	sdp_list_t *l2cap_list, *proto_list = NULL, *mcap_list = NULL;
 	sdp_list_t *access_proto_list = NULL;
@@ -524,10 +524,7 @@ static gboolean register_service_additional_protocols(
 		goto end;
 	}
 
-	if (sdp_set_add_access_protos(sdp_record, access_proto_list) < 0)
-		ret = FALSE;
-	else
-		ret = TRUE;
+	sdp_set_add_access_protos(sdp_record, access_proto_list);
 
 end:
 	if (l2cap_list != NULL)
-- 
1.8.3.2

