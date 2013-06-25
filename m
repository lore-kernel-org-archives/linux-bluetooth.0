Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Fix not adding UUID found during pairing
Date: Tue, 25 Jun 2013 19:36:00 +0300
Message-Id: <1372178160-22870-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is a regression introduce by de63199f0c89fce76180edd40359fde4b13c54c1
where the list of UUID found is always empty thus causing no driver to be
probed.
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index c324764..edd377c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2694,7 +2694,7 @@ static int update_record(struct browse_req *req, const char *uuid,
 	if (l == NULL) {
 		l = g_slist_find_custom(req->profiles_added, uuid,
 							bt_uuid_strcmp);
-		if (l == NULL)
+		if (l != NULL)
 			return 0;
 		req->profiles_added = g_slist_append(req->profiles_added,
 							g_strdup(uuid));
-- 
1.8.1.4

