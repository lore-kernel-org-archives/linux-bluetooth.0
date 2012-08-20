Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 06/10] core: Rename update_services
Date: Mon, 20 Aug 2012 14:22:51 -0300
Message-Id: <1345483375-27621-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames update_services functions to avoid clashing with GATT
based services.
---
 src/device.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 5fee11e..57e7897 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1434,7 +1434,7 @@ static int rec_cmp(const void *a, const void *b)
 	return r1->handle - r2->handle;
 }
 
-static void update_services(struct browse_req *req, sdp_list_t *recs)
+static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 {
 	struct btd_device *device = req->device;
 	struct btd_adapter *adapter = device_get_adapter(device);
@@ -1618,7 +1618,7 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 		goto send_reply;
 	}
 
-	update_services(req, recs);
+	update_bredr_services(req, recs);
 
 	if (device->tmp_records)
 		sdp_list_free(device->tmp_records,
@@ -1706,7 +1706,7 @@ static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
 			goto done;
 	}
 
-	update_services(req, recs);
+	update_bredr_services(req, recs);
 
 	adapter_get_address(adapter, &src);
 
-- 
1.7.8.6

