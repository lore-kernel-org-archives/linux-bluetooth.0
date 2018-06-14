Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ v3 05/11] monitor: Add support for Secondary PHY flags in Add Advertising
Date: Thu, 14 Jun 2018 17:51:18 +0530
Message-Id: <1528978884-3882-6-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1528978884-3882-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1528978884-3882-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/packet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index cf8bb8e..e3449a4 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10796,6 +10796,9 @@ static const struct {
 	{  4, "Add TX Power field to Advertising Data"	},
 	{  5, "Add Appearance field to Scan Response"	},
 	{  6, "Add Local Name in Scan Response"		},
+	{  7, "Advertise in 1M on Secondary channel"	},
+	{  8, "Advertise in 2M on Secondary channel"	},
+	{  9, "Advertise in CODED on Secondary channel"	},
 	{ }
 };
 
-- 
2.7.4

