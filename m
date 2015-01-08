Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 11/14] core: service: Remove GATT handle logic
Date: Wed,  7 Jan 2015 21:48:25 -0800
Message-Id: <1420696108-29699-12-git-send-email-armansito@chromium.org>
In-Reply-To: <1420696108-29699-1-git-send-email-armansito@chromium.org>
References: <1420696108-29699-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch reverts the recent addition of GATT service handles to
btd_service.
---
 src/service.c | 38 --------------------------------------
 src/service.h |  7 -------
 2 files changed, 45 deletions(-)

diff --git a/src/service.c b/src/service.c
index 2ea2b7a..b66b1c9 100644
--- a/src/service.c
+++ b/src/service.c
@@ -53,8 +53,6 @@ struct btd_service {
 	void			*user_data;
 	btd_service_state_t	state;
 	int			err;
-	uint16_t		start_handle;
-	uint16_t		end_handle;
 };
 
 struct service_state_callback {
@@ -151,26 +149,6 @@ struct btd_service *service_create(struct btd_device *device,
 	return service;
 }
 
-struct btd_service *service_create_gatt(struct btd_device *device,
-						struct btd_profile *profile,
-						uint16_t start_handle,
-						uint16_t end_handle)
-{
-	struct btd_service *service;
-
-	if (!start_handle || !end_handle || start_handle > end_handle)
-		return NULL;
-
-	service = service_create(device, profile);
-	if (!service)
-		return NULL;
-
-	service->start_handle = start_handle;
-	service->end_handle = end_handle;
-
-	return service;
-}
-
 int service_probe(struct btd_service *service)
 {
 	char addr[18];
@@ -322,22 +300,6 @@ int btd_service_get_error(const struct btd_service *service)
 	return service->err;
 }
 
-bool btd_service_get_gatt_handles(const struct btd_service *service,
-							uint16_t *start_handle,
-							uint16_t *end_handle)
-{
-	if (!service || !service->start_handle || !service->end_handle)
-		return false;
-
-	if (start_handle)
-		*start_handle = service->start_handle;
-
-	if (end_handle)
-		*end_handle = service->end_handle;
-
-	return true;
-}
-
 unsigned int btd_service_add_state_cb(btd_service_state_cb cb, void *user_data)
 {
 	struct service_state_callback *state_cb;
diff --git a/src/service.h b/src/service.h
index 3a0db6e..c1f97f6 100644
--- a/src/service.h
+++ b/src/service.h
@@ -44,10 +44,6 @@ void btd_service_unref(struct btd_service *service);
 /* Service management functions used by the core */
 struct btd_service *service_create(struct btd_device *device,
 						struct btd_profile *profile);
-struct btd_service *service_create_gatt(struct btd_device *device,
-						struct btd_profile *profile,
-						uint16_t start_handle,
-						uint16_t end_handle);
 
 int service_probe(struct btd_service *service);
 void service_remove(struct btd_service *service);
@@ -63,9 +59,6 @@ struct btd_device *btd_service_get_device(const struct btd_service *service);
 struct btd_profile *btd_service_get_profile(const struct btd_service *service);
 btd_service_state_t btd_service_get_state(const struct btd_service *service);
 int btd_service_get_error(const struct btd_service *service);
-bool btd_service_get_gatt_handles(const struct btd_service *service,
-							uint16_t *start_handle,
-							uint16_t *end_handle);
 
 unsigned int btd_service_add_state_cb(btd_service_state_cb cb,
 							void *user_data);
-- 
2.2.0.rc0.207.ga3a616c

