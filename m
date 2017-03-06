Return-Path: <tedd.an@intel.com>
Date: Mon, 6 Mar 2017 15:38:37 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>, "jaya.p.g"
 <jaya.p.g@linux.intel.com>
Subject: [PATCH] tools/bluemoon: Add hw_variant for Intel Bluetooth
 9160/9260
Message-ID: <20170306153837.0ab78750@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds hw_variant for Intel Bluetooth 9160/9260 also
known as ThunderPeak(ThP).

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 tools/bluemoon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bluemoon.c b/tools/bluemoon.c
index 5fc6269..6051f30 100644
--- a/tools/bluemoon.c
+++ b/tools/bluemoon.c
@@ -621,6 +621,7 @@ static const struct {
 	{ 0x0a, "iBT 2.1 (AG620)"	},
 	{ 0x0b, "iBT 3.0 (LnP)"		},
 	{ 0x0c, "iBT 3.0 (WsP)"		},
+	{ 0x12, "iBT 3.5 (ThP)"		},
 	{ }
 };
 
-- 
2.7.4
