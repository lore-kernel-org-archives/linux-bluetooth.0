Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 14/21] audio/media: Remove dependency on struct audio_device
Date: Tue,  9 Jul 2013 17:39:11 +0300
Message-Id: <1373380758-16489-18-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
References: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is part of the work necessary to completely remove
struct audio_device
---
 profiles/audio/media.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index bb6323d..f1ad439 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -34,15 +34,14 @@
 #include <gdbus/gdbus.h>
 
 #include "lib/uuid.h"
-#include "../src/adapter.h"
-#include "../src/device.h"
-#include "../src/dbus-common.h"
-#include "../src/profile.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/dbus-common.h"
+#include "src/profile.h"
 
 #include "glib-helper.h"
 #include "log.h"
 #include "error.h"
-#include "device.h"
 #include "avdtp.h"
 #include "media.h"
 #include "transport.h"
-- 
1.8.1.4

