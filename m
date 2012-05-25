Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/10] sap-dummy: Remove not needed includes
Date: Fri, 25 May 2012 16:20:57 +0200
Message-ID: <1337955662-19016-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
References: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sap/sap-dummy.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index 238c5f3..fd185c9 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -26,9 +26,6 @@
 #include <config.h>
 #endif
 
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdint.h>
 #include <glib.h>
 #include <gdbus.h>
 
-- 
on behalf of ST-Ericsson

