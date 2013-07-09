Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 15/21] audio/transport: Remove dependency on struct audio_device
Date: Tue,  9 Jul 2013 17:39:12 +0300
Message-Id: <1373380758-16489-19-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
References: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is part of the work necessary to completely remove
struct audio_device
---
 profiles/audio/transport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 8d3d91e..087c0ee 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -38,7 +38,6 @@
 
 #include "log.h"
 #include "error.h"
-#include "device.h"
 #include "avdtp.h"
 #include "media.h"
 #include "transport.h"
-- 
1.8.1.4

