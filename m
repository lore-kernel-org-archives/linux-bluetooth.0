Return-Path: <cyrus@holtmann.org>
From: jprvita@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH BlueZ 1/3] audio: Remove unused constant
Date: Fri, 12 Apr 2013 19:34:22 -0300
Message-Id: <1365806064-12052-1-git-send-email-jprvita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: João Paulo Rechi Vita <jprvita@gmail.com>

Removes the never used constant AUDIO_INTERFACE which is defined to
"org.bluez.Audio".
---
 profiles/audio/device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index 907221d..b9d1dde 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -56,8 +56,6 @@
 #include "sink.h"
 #include "source.h"
 
-#define AUDIO_INTERFACE "org.bluez.Audio"
-
 #define CONTROL_CONNECT_TIMEOUT 2
 #define AVDTP_CONNECT_TIMEOUT 1
 #define AVDTP_CONNECT_TIMEOUT_BOOST 1
-- 
1.7.11.7

