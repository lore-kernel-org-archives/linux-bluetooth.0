Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Do not change service state in btd_service_connect if it fails
Date: Thu, 14 Nov 2013 14:27:51 +0200
Message-Id: <1384432071-2703-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If .connect fails and the service state changes it may re-enter
connect_next, inverting the order and messing up the error of each
connect request.
---
 src/service.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/service.c b/src/service.c
index 52a8291..7a480d6 100644
--- a/src/service.c
+++ b/src/service.c
@@ -198,18 +198,16 @@ int btd_service_connect(struct btd_service *service)
 		return -EBUSY;
 	}
 
-	change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
-
 	err = profile->connect(service);
-	if (err == 0)
+	if (err == 0) {
+		change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
 		return 0;
+	}
 
 	ba2str(device_get_address(service->device), addr);
 	error("%s profile connect failed for %s: %s", profile->name, addr,
 								strerror(-err));
 
-	btd_service_connecting_complete(service, err);
-
 	return err;
 }
 
-- 
1.8.3.1

