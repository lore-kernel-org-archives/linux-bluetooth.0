Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Recognize FIDO U2F service characteristics
Date: Mon, 30 May 2016 17:45:46 +0200
Message-Id: <1464623146-6127-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These FIDO U2F service characteristics are defined at
https://fidoalliance.org/specs/u2f-specs-1.0-bt-nfc-id-amendment/fido-u2f-bt-protocol.html

---
 monitor/uuid.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/monitor/uuid.c b/monitor/uuid.c
index 1ceaa6f..6008626 100644
--- a/monitor/uuid.c
+++ b/monitor/uuid.c
@@ -562,6 +562,10 @@ static const struct {
 		"(Advanced) Factory reset"				},
 	{ "a3c8750c-8ed3-4bdf-8a39-a01bebede295",
 		"(Advanced) Remain Connectable"				},
+	{ "f1d0fff1-deaa-ecee-b42f-c9ba7ed623bb", "U2F Control Point"	},
+	{ "f1d0fff2-deaa-ecee-b42f-c9ba7ed623bb", "U2F Status"		},
+	{ "f1d0fff3-deaa-ecee-b42f-c9ba7ed623bb",
+		"U2F Control Point Length"				},
 	{ }
 };
 
-- 
2.7.0

