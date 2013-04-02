Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ v2 03/13] gatttool: Remove check for bluetooth address parameter on gatt_connect()
Date: Tue,  2 Apr 2013 19:31:20 -0400
Message-Id: <1364945490-17059-4-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
 <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

This check is more appropriate to be done by callers of gatt_connect().
This is already done on interactive mode in attrib/interactive.c and is
now also done in non-interactive mode.
---
 attrib/utils.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/attrib/utils.c b/attrib/utils.c
index f9813d1..c8c8651 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -50,11 +50,6 @@ GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 	GError *err = NULL;
 	BtIOSecLevel sec;
 
-	/* Remote device */
-	if (dst == NULL) {
-		g_printerr("Remote Bluetooth address required\n");
-		return NULL;
-	}
 	str2ba(dst, &dba);
 
 	/* Local adapter */
-- 
1.7.9.5

