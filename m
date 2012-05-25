Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/10] SAP: Remove not needed includes
Date: Fri, 25 May 2012 16:20:58 +0200
Message-ID: <1337955662-19016-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
References: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sap/manager.c |   10 ----------
 sap/server.c  |    3 ---
 2 files changed, 13 deletions(-)

diff --git a/sap/manager.c b/sap/manager.c
index a97f434..9fa9c56 100644
--- a/sap/manager.c
+++ b/sap/manager.c
@@ -22,18 +22,8 @@
 #include <config.h>
 #endif
 
-#include <errno.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/hci.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
-
-#include <gdbus.h>
-
 #include "log.h"
 #include "adapter.h"
-#include "device.h"
 
 #include "manager.h"
 #include "server.h"
diff --git a/sap/server.c b/sap/server.c
index 85c4b82..aedbc60 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -28,11 +28,8 @@
 #include <config.h>
 #endif
 
-#include <stdio.h>
 #include <errno.h>
 #include <glib.h>
-#include <netinet/in.h>
-#include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
-- 
on behalf of ST-Ericsson

