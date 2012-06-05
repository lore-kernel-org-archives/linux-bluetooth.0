Return-Path: <cyrus@holtmann.org>
From: <joohi.rastogi@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>
Cc: User Name2 <joohi.rastogi@stericsson.com>
Subject: [PATCH v2] Sets the information attribute for the service
Date: Tue, 5 Jun 2012 12:16:53 +0530
Message-ID: <1338878813-2477-1-git-send-email-joohi.rastogi@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Joohi Rastogi <joohi.rastogi@stericsson.com>

This patch adds the service name for
Device Identification Profile
---
 src/sdpd-service.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index 39e05ab..39eff69 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -228,6 +228,8 @@ void register_device_id(void)
 	source_data = sdp_data_alloc(SDP_UINT16, &main_opts.did_source);
 	sdp_attr_add(record, 0x0205, source_data);
 
+	sdp_set_info_attr(record, "Device Identification", NULL, NULL);
+
 	update_db_timestamp();
 }
 
-- 
1.7.5.4

