Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 6/9] profiles/input: Add DS4 devices to the shared header
Date: Mon,  4 Sep 2017 20:12:09 +0200
Message-Id: <20170904181212.5639-6-hadess@hadess.net>
In-Reply-To: <20170904181212.5639-1-hadess@hadess.net>
References: <20170904181212.5639-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

And simplify the detection code in server.c some more.
---
 profiles/input/server.c  |  7 ++-----
 profiles/input/sixaxis.h | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index 121c334d3..ef428fefe 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -134,11 +134,8 @@ static bool dev_is_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
 	pid = btd_device_get_product(device);
 
 	type = get_pairing_type(vid, pid, NULL, NULL, NULL);
-	if (type == CABLE_PAIRING_SIXAXIS)
-		return true;
-
-	/* DualShock 4 */
-	if (vid == 0x054c && pid == 0x05c4)
+	if (type == CABLE_PAIRING_SIXAXIS ||
+	    type == CABLE_PAIRING_DS4)
 		return true;
 
 	return false;
diff --git a/profiles/input/sixaxis.h b/profiles/input/sixaxis.h
index 589eff3da..9c074face 100644
--- a/profiles/input/sixaxis.h
+++ b/profiles/input/sixaxis.h
@@ -29,6 +29,7 @@
 typedef enum {
 	CABLE_PAIRING_UNSUPPORTED = 0,
 	CABLE_PAIRING_SIXAXIS,
+	CABLE_PAIRING_DS4,
 } CablePairingType;
 
 inline CablePairingType
@@ -62,6 +63,22 @@ get_pairing_type(uint16_t   vid,
 			.version = 0x0000,
 			.type = CABLE_PAIRING_SIXAXIS,
 		},
+		{
+			.name = "Wireless Controller",
+			.source = 0x0002,
+			.vid = 0x054c,
+			.pid = 0x05c4,
+			.version = 0x0001,
+			.type = CABLE_PAIRING_DS4,
+		},
+		{
+			.name = "Wireless Controller",
+			.source = 0x0002,
+			.vid = 0x054c,
+			.pid = 0x09cc,
+			.version = 0x0001,
+			.type = CABLE_PAIRING_DS4,
+		},
 	};
 	guint i;
 
-- 
2.14.1

