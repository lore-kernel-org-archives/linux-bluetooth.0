Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] core/service: Make sure service is disconnected before shutdown
Date: Fri,  5 Jul 2013 17:03:41 +0300
Message-Id: <1373033022-11180-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This ensures that the service is disconnected before setting the state
to unavailable.
---
 src/service.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/service.c b/src/service.c
index 83e1c1a..dce5c05 100644
--- a/src/service.c
+++ b/src/service.c
@@ -170,6 +170,7 @@ int service_probe(struct btd_service *service)
 
 void service_shutdown(struct btd_service *service)
 {
+	btd_service_disconnect(service);
 	change_state(service, BTD_SERVICE_STATE_UNAVAILABLE, 0);
 	service->profile->device_remove(service);
 	service->device = NULL;
-- 
1.8.1.4

