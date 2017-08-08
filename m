Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v6 09/11] monitor: Add support for missing error codes
Date: Tue,  8 Aug 2017 10:45:31 +0200
Message-Id: <20170808084533.2323-10-michal.narajowski@codecoup.pl>
In-Reply-To: <20170808084533.2323-1-michal.narajowski@codecoup.pl>
References: <20170808084533.2323-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These codes were added in Bluetooth 5
---
 monitor/packet.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index aa76b973f..f5130735f 100644
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
2.11.0

