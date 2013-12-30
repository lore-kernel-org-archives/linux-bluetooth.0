Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 2/6] android/audio: Fix Makefile.am for libaudio
Date: Mon, 30 Dec 2013 11:17:23 +0100
Message-ID: <1388398647-25420-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1388398647-25420-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1388398647-25420-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use CFLAGS instread of CPPFLAGS

---
 android/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index a5533de..dec81ce 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -109,7 +109,7 @@ android_libaudio_internal_la_SOURCES = android/hal-audio.c \
 					android/hardware/hardware.h \
 					android/system/audio.h
 
-android_libaudio_internal_la_CPPFLAGS = -I$(srcdir)/android
+android_libaudio_internal_la_CFLAGS = -I$(srcdir)/android
 
 endif
 
-- 
1.8.4

