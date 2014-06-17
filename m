Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/health: Make coding style consistent for array parameter
Date: Tue, 17 Jun 2014 15:47:14 +0200
Message-Id: <1403012834-28933-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/health.c b/android/health.c
index 58323d9..60c4c99 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1093,8 +1093,7 @@ static int connect_mcl(struct health_channel *channel)
 						search_cb, channel, NULL, 0);
 }
 
-static struct health_device *create_device(uint16_t app_id,
-						const uint8_t addr[])
+static struct health_device *create_device(uint16_t app_id, const uint8_t *addr)
 {
 	struct health_device *dev;
 
-- 
1.9.3

