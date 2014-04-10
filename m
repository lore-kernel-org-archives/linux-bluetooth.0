Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 5/5] android/gatt: Fix type of status parameter
Date: Thu, 10 Apr 2014 17:30:05 +0200
Message-Id: <1397143805-17809-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397143805-17809-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397143805-17809-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 235e9e4..cdca424 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -509,7 +509,7 @@ static void connection_cleanup(struct gatt_device *device)
 }
 
 static void send_client_disconnect_notify(int32_t id, struct gatt_device *dev,
-								uint8_t status)
+								int32_t status)
 {
 	struct hal_ev_gatt_client_disconnect ev;
 
-- 
1.8.4

