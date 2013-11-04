Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] android: Implement scan_mode property in get property command
Date: Mon, 4 Nov 2013 16:34:24 +0100
Message-ID: <1383579265-24614-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383579265-24614-1-git-send-email-szymon.janc@tieto.com>
References: <1383579265-24614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to query current state of scan mode property.
---
 android/adapter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 78c301c..54aed40 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -1064,11 +1064,11 @@ static bool get_service(void)
 
 static bool get_scan_mode(void)
 {
-	DBG("Not implemented");
+	DBG("");
 
-	/* TODO: Add implementation */
+	scan_mode_changed();
 
-	return false;
+	return true;
 }
 
 static bool get_devices(void)
-- 
1.8.4.1

