Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] Remove SAP_BUF_SIZE define from sap/server.c
Date: Wed, 8 Jun 2011 12:21:57 +0200
Message-ID: <1307528517-6956-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1307528517-6956-1-git-send-email-szymon.janc@tieto.com>
References: <1307528517-6956-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is already defined in sap/sap.h which is included by sap/server.c.
---
 sap/server.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index d50a241..011faa6 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -48,7 +48,6 @@
 #define SAP_SERVER_INTERFACE	"org.bluez.SimAccess"
 #define SAP_UUID		"0000112D-0000-1000-8000-00805F9B34FB"
 #define SAP_SERVER_CHANNEL	8
-#define SAP_BUF_SIZE		512
 
 #define PADDING4(x) (4 - (x & 0x03))
 #define PARAMETER_SIZE(x) (sizeof(struct sap_parameter) + x + PADDING4(x))
-- 
on behalf of ST-Ericsson

