Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] android: Fix crash in property_get stub
Date: Thu, 17 Oct 2013 22:28:39 +0200
Message-Id: <1382041721-19960-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1382041721-19960-1-git-send-email-szymon.janc@gmail.com>
References: <1382041721-19960-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

If value was not found and default_value was not provided NULL pointer
was passed as argument to strncpy resulting in crash.
---
 android/cutils/properties.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/cutils/properties.h b/android/cutils/properties.h
index a9f7554..44a712c 100644
--- a/android/cutils/properties.h
+++ b/android/cutils/properties.h
@@ -43,7 +43,7 @@ static inline int property_get(const char *key, char *value,
 	if (!env)
 		env = default_value;
 
-	if (!value)
+	if (!value || !env)
 		return 0;
 
 	strncpy(value, env, PROPERTY_VALUE_MAX);
-- 
1.8.4.rc3

