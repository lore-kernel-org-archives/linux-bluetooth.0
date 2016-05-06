Return-Path: <tedd.an@intel.com>
Date: Fri, 6 May 2016 11:53:51 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Tedd Ho-Jeong An
 <tedd.an@intel.com>
Subject: [PATCH BlueZ] tools/bluemoon: Add hardware variant for Intel
 Bluetooth 8265
Message-ID: <20160506115351.239acf97@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds support for HW variant for Intel Bluetooth 8265
also known as Windstorm Peak (WsP).
---
 tools/bluemoon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bluemoon.c b/tools/bluemoon.c
index 650ab0c..5fc6269 100644
--- a/tools/bluemoon.c
+++ b/tools/bluemoon.c
@@ -620,6 +620,7 @@ static const struct {
 	{ 0x09, "iBT 1.5 (AG610)"	},
 	{ 0x0a, "iBT 2.1 (AG620)"	},
 	{ 0x0b, "iBT 3.0 (LnP)"		},
+	{ 0x0c, "iBT 3.0 (WsP)"		},
 	{ }
 };
 
-- 
2.4.3
