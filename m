Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 05/16] android/gatt: Add tracking for autoconnect apps
Date: Tue,  2 Sep 2014 12:09:50 +0200
Message-Id: <1409652601-28689-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409652601-28689-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lets start to track which applications are interested in autoconnect
---
 android/gatt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index aea0a9f..f526c16 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -164,6 +164,8 @@ struct gatt_device {
 	int ref;
 	int conn_cnt;
 
+	struct queue *autoconnect_apps;
+
 	struct queue *pending_requests;
 };
 
@@ -682,6 +684,7 @@ static void destroy_device(void *data)
 
 	queue_destroy(dev->services, destroy_service);
 	queue_destroy(dev->pending_requests, destroy_pending_request);
+	queue_destroy(dev->autoconnect_apps, NULL);
 
 	free(dev);
 }
@@ -724,6 +727,12 @@ static struct gatt_device *create_device(const bdaddr_t *addr)
 		return NULL;
 	}
 
+	dev->autoconnect_apps = queue_new();
+	if (!dev->autoconnect_apps) {
+		error("gatt: Failed to allocate memory for client");
+		destroy_device(dev);
+		return NULL;
+	}
 
 	dev->pending_requests = queue_new();
 	if (!dev->pending_requests) {
-- 
1.8.4

