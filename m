Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android: Core service should be always registered
Date: Wed, 13 Nov 2013 15:47:13 +0100
Message-ID: <1384354033-21724-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384354033-21724-1-git-send-email-szymon.janc@tieto.com>
References: <1384354033-21724-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Core service is used to register other services and shall be always
consider registered.
---
 android/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/main.c b/android/main.c
index 12284f7..03720e8 100644
--- a/android/main.c
+++ b/android/main.c
@@ -74,7 +74,8 @@ static guint adapter_timeout = 0;
 static GIOChannel *hal_cmd_io = NULL;
 static GIOChannel *hal_notif_io = NULL;
 
-static bool services[HAL_SERVICE_ID_MAX + 1] = { false };
+/* Core Service (ID=0) should be always consider registered */
+static bool services[HAL_SERVICE_ID_MAX + 1] = { true, false };
 
 static void service_register(void *buf, uint16_t len)
 {
-- 
1.8.4.2

