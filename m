Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Recognize Eddystone Configuration Service UUIDs
Date: Wed, 20 Apr 2016 11:16:13 +0200
Message-Id: <1461143773-17833-2-git-send-email-beaufort.francois@gmail.com>
In-Reply-To: <1461143773-17833-1-git-send-email-beaufort.francois@gmail.com>
References: <1461143773-17833-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/uuid.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/monitor/uuid.c b/monitor/uuid.c
index 54adb0d..6c60a67 100644
--- a/monitor/uuid.c
+++ b/monitor/uuid.c
@@ -540,6 +540,26 @@ static struct {
 	{ }
 };
 
+static struct {
+	const char *uuid;
+	const char *str;
+} uuid128_table[] = {
+	{ "a3c87500-8ed3-4bdf-8a39-a01bebede295", "Eddystone Configuration Service"	},
+	{ "a3c87501-8ed3-4bdf-8a39-a01bebede295", "Capabilities"			},
+	{ "a3c87502-8ed3-4bdf-8a39-a01bebede295", "Active Slot"				},
+	{ "a3c87503-8ed3-4bdf-8a39-a01bebede295", "Advertising Interval"		},
+	{ "a3c87504-8ed3-4bdf-8a39-a01bebede295", "Radio Tx Power"			},
+	{ "a3c87505-8ed3-4bdf-8a39-a01bebede295", "(Advanced) Advertised Tx Power"	},
+	{ "a3c87506-8ed3-4bdf-8a39-a01bebede295", "Lock State"				},
+	{ "a3c87507-8ed3-4bdf-8a39-a01bebede295", "Unlock"				},
+	{ "a3c87508-8ed3-4bdf-8a39-a01bebede295", "Public ECDH Key"			},
+	{ "a3c87509-8ed3-4bdf-8a39-a01bebede295", "EID Identity Key"			},
+	{ "a3c8750a-8ed3-4bdf-8a39-a01bebede295", "ADV Slot Data"			},
+	{ "a3c8750b-8ed3-4bdf-8a39-a01bebede295", "(Advanced) Factory reset"		},
+	{ "a3c8750c-8ed3-4bdf-8a39-a01bebede295", "(Advanced) Remain Connectable"	},
+	{ NULL, NULL }
+};
+
 const char *uuid16_to_str(uint16_t uuid)
 {
 	int i;
@@ -567,6 +587,7 @@ const char *uuid128_to_str(const unsigned char *uuid)
 
 const char *uuidstr_to_str(const char *uuid)
 {
+	int i;
 	uint32_t val;
 
 	if (!uuid)
@@ -575,6 +596,11 @@ const char *uuidstr_to_str(const char *uuid)
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

