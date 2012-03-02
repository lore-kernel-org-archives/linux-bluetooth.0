Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] SAP: Make PADDING4 macro a bit more robust
Date: Fri, 2 Mar 2012 15:58:36 +0100
Message-ID: <1330700316-5810-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bitwise operations are done before arithmetic operations and this might
cause undesired results if macro is called with parameter of form x+y.
---
 sap/server.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index b8aa8a5..b5abd70 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -49,7 +49,7 @@
 #define SAP_UUID		"0000112D-0000-1000-8000-00805F9B34FB"
 #define SAP_SERVER_CHANNEL	8
 
-#define PADDING4(x) ((4 - (x & 0x03)) & 0x03)
+#define PADDING4(x) ((4 - ((x) & 0x03)) & 0x03)
 #define PARAMETER_SIZE(x) (sizeof(struct sap_parameter) + x + PADDING4(x))
 
 #define SAP_NO_REQ 0xFF
-- 
on behalf of ST-Ericsson

