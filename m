Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH BlueZ 1/1] device: Fix loading devices without Service Changed CCC
Date: Thu, 19 Jul 2018 16:44:09 +0200
Message-Id: <20180719144409.32563-2-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <20180719144409.32563-1-andrzej.kaczmarek@codecoup.pl>
References: <20180719144409.32563-1-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch provides fix for loading devices which were saved before
support for storing Service Changed CCC was added (a0b886e26).

Without this fix, after daemon is upgraded from pre-a0b886e26 to
current version we do not indicate Service Changed to any previously
bonded device since "loaded" CCC value is 0. This means that even if
locla GATT database is changed, bonded peer can assume it did not
change and continue to access structure which yields unexpected
results and this is exactly what happens on iOS devices.

With this patch, if "ServiceChanged" group (added by mentioned commit)
does not exist in config file of a bonded device, we assume indications
for Service Changed characteristic value were enabled by peer as per
Core 5.0, Vol 3, Part G, 7.1:
	"This Characteristic Value shall be configured to be indicated,
	 using the Client Characteristic Configuration descriptor by a
	 client"
---
 src/device.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/device.c b/src/device.c
index 716da53f5..77f94ff54 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5481,6 +5481,22 @@ void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
 	key_file = g_key_file_new();
 	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
+	/*
+	 * If there is no "ServiceChanged" section we may be loading data from
+	 * old version which did not persist Service Changed CCC values. Let's
+	 * check if we are bonded and assume indications were enabled by peer
+	 * in such case - it should have done this anyway.
+	 */
+	if (!g_key_file_has_group(key_file, "ServiceChanged")) {
+		if (ccc_le)
+			*ccc_le = device->le_state.bonded ? 0x0002 : 0x0000;
+		if (ccc_bredr)
+			*ccc_bredr = device->bredr_state.bonded ?
+							0x0002 : 0x0000;
+		g_key_file_free(key_file);
+		return;
+	}
+
 	if (ccc_le)
 		*ccc_le = g_key_file_get_integer(key_file, "ServiceChanged",
 							"CCC_LE", NULL);
-- 
2.18.0

