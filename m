Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2 09/11] profiles/input: Add support for detecting PS3 Keypads
Date: Wed, 18 Oct 2017 03:58:13 +0200
Message-Id: <20171018015815.10045-9-hadess@hadess.net>
In-Reply-To: <20171018015815.10045-1-hadess@hadess.net>
References: <20171018015815.10045-1-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add device information about the PS3 wireless keypads and consider those
as "sixaxis" devices.
---
 profiles/input/server.c  | 3 ++-
 profiles/input/sixaxis.h | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index ef428fefe..41d7b3ccf 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -135,7 +135,8 @@ static bool dev_is_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
 
 	type = get_pairing_type(vid, pid, NULL, NULL, NULL);
 	if (type == CABLE_PAIRING_SIXAXIS ||
-	    type == CABLE_PAIRING_DS4)
+	    type == CABLE_PAIRING_DS4 ||
+	    type == CABLE_PAIRING_PS3_WIRELESS_KEYPAD)
 		return true;
 
 	return false;
diff --git a/profiles/input/sixaxis.h b/profiles/input/sixaxis.h
index 17a7dc3f7..497a3f2a5 100644
--- a/profiles/input/sixaxis.h
+++ b/profiles/input/sixaxis.h
@@ -30,6 +30,7 @@ typedef enum {
 	CABLE_PAIRING_UNSUPPORTED = 0,
 	CABLE_PAIRING_SIXAXIS,
 	CABLE_PAIRING_DS4,
+	CABLE_PAIRING_PS3_WIRELESS_KEYPAD
 } CablePairingType;
 
 static inline CablePairingType get_pairing_type(uint16_t   vid,
@@ -78,6 +79,14 @@ static inline CablePairingType get_pairing_type(uint16_t   vid,
 			.version = 0x0001,
 			.type = CABLE_PAIRING_DS4,
 		},
+		{
+			.name = "Wireless Keypad",
+			.source = 0x0002,
+			.vid = 0x054c,
+			.pid = 0x03a0,
+			.version = 0x0001,
+			.type = CABLE_PAIRING_PS3_WIRELESS_KEYPAD
+		},
 	};
 	guint i;
 
-- 
2.14.2

