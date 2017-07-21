Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/5] monitor: Add decoding of GATT Mesh Services
Date: Fri, 21 Jul 2017 13:59:16 +0300
Message-Id: <20170721105919.7777-2-luiz.dentz@gmail.com>
In-Reply-To: <20170721105919.7777-1-luiz.dentz@gmail.com>
References: <20170721105919.7777-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds UUIDs of GATT Mesh Provisioning Service and Mesh Proxy
Service.
---
 monitor/uuid.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/monitor/uuid.c b/monitor/uuid.c
index fb0b210..9839d03 100644
--- a/monitor/uuid.c
+++ b/monitor/uuid.c
@@ -170,7 +170,9 @@ static const struct {
 	{ 0x1824, "Transport Discovery"				},
 	{ 0x1825, "Object Transfer"				},
 	{ 0x1826, "Fitness Machine"				},
-	/* 0x1827 to 0x27ff undefined */
+	{ 0x1827, "Mesh Provisioning"				},
+	{ 0x1828, "Mesh Proxy"					},
+	/* 0x1829 to 0x27ff undefined */
 	{ 0x2800, "Primary Service"				},
 	{ 0x2801, "Secondary Service"				},
 	{ 0x2802, "Include"					},
@@ -397,6 +399,10 @@ static const struct {
 	{ 0x2ad8, "Supported Power Range"			},
 	{ 0x2ad9, "Fitness Machine Control Point"		},
 	{ 0x2ada, "Fitness Machine Status"			},
+	{ 0x2adb, "Mesh Provisioning Data In"			},
+	{ 0x2adc, "Mesh Provisioning Data Out"			},
+	{ 0x2add, "Mesh Proxy Data In"				},
+	{ 0x2ade, "Mesh Proxy Data Out"				},
 	/* vendor defined */
 	{ 0xfeff, "GN Netcom"					},
 	{ 0xfefe, "GN ReSound A/S"				},
-- 
2.9.4

