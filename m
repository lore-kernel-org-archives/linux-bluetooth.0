Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 7/7] android/build: Fix building HAL library on Linux
Date: Mon, 30 Dec 2013 23:43:41 +0100
Message-Id: <1388443421-6295-7-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1388443421-6295-1-git-send-email-szymon.janc@gmail.com>
References: <1388443421-6295-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PLATFORM_SDK_VERSION was not passed while building HAL library on Linux
host resulting in 4.3+ features not being build.
---
 android/Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index 36210b9..7d9b580 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -59,7 +59,8 @@ android_libhal_internal_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hal-log.h \
 					android/hal-ipc.h android/hal-ipc.c
 
-android_libhal_internal_la_CPPFLAGS = -I$(srcdir)/android
+android_libhal_internal_la_CPPFLAGS = -I$(srcdir)/android \
+					-DPLATFORM_SDK_VERSION=19
 
 noinst_PROGRAMS += android/haltest
 
-- 
1.8.5.2

