Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 02/10] dis: Reduce array size for PnP ID
Date: Wed, 20 Jun 2012 14:27:44 -0300
Message-Id: <1340213272-2853-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PnP_ID characteristic is a 7 octets value which includes Vendor ID
source, a Vendor ID, Product ID, and Product Version.
---
 deviceinfo/deviceinfo.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
index 41fc3fc..4548553 100644
--- a/deviceinfo/deviceinfo.c
+++ b/deviceinfo/deviceinfo.c
@@ -37,6 +37,8 @@
 #include "log.h"
 #include "deviceinfo.h"
 
+#define PNP_ID_SIZE	7
+
 struct deviceinfo {
 	struct btd_device	*dev;		/* Device reference */
 	GAttrib			*attrib;	/* GATT connection */
@@ -84,7 +86,7 @@ static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
 	struct characteristic *ch = user_data;
-	uint8_t value[ATT_MAX_MTU];
+	uint8_t value[PNP_ID_SIZE];
 	ssize_t vlen;
 
 	if (status != 0) {
-- 
1.7.8.6

