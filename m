Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 11/38] android/gatt: Assume that each server wants waits for connection
Date: Wed, 30 Apr 2014 11:13:42 +0200
Message-Id: <1398849249-5868-12-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 9e950ec..f035e3f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -575,6 +575,13 @@ static int register_app(const uint8_t *uuid, gatt_app_type_t app_type)
 		return 0;
 	}
 
+	if ((app->type == APP_SERVER) &&
+			!queue_push_tail(listen_apps, INT_TO_PTR(app->id))) {
+		error("gatt: Cannot push server on the list");
+		destroy_gatt_app(app);
+		return 0;
+	}
+
 	return app->id;
 }
 
-- 
1.8.4

