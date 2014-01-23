Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/audio: Fix for loading audio lib
Date: Thu, 23 Jan 2014 17:16:31 +0100
Message-ID: <1390493791-23043-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Issue visible when haltest loads audio.a2dp.default.so

> HAL E: load:
> module=/home/rymanluk/devel/kitkat/external/bluetooth/bluez/android/.libs/audio.a2dp.default.so
/home/rymanluk/devel/kitkat/external/bluetooth/bluez/android/.libs/audio.a2dp.default.so:
undefined symbol: clock_gettime
hw_get_module_by_class returned -22

---
 android/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index e9d9db1..f85de20 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -152,7 +152,7 @@ android_audio_a2dp_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
 android_audio_a2dp_default_la_LIBADD = @SBC_LIBS@
 
 android_audio_a2dp_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
-					-no-undefined -pthread
+					-no-undefined -pthread -lrt
 
 endif
 
-- 
1.8.4

