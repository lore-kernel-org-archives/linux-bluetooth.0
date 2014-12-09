Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 03/25] android/gatt: Fix for setting conn timeout
Date: Tue,  9 Dec 2014 16:11:25 +0100
Message-Id: <1418137907-16981-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 720a205..9c2260c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1344,6 +1344,9 @@ static void discover_primary_cb(uint8_t status, GSList *services,
 
 	free(cb_data);
 
+	if (conn->timeout_id > 0)
+		g_source_remove(conn->timeout_id);
+
 	conn->timeout_id = g_timeout_add_seconds(GATT_CONN_TIMEOUT,
 						connection_timeout, conn);
 }
-- 
1.8.4

