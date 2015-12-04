Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] core/service: fix connection and disconnection state handling
Date: Fri,  4 Dec 2015 11:36:43 +0000
Message-Id: <1449229003-7193-3-git-send-email-eu@felipetonello.com>
In-Reply-To: <1449229003-7193-1-git-send-email-eu@felipetonello.com>
References: <1449229003-7193-1-git-send-email-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Service state was not been update correctly if a profile didn't implement
state changes itself. This patch makes sure that states will be always
properly update, even if a profile doesn't implement itself.

As a side effect, this fix a bug causing a profile's accept function not to be
called on a connection after a disconnection.
---
 src/service.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/src/service.c b/src/service.c
index f7912f5..85694a5 100644
--- a/src/service.c
+++ b/src/service.c
@@ -219,9 +219,6 @@ int btd_service_connect(struct btd_service *service)
 	char addr[18];
 	int err;
 
-	if (!profile->connect)
-		return -ENOTSUP;
-
 	switch (service->state) {
 	case BTD_SERVICE_STATE_UNAVAILABLE:
 		return -EINVAL;
@@ -235,15 +232,21 @@ int btd_service_connect(struct btd_service *service)
 		return -EBUSY;
 	}
 
+	change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
+
+	if (!profile->connect) {
+		btd_service_connecting_complete(service, 0);
+		return -ENOTSUP;
+	}
+
 	err = profile->connect(service);
-	if (err == 0) {
-		change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
-		return 0;
+	if (err < 0) {
+		ba2str(device_get_address(service->device), addr);
+		error("%s profile connect failed for %s: %s", profile->name, addr,
+		      strerror(-err));
 	}
 
-	ba2str(device_get_address(service->device), addr);
-	error("%s profile connect failed for %s: %s", profile->name, addr,
-								strerror(-err));
+	btd_service_connecting_complete(service, err);
 
 	return err;
 }
@@ -254,9 +257,6 @@ int btd_service_disconnect(struct btd_service *service)
 	char addr[18];
 	int err;
 
-	if (!profile->disconnect)
-		return -ENOTSUP;
-
 	switch (service->state) {
 	case BTD_SERVICE_STATE_UNAVAILABLE:
 		return -EINVAL;
@@ -270,18 +270,19 @@ int btd_service_disconnect(struct btd_service *service)
 
 	change_state(service, BTD_SERVICE_STATE_DISCONNECTING, 0);
 
-	err = profile->disconnect(service);
-	if (err == 0)
-		return 0;
-
-	if (err == -ENOTCONN) {
+	if (!profile->disconnect) {
 		btd_service_disconnecting_complete(service, 0);
-		return 0;
+		return -ENOTSUP;
 	}
 
-	ba2str(device_get_address(service->device), addr);
-	error("%s profile disconnect failed for %s: %s", profile->name, addr,
-								strerror(-err));
+	err = profile->disconnect(service);
+	if (err == -ENOTCONN) {
+		err = 0;
+	} else if (err < 0) {
+		ba2str(device_get_address(service->device), addr);
+		error("%s profile disconnect failed for %s: %s", profile->name, addr,
+		      strerror(-err));
+	}
 
 	btd_service_disconnecting_complete(service, err);
 
-- 
2.5.0

