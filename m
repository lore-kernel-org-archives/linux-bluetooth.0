Return-Path: <sean.wang@mediatek.com>
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
	<johan.hedberg@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v3 7/7] MAINTAINERS: add an entry for MediaTek Bluetooth driver
Date: Thu, 14 Jun 2018 15:14:29 +0800
Message-ID: <61543c0bc93e875388a2a65ce455eb2c5857bc78.1528960095.git.sean.wang@mediatek.com>
In-Reply-To: <cover.1528960095.git.sean.wang@mediatek.com>
References: <cover.1528960095.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

Add an entry for the MediaTek Bluetooth driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f15bc83..71e25f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8988,6 +8988,14 @@ F:	include/uapi/linux/meye.h
 F:	include/uapi/linux/ivtv*
 F:	include/uapi/linux/uvcvideo.h
 
+MEDIATEK BLUETOOTH DRIVER
+M:	Sean Wang <sean.wang@mediatek.com>
+L:	linux-bluetooth@vger.kernel.org
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
+F:	drivers/bluetooth/btmtkuart.c
+
 MEDIATEK CIR DRIVER
 M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained
-- 
2.7.4
