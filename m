Return-Path: <cyrus@holtmann.org>
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Stefan Seyfried <seife@sphairon.com>
Subject: [PATCH 2/2] Add hack to allow compilation with old bluez lib
Date: Wed, 17 Feb 2010 13:49:42 +0100
Message-Id: <1266410982-26964-3-git-send-email-stefan.seyfried@googlemail.com>
In-Reply-To: <1266410982-26964-2-git-send-email-stefan.seyfried@googlemail.com>
References: <1266410982-26964-1-git-send-email-stefan.seyfried@googlemail.com>
 <1266410982-26964-2-git-send-email-stefan.seyfried@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Stefan Seyfried <seife@sphairon.com>

---
 parser/hci.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index e4fc473..33c3640 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -41,6 +41,12 @@
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
 
+/* ugly hack, as hci.h changed incompatibly with bluez 4.61 */
+#ifndef OCF_READ_INQ_RESPONSE_TX_POWER_LEVEL
+#define OCF_READ_INQ_RESPONSE_TX_POWER_LEVEL OCF_READ_INQUIRY_TRANSMIT_POWER_LEVEL
+#define read_inq_response_tx_power_level_rp read_inquiry_transmit_power_level_rp
+#endif
+
 #include "parser.h"
 
 static uint16_t manufacturer = DEFAULT_COMPID;
-- 
1.6.6.1
