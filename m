Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 10/11] service: Add callbacks to track state changes
Date: Tue, 26 Mar 2013 17:13:53 +0100
Message-Id: <1364314434-9796-11-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1364314434-9796-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1364314434-9796-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Extend the btd_service API to support state observers.
---
 src/service.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/service.h |  8 ++++++++
 2 files changed, 56 insertions(+)

diff --git a/src/service.c b/src/service.c
index 090dd06..e3239ee 100644
--- a/src/service.c
+++ b/src/service.c
@@ -55,6 +55,14 @@ struct btd_service {
 	int			err;
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
 	switch(state) {
@@ -108,6 +116,7 @@ static void service_set_state(struct btd_service *service,
 						btd_service_state_t state)
 {
 	btd_service_state_t old = service->state;
+	GSList *l;
 
 	if (state == old)
 		return;
@@ -116,6 +125,45 @@ static void service_set_state(struct btd_service *service,
 
 	DBG("State changed %p: %s -> %s", service, state2str(old),
 							state2str(state));
+
+	for (l = state_callbacks; l != NULL; l = g_slist_next(l)) {
+		struct service_state_callback *cb = l->data;
+
+		cb->cb(service, old, state, cb->user_data);
+	}
+}
+
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
 }
 
 struct btd_service *service_create(struct btd_device *device,
diff --git a/src/service.h b/src/service.h
index 596898b..63537d7 100644
--- a/src/service.h
+++ b/src/service.h
@@ -31,6 +31,11 @@ typedef enum {
 
 struct btd_service;
 
+typedef void (*btd_service_state_cb) (struct btd_service *service,
+						btd_service_state_t old_state,
+						btd_service_state_t new_state,
+						void *user_data);
+
 struct btd_service *service_create(struct btd_device *device,
 						struct btd_profile *profile);
 
@@ -41,6 +46,9 @@ struct btd_device *btd_service_get_device(const struct btd_service *service);
 struct btd_profile *btd_service_get_profile(const struct btd_service *service);
 btd_service_state_t btd_service_get_state(const struct btd_service *service);
 
+guint btd_service_add_state_cb(btd_service_state_cb cb, void *user_data);
+gboolean btd_service_remove_state_cb(guint id);
+
 void btd_service_set_user_data(struct btd_service *service, void *user_data);
 void *btd_service_get_user_data(const struct btd_service *service);
 int btd_service_get_error(const struct btd_service *service);
-- 
1.8.1.4

