Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 8/8] Remove workaround in gatt_connect
Date: Wed,  6 Jun 2012 21:41:03 -0300
Message-Id: <1339029663-25654-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
References: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This workaround is not necessary anymore since setsockopt is now
checking for minimum MTU.
---
 attrib/utils.c |   13 -------------
 1 file changed, 13 deletions(-)

diff --git a/attrib/utils.c b/attrib/utils.c
index f809b1f..d856fe2 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -36,10 +36,6 @@
 #include "btio.h"
 #include "gatttool.h"
 
-/* Minimum MTU for ATT connections */
-#define ATT_MIN_MTU_LE		23
-#define ATT_MIN_MTU_L2CAP	48
-
 GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 				const gchar *dst_type, const gchar *sec_level,
 				int psm, int mtu, BtIOConnect connect_cb)
@@ -49,15 +45,6 @@ GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 	uint8_t dest_type;
 	GError *err = NULL;
 	BtIOSecLevel sec;
-	int minimum_mtu;
-
-	/* This check is required because currently setsockopt() returns no
-	 * errors for MTU values smaller than the allowed minimum. */
-	minimum_mtu = psm ? ATT_MIN_MTU_L2CAP : ATT_MIN_MTU_LE;
-	if (mtu != 0 && mtu < minimum_mtu) {
-		g_printerr("MTU cannot be smaller than %d\n", minimum_mtu);
-		return NULL;
-	}
 
 	/* Remote device */
 	if (dst == NULL) {
-- 
1.7.10.3

