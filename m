Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v5 1/3] service: Add error-code btd_service
Date: Fri, 26 Apr 2013 11:46:23 +0200
Message-Id: <1366969585-28654-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366969585-28654-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366969585-28654-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The error-code represents the result of a connection/disconnection
procedure and can be useful when a state transition is detected.
---
 src/service.c | 7 +++++++
 src/service.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/src/service.c b/src/service.c
index e03a412..6228de1 100644
--- a/src/service.c
+++ b/src/service.c
@@ -52,6 +52,7 @@ struct btd_service {
 	struct btd_profile	*profile;
 	void			*user_data;
 	btd_service_state_t	state;
+	int			err;
 };
 
 static const char *state2str(btd_service_state_t state)
@@ -85,6 +86,7 @@ static void change_state(struct btd_service *service, btd_service_state_t state,
 	assert(service->profile != NULL);
 
 	service->state = state;
+	service->err = err;
 
 	ba2str(device_get_address(service->device), addr);
 	DBG("%p: device %s profile %s state changed: %s -> %s (%d)", service,
@@ -256,6 +258,11 @@ btd_service_state_t btd_service_get_state(const struct btd_service *service)
 	return service->state;
 }
 
+int btd_service_get_error(const struct btd_service *service)
+{
+	return service->err;
+}
+
 void btd_service_connecting_complete(struct btd_service *service, int err)
 {
 	if (service->state != BTD_SERVICE_STATE_DISCONNECTED &&
diff --git a/src/service.h b/src/service.h
index a89b524..e3bc6e5 100644
--- a/src/service.h
+++ b/src/service.h
@@ -51,6 +51,7 @@ int btd_service_disconnect(struct btd_service *service);
 struct btd_device *btd_service_get_device(const struct btd_service *service);
 struct btd_profile *btd_service_get_profile(const struct btd_service *service);
 btd_service_state_t btd_service_get_state(const struct btd_service *service);
+int btd_service_get_error(const struct btd_service *service);
 
 /* Functions used by profile implementation */
 void btd_service_connecting_complete(struct btd_service *service, int err);
-- 
1.8.1.4

