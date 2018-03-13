Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v2 3/4] monitor: Add support for Secondary PHY flags in Add Advertising
Date: Tue, 13 Mar 2018 11:24:04 +0530
Message-Id: <1520920445-30353-3-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1520920445-30353-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1520920445-30353-1-git-send-email-jaganathx.kanakkassery@intel.com>
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

