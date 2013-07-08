Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 17/20] audio/main: Remove dependency on struct audio_device
Date: Mon,  8 Jul 2013 17:10:23 +0300
Message-Id: <1373292626-3776-18-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
References: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is part of the work necessary to completely remove
struct audio_device
---
 profiles/audio/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/audio/main.c b/profiles/audio/main.c
index adc9e45..996d2af 100644
--- a/profiles/audio/main.c
+++ b/profiles/audio/main.c
@@ -41,7 +41,6 @@
 #include "glib-helper.h"
 #include "plugin.h"
 #include "log.h"
-#include "device.h"
 #include "manager.h"
 
 static GKeyFile *load_config_file(const char *file)
-- 
1.8.1.4

