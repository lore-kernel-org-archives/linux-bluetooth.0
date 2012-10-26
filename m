Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0] network: Remove unnecessary field from connect_req
Date: Fri, 26 Oct 2012 07:55:29 +0200
Message-Id: <1351230929-4484-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The device pointer in struct connect_req can be completely removed since
the callback already receives such pointer, and the network_peer takes
care of the device refcounting.
---
 profiles/network/manager.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index ad52885..8d0dc4d 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -48,7 +48,6 @@
 static gboolean conf_security = TRUE;
 
 struct connect_req {
-	struct btd_device	*device;
 	struct btd_profile	*profile;
 	btd_profile_cb		cb;
 };
@@ -84,9 +83,7 @@ static void connect_profile_cb(struct btd_device *device, int err,
 {
 	struct connect_req *req = data;
 
-	req->cb(req->profile, req->device, err);
-
-	btd_device_unref(req->device);
+	req->cb(req->profile, device, err);
 
 	g_free(req);
 }
@@ -100,14 +97,12 @@ static int connect_profile(struct btd_device *dev, struct btd_profile *profile,
 	DBG("path %s id %u", device_get_path(dev), id);
 
 	req  = g_new0(struct connect_req, 1);
-	req->device = btd_device_ref(dev);
 	req->profile = profile;
 	req->cb = cb;
 
 	err = connection_connect(dev, BNEP_SVC_PANU, NULL, connect_profile_cb,
 									req);
 	if (err < 0) {
-		btd_device_unref(req->device);
 		g_free(req);
 		return err;
 	}
-- 
1.7.11.7

