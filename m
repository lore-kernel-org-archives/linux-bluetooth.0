Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 6/6] android: Remove not needed property_get function form cutils stubs
Date: Sun, 20 Oct 2013 11:53:58 +0200
Message-Id: <1382262838-25725-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382262838-25725-1-git-send-email-szymon.janc@tieto.com>
References: <1382262838-25725-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is no longer used as daemon indicates its presence by connecting
socket.
---
 android/cutils/properties.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/android/cutils/properties.h b/android/cutils/properties.h
index 44a712c..f318b01 100644
--- a/android/cutils/properties.h
+++ b/android/cutils/properties.h
@@ -24,33 +24,6 @@
 extern "C" {
 #endif
 
-#define PROPERTY_KEY_MAX   32
-#define PROPERTY_VALUE_MAX  92
-
-/* property_get: returns the length of the value which will never be
-** greater than PROPERTY_VALUE_MAX - 1 and will always be zero terminated.
-** (the length does not include the terminating zero).
-**
-** If the property read fails or returns an empty value, the default
-** value is used (if nonnull).
-*/
-static inline int property_get(const char *key, char *value,
-						const char *default_value)
-{
-	const char *env;
-
-	env = getenv(key);
-	if (!env)
-		env = default_value;
-
-	if (!value || !env)
-		return 0;
-
-	strncpy(value, env, PROPERTY_VALUE_MAX);
-
-	return strlen(value);
-}
-
 /* property_set: returns 0 on success, < 0 on failure
 */
 static inline int property_set(const char *key, const char *value)
-- 
1.8.4

