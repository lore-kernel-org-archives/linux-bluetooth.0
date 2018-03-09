Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 3/4 v1] monitor: Add support for Secondary PHY flags in Add Advertising
Date: Fri,  9 Mar 2018 12:55:53 +0530
Message-Id: <1520580354-2185-3-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1520580354-2185-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1520580354-2185-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/packet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index e3b5ab7..2a22e7d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10741,6 +10741,9 @@ static const struct {
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

