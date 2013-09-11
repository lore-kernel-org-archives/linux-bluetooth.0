Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] avdtp: Remove not used includes
Date: Wed, 11 Sep 2013 15:52:13 +0200
Message-ID: <1378907534-6899-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1378907534-6899-1-git-send-email-szymon.janc@tieto.com>
References: <1378907534-6899-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/avdtp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 61f55d6..5422ca3 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -33,8 +33,6 @@
 #include <errno.h>
 #include <unistd.h>
 #include <assert.h>
-#include <signal.h>
-#include <netinet/in.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
@@ -49,7 +47,6 @@
 #include "src/adapter.h"
 #include "src/device.h"
 
-#include "control.h"
 #include "avdtp.h"
 #include "sink.h"
 #include "source.h"
-- 
1.8.4

