Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/7] android/gatt: Unify destroy functions
Date: Wed, 26 Mar 2014 18:00:53 +0100
Message-Id: <1395853259-15618-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch unifies destroy function names. We should also keep destroy
functions convention as it is in /src/shared/hci.c for example, and
check passed pointer before dereferencing it.
---
 android/gatt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 04e9729..aeb0585 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -96,10 +96,13 @@ static struct queue *conn_wait_queue = NULL;	/* Devs waiting to connect */
 
 static void bt_le_discovery_stop_cb(void);
 
-static void free_gatt_service(void *data)
+static void destroy_service(void *data)
 {
 	struct service *srvc = data;
 
+	if (!srvc)
+		return;
+
 	queue_destroy(srvc->chars, free);
 	free(srvc);
 }
@@ -175,8 +178,11 @@ static void destroy_device(void *data)
 {
 	struct gatt_device *dev = data;
 
+	if (!dev)
+		return;
+
 	queue_destroy(dev->clients, NULL);
-	queue_destroy(dev->services, free_gatt_service);
+	queue_destroy(dev->services, destroy_service);
 	free(dev);
 }
 
-- 
1.9.0

