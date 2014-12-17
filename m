Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v4 04/10] core: profile: Add accept function
Date: Tue, 16 Dec 2014 18:07:12 -0800
Message-Id: <1418782038-10999-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1418782038-10999-1-git-send-email-armansito@chromium.org>
References: <1418782038-10999-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the "accept" function to btd_profile. The purpose
of this function is to notify a profile when a btd_service is ready to
interact with and will be called by btd_device when a bt_gatt_client
becomes ready (MTU exchange and discovery has been completed). This is
initially meant to be optional for non-GATT based profiles but could be
generalized for them in the future.
---
 src/profile.h |  2 ++
 src/service.c | 18 ++++++++++++++++++
 src/service.h |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/src/profile.h b/src/profile.h
index 9aec27e..f5a3ded 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -42,6 +42,8 @@ struct btd_profile {
 	int (*connect) (struct btd_service *service);
 	int (*disconnect) (struct btd_service *service);
 
+	int (*accept) (struct btd_service *service);
+
 	int (*adapter_probe) (struct btd_profile *p,
 						struct btd_adapter *adapter);
 	void (*adapter_remove) (struct btd_profile *p,
diff --git a/src/service.c b/src/service.c
index afe592b..2ea2b7a 100644
--- a/src/service.c
+++ b/src/service.c
@@ -199,6 +199,24 @@ void service_remove(struct btd_service *service)
 	btd_service_unref(service);
 }
 
+int service_accept(struct btd_service *service)
+{
+	char addr[18];
+	int err;
+
+	if (!service->profile->accept)
+		return 0;
+
+	err = service->profile->accept(service);
+	if (!err)
+		return 0;
+
+	ba2str(device_get_address(service->device), addr);
+	error("%s profile accept failed for %s", service->profile->name, addr);
+
+	return err;
+}
+
 int btd_service_connect(struct btd_service *service)
 {
 	struct btd_profile *profile = service->profile;
diff --git a/src/service.h b/src/service.h
index 857e688..3a0db6e 100644
--- a/src/service.h
+++ b/src/service.h
@@ -52,6 +52,8 @@ struct btd_service *service_create_gatt(struct btd_device *device,
 int service_probe(struct btd_service *service);
 void service_remove(struct btd_service *service);
 
+int service_accept(struct btd_service *service);
+
 /* Connection control API */
 int btd_service_connect(struct btd_service *service);
 int btd_service_disconnect(struct btd_service *service);
-- 
2.2.0.rc0.207.ga3a616c

