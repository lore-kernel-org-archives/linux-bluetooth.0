Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/5] android: Remove not needed include
Date: Tue, 12 Nov 2013 13:06:22 +0100
Message-ID: <1384257985-26319-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384257985-26319-1-git-send-email-szymon.janc@tieto.com>
References: <1384257985-26319-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bt_uuid_t is not used so lib/uuid.h doesn't need to be included.
---
 android/adapter.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/adapter.c b/android/adapter.c
index b053043..bda8e20 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -38,7 +38,6 @@
 #include "src/eir.h"
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
-#include "lib/uuid.h"
 #include "src/sdp-client.h"
 #include "src/sdpd.h"
 #include "log.h"
-- 
1.8.4.2

