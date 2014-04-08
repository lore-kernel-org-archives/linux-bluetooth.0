Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 02/15] android/gatt: Add flag primary to struct service
Date: Tue, 8 Apr 2014 11:22:19 +0200
Message-ID: <1396948952-2035-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since we are going to use this struct also for included services lets
add here flag saying if this is primary service or not.
---
 android/gatt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index d7228a3..8b0833c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -85,6 +85,7 @@ struct characteristic {
 struct service {
 	struct element_id id;
 	struct gatt_primary prim;
+	bool primary;
 
 	struct queue *chars;
 };
@@ -526,6 +527,8 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 
 		/* Put primary service to our local list */
 		memcpy(&p->prim, prim, sizeof(p->prim));
+		p->primary = true;
+
 		if (!queue_push_tail(dev->services, p)) {
 			error("gatt: Cannot push primary service to the list");
 			free(p);
-- 
1.8.4

