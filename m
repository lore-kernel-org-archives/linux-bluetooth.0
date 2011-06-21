Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] Fix SAP message padding macro
Date: Tue, 21 Jun 2011 10:34:05 +0200
Message-ID: <1308645245-21791-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch it is not possible to have
incorrect padding equal to 4.
---
 sap/server.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index 011faa6..c55aa6e 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -49,7 +49,7 @@
 #define SAP_UUID		"0000112D-0000-1000-8000-00805F9B34FB"
 #define SAP_SERVER_CHANNEL	8
 
-#define PADDING4(x) (4 - (x & 0x03))
+#define PADDING4(x) ((4 - (x & 0x03)) & 0x03)
 #define PARAMETER_SIZE(x) (sizeof(struct sap_parameter) + x + PADDING4(x))
 
 #define SAP_NO_REQ 0xFF
-- 
on behalf of ST-Ericsson

