Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 21/27] core: Add user_data to btd_service
Date: Fri, 26 Apr 2013 08:17:17 +0200
Message-Id: <1366957043-2383-22-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Profile implementations can benefit from a user_data associated to a
service, which will typically be set during probe.
---
 src/service.c | 12 ++++++++++++
 src/service.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/src/service.c b/src/service.c
index a10138d..e03a412 100644
--- a/src/service.c
+++ b/src/service.c
@@ -50,6 +50,7 @@ struct btd_service {
 	gint			ref;
 	struct btd_device	*device;
 	struct btd_profile	*profile;
+	void			*user_data;
 	btd_service_state_t	state;
 };
 
@@ -239,6 +240,17 @@ struct btd_profile *btd_service_get_profile(const struct btd_service *service)
 	return service->profile;
 }
 
+void btd_service_set_user_data(struct btd_service *service, void *user_data)
+{
+	assert(service->state == BTD_SERVICE_STATE_UNAVAILABLE);
+	service->user_data = user_data;
+}
+
+void *btd_service_get_user_data(const struct btd_service *service)
+{
+	return service->user_data;
+}
+
 btd_service_state_t btd_service_get_state(const struct btd_service *service)
 {
 	return service->state;
diff --git a/src/service.h b/src/service.h
index 8fb1ed5..a89b524 100644
--- a/src/service.h
+++ b/src/service.h
@@ -55,3 +55,5 @@ btd_service_state_t btd_service_get_state(const struct btd_service *service);
 /* Functions used by profile implementation */
 void btd_service_connecting_complete(struct btd_service *service, int err);
 void btd_service_disconnecting_complete(struct btd_service *service, int err);
+void btd_service_set_user_data(struct btd_service *service, void *user_data);
+void *btd_service_get_user_data(const struct btd_service *service);
-- 
1.8.1.4

