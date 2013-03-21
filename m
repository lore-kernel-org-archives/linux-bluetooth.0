Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH 02/13] gatttool: Remove programming error check
Date: Thu, 21 Mar 2013 18:31:38 -0400
Message-Id: <1363905109-30839-3-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

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

