Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 26/27] service: Add callbacks to track state changes
Date: Fri, 26 Apr 2013 08:17:22 +0200
Message-Id: <1366957043-2383-27-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Extend the btd_service API to support state observers.
---
 src/service.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/service.h |  8 ++++++++
 2 files changed, 56 insertions(+)

diff --git a/src/service.c b/src/service.c
index e03a412..d74fc98 100644
--- a/src/service.c
+++ b/src/service.c
@@ -54,6 +54,14 @@ struct btd_service {
 	btd_service_state_t	state;
 };
 
+struct service_state_callback {
+	btd_service_state_cb	cb;
+	void			*user_data;
+	guint			id;
+};
+
+static GSList *state_callbacks;
+
 static const char *state2str(btd_service_state_t state)
 {
 	switch (state) {
@@ -77,6 +85,7 @@ static void change_state(struct btd_service *service, btd_service_state_t state,
 {
 	btd_service_state_t old = service->state;
 	char addr[18];
+	GSList *l;
 
 	if (state == old)
 		return;
@@ -90,6 +99,12 @@ static void change_state(struct btd_service *service, btd_service_state_t state,
 	DBG("%p: device %s profile %s state changed: %s -> %s (%d)", service,
 					addr, service->profile->name,
 					state2str(old), state2str(state), err);
+
+	for (l = state_callbacks; l != NULL; l = g_slist_next(l)) {
+		struct service_state_callback *cb = l->data;
+
+		cb->cb(service, old, state, err, cb->user_data);
+	}
 }
 
 struct btd_service *btd_service_ref(struct btd_service *service)
@@ -256,6 +271,39 @@ btd_service_state_t btd_service_get_state(const struct btd_service *service)
 	return service->state;
 }
 
+guint btd_service_add_state_cb(btd_service_state_cb cb, void *user_data)
+{
+	struct service_state_callback *state_cb;
+	static guint id = 0;
+
+	state_cb = g_new0(struct service_state_callback, 1);
+	state_cb->cb = cb;
+	state_cb->user_data = user_data;
+	state_cb->id = ++id;
+
+	state_callbacks = g_slist_append(state_callbacks, state_cb);
+
+	return state_cb->id;
+}
+
+gboolean btd_service_remove_state_cb(guint id)
+{
+	GSList *l;
+
+	for (l = state_callbacks; l != NULL; l = g_slist_next(l)) {
+		struct service_state_callback *cb = l->data;
+
+		if (cb && cb->id == id) {
+			state_callbacks = g_slist_remove_link(state_callbacks,
+									l);
+			g_free(cb);
+			return TRUE;
+		}
+	}
+
+	return FALSE;
+}
+
 void btd_service_connecting_complete(struct btd_service *service, int err)
 {
 	if (service->state != BTD_SERVICE_STATE_DISCONNECTED &&
diff --git a/src/service.h b/src/service.h
index a89b524..718a465 100644
--- a/src/service.h
+++ b/src/service.h
@@ -33,6 +33,11 @@ struct btd_service;
 struct btd_device;
 struct btd_profile;
 
+typedef void (*btd_service_state_cb) (struct btd_service *service,
+						btd_service_state_t old_state,
+						btd_service_state_t new_state,
+						int err, void *user_data);
+
 struct btd_service *btd_service_ref(struct btd_service *service);
 void btd_service_unref(struct btd_service *service);
 
@@ -52,6 +57,9 @@ struct btd_device *btd_service_get_device(const struct btd_service *service);
 struct btd_profile *btd_service_get_profile(const struct btd_service *service);
 btd_service_state_t btd_service_get_state(const struct btd_service *service);
 
+guint btd_service_add_state_cb(btd_service_state_cb cb, void *user_data);
+gboolean btd_service_remove_state_cb(guint id);
+
 /* Functions used by profile implementation */
 void btd_service_connecting_complete(struct btd_service *service, int err);
 void btd_service_disconnecting_complete(struct btd_service *service, int err);
-- 
1.8.1.4

