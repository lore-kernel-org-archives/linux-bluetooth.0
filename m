Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Recognize Eddystone Configuration Service UUIDs
Date: Tue, 26 Apr 2016 10:30:28 +0200
Message-Id: <1461659429-19139-2-git-send-email-beaufort.francois@gmail.com>
In-Reply-To: <1461659429-19139-1-git-send-email-beaufort.francois@gmail.com>
References: <1461659429-19139-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/uuid.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/monitor/uuid.c b/monitor/uuid.c
index 54adb0d..1ceaa6f 100644
--- a/monitor/uuid.c
+++ b/monitor/uuid.c
@@ -31,7 +31,7 @@
 
 #include "uuid.h"
 
-static struct {
+static const struct {
 	uint16_t uuid;
 	const char *str;
 } uuid16_table[] = {
@@ -540,6 +540,31 @@ static struct {
 	{ }
 };
 
+static const struct {
+	const char *uuid;
+	const char *str;
+} uuid128_table[] = {
+	{ "a3c87500-8ed3-4bdf-8a39-a01bebede295",
+		"Eddystone Configuration Service"			},
+	{ "a3c87501-8ed3-4bdf-8a39-a01bebede295", "Capabilities"	},
+	{ "a3c87502-8ed3-4bdf-8a39-a01bebede295", "Active Slot"		},
+	{ "a3c87503-8ed3-4bdf-8a39-a01bebede295",
+		"Advertising Interval"					},
+	{ "a3c87504-8ed3-4bdf-8a39-a01bebede295", "Radio Tx Power"	},
+	{ "a3c87505-8ed3-4bdf-8a39-a01bebede295",
+		"(Advanced) Advertised Tx Power"			},
+	{ "a3c87506-8ed3-4bdf-8a39-a01bebede295", "Lock State"		},
+	{ "a3c87507-8ed3-4bdf-8a39-a01bebede295", "Unlock"		},
+	{ "a3c87508-8ed3-4bdf-8a39-a01bebede295", "Public ECDH Key"	},
+	{ "a3c87509-8ed3-4bdf-8a39-a01bebede295", "EID Identity Key"	},
+	{ "a3c8750a-8ed3-4bdf-8a39-a01bebede295", "ADV Slot Data"	},
+	{ "a3c8750b-8ed3-4bdf-8a39-a01bebede295",
+		"(Advanced) Factory reset"				},
+	{ "a3c8750c-8ed3-4bdf-8a39-a01bebede295",
+		"(Advanced) Remain Connectable"				},
+	{ }
+};
+
 const char *uuid16_to_str(uint16_t uuid)
 {
 	int i;
@@ -568,6 +593,7 @@ const char *uuid128_to_str(const unsigned char *uuid)
 const char *uuidstr_to_str(const char *uuid)
 {
 	uint32_t val;
+	int i;
 
 	if (!uuid)
 		return NULL;
@@ -575,6 +601,11 @@ const char *uuidstr_to_str(const char *uuid)
 	if (strlen(uuid) != 36)
 		return NULL;
 
+	for (i = 0; uuid128_table[i].str; i++) {
+		if (strcasecmp(uuid128_table[i].uuid, uuid) == 0)
+			return uuid128_table[i].str;
+	}
+
 	if (strncasecmp(uuid + 8, "-0000-1000-8000-00805f9b34fb", 28))
 		return "Vendor specific";
 
-- 
2.7.0

