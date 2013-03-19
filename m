Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 10/11] service: Add callbacks to track state changes
Date: Tue, 19 Mar 2013 08:40:54 +0100
Message-Id: <1363678855-12765-11-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1363678855-12765-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1363678855-12765-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Extend the btd_service API to support state observers.
---
 src/service.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/service.h |  8 ++++++++
 2 files changed, 56 insertions(+)

diff --git a/src/service.c b/src/service.c
index ee56a0a..2f0974c 100644
--- a/src/service.c
+++ b/src/service.c
@@ -55,6 +55,12 @@ struct btd_service {
 	int			err;
 };
 
+struct service_state_callback {
+	service_state_cb	cb;
+	void			*user_data;
+	guint			id;
+};
+
 static char *str_state[] = {
 	"SERVICE_STATE_UNAVAILABLE",
 	"SERVICE_STATE_DISCONNECTED",
@@ -63,6 +69,8 @@ static char *str_state[] = {
 	"SERVICE_STATE_DISCONNECTING",
 };
 
+static GSList *state_callbacks;
+
 struct btd_device *service_get_device(struct btd_service *service)
 {
 	return service->device;
@@ -98,6 +106,7 @@ static void service_set_state(struct btd_service *service,
 							service_state_t state)
 {
 	service_state_t old = service->state;
+	GSList *l;
 
 	if (state == old)
 		return;
@@ -106,6 +115,45 @@ static void service_set_state(struct btd_service *service,
 
 	DBG("State changed %p: %s -> %s", service, str_state[old],
 							str_state[state]);
+
+	for (l = state_callbacks; l != NULL; l = g_slist_next(l)) {
+		struct service_state_callback *cb = l->data;
+
+		cb->cb(service, old, state, cb->user_data);
+	}
+}
+
+guint service_add_state_cb(service_state_cb cb, void *user_data)
+{
+	struct service_state_callback *state_cb;
+	static guint id = 0;
+
+	state_cb = g_new(struct service_state_callback, 1);
+	state_cb->cb = cb;
+	state_cb->user_data = user_data;
+	state_cb->id = ++id;
+
+	state_callbacks = g_slist_append(state_callbacks, state_cb);
+
+	return state_cb->id;
+}
+
+gboolean service_remove_state_cb(guint id)
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
 }
 
 struct btd_service *service_create(struct btd_device *device,
diff --git a/src/service.h b/src/service.h
index 72282bd..5e6c2b8 100644
--- a/src/service.h
+++ b/src/service.h
@@ -31,6 +31,11 @@ typedef enum {
 
 struct btd_service;
 
+typedef void (*service_state_cb) (struct btd_service *service,
+						service_state_t old_state,
+						service_state_t new_state,
+						void *user_data);
+
 struct btd_service *service_create(struct btd_device *device,
 						struct btd_profile *profile);
 
@@ -41,6 +46,9 @@ struct btd_device *service_get_device(struct btd_service *service);
 struct btd_profile *service_get_profile(struct btd_service *service);
 service_state_t service_get_state(struct btd_service *service);
 
+guint service_add_state_cb(service_state_cb cb, void *user_data);
+gboolean service_remove_state_cb(guint id);
+
 void service_set_user_data(struct btd_service *service, void *user_data);
 void *service_get_user_data(struct btd_service *service);
 int service_get_error(struct btd_service *service);
-- 
1.8.1.4

