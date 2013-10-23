Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <andrei.emeltchenko@intel.com>,
	<szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android: Fix build error for Android
Date: Wed, 23 Oct 2013 10:26:29 +0200
Message-ID: <1382516789-374-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android uses functions and defines from sys/capability.h which
requires additional include
---
 android/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/main.c b/android/main.c
index 988d08b..606baf2 100644
--- a/android/main.c
+++ b/android/main.c
@@ -52,6 +52,10 @@
 #include "hal-msg.h"
 #include "ipc.h"
 
+#if defined(ANDROID)
+#include <sys/capability.h>
+#endif
+
 static GMainLoop *event_loop;
 static struct mgmt *mgmt_if = NULL;
 
-- 
1.8.4

