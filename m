Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v4 8/8] monitor: Add support for missing error codes
Date: Thu, 22 Jun 2017 10:55:22 +0200
Message-Id: <20170622085522.2936-9-michal.narajowski@codecoup.pl>
In-Reply-To: <20170622085522.2936-1-michal.narajowski@codecoup.pl>
References: <20170622085522.2936-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These codes were added in Bluetooth 5
---
 monitor/packet.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index c7b0c4e..8db8fee 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -502,6 +502,10 @@ static const struct {
 	{ 0x3f, "MAC Connection Failed"					},
 	{ 0x40, "Coarse Clock Adjustment Rejected "
 		"but Will Try to Adjust Using Clock Dragging"		},
+	{ 0x41, "Type0 Submap Not Defined"				},
+	{ 0x42, "Unknown Advertising Identifier"			},
+	{ 0x43, "Limit Reached"						},
+	{ 0x44, "Operation Cancelled by Host"				},
 	{ }
 };
 
-- 
2.9.3

