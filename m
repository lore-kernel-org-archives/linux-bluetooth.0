Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/17] SAP: Move SAP_DISCONNECTION_TYPE_CLIENT from sap.h to server.c
Date: Wed, 6 Jun 2012 15:19:13 +0200
Message-ID: <1338988767-19467-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SAP_DISCONNECTION_TYPE_CLIENT is an implementation detail and is not
specified by SAP profile specification.
---
 sap/sap.h    |    3 +--
 sap/server.c |    1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sap/sap.h b/sap/sap.h
index 1dbb235..30301bd 100644
--- a/sap/sap.h
+++ b/sap/sap.h
@@ -40,8 +40,7 @@ enum sap_status {
 /* Disconnection Type - SAP v1.1 section 5.2.3 */
 enum sap_disconnection_type {
 	SAP_DISCONNECTION_TYPE_GRACEFUL		= 0x00,
-	SAP_DISCONNECTION_TYPE_IMMEDIATE	= 0x01,
-	SAP_DISCONNECTION_TYPE_CLIENT		= 0xFF
+	SAP_DISCONNECTION_TYPE_IMMEDIATE	= 0x01
 };
 
 /* Result codes - SAP v1.1 section 5.2.4 */
diff --git a/sap/server.c b/sap/server.c
index e5effac..b37a8e2 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -50,6 +50,7 @@
 #define PARAMETER_SIZE(x) (sizeof(struct sap_parameter) + x + PADDING4(x))
 
 #define SAP_NO_REQ 0xFF
+#define SAP_DISCONNECTION_TYPE_CLIENT 0xFF
 
 #define SAP_TIMER_GRACEFUL_DISCONNECT 30
 #define SAP_TIMER_NO_ACTIVITY 30
-- 
on behalf of ST-Ericsson

