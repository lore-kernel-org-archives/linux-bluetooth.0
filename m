Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] android/gatt: Fix updating mtu for no registered app
Date: Wed, 29 Apr 2015 11:15:53 +0200
Message-Id: <1430298953-31018-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1430298953-31018-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1430298953-31018-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Gatt shouldn't notify about updating mtu if no apps are registered.
Without this patch, while connecting crash can occur.
---
 android/gatt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 04f89af..157b89d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -978,6 +978,11 @@ static void notify_mtu_change(void *data, void *user_data)
 	if (conn->device != device)
 		return;
 
+	if (!conn->app) {
+		error("gatt: can't notify mtu - no app registered for conn");
+		return;
+	}
+
 	switch (conn->app->type) {
 	case GATT_CLIENT:
 		notify_client_mtu_change(conn, true);
-- 
2.1.0

