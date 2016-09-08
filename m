Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] core/service: Fix setting wrong state after calling accept
Date: Thu,  8 Sep 2016 15:38:56 +0300
Message-Id: <1473338340-7587-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The accept calback may transit the state to connected on the call itself
since most of the time it is just a matter of selecting the attributes
in case of GATT profiles.
---
 src/service.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index f387fc4..20a41d0 100644
--- a/src/service.c
+++ b/src/service.c
@@ -209,7 +209,8 @@ int service_accept(struct btd_service *service)
 	return err;
 
 done:
-	change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
+	if (service->state == BTD_SERVICE_STATE_DISCONNECTED)
+		change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
 	return 0;
 }
 
-- 
2.7.4

