Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ v6 10/11] monitor: Rename Directed Advertising Timeout
Date: Tue,  8 Aug 2017 10:45:32 +0200
Message-Id: <20170808084533.2323-11-michal.narajowski@codecoup.pl>
In-Reply-To: <20170808084533.2323-1-michal.narajowski@codecoup.pl>
References: <20170808084533.2323-1-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In Bluetooth 5.0 spec this error code is named "Advertising Timeout"
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index f5130735f..0154e4f9f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -496,7 +496,7 @@ static const struct {
 	{ 0x39, "Connection Rejected due to No Suitable Channel Found"	},
 	{ 0x3a, "Controller Busy"					},
 	{ 0x3b, "Unacceptable Connection Parameters"			},
-	{ 0x3c, "Directed Advertising Timeout"				},
+	{ 0x3c, "Advertising Timeout"					},
 	{ 0x3d, "Connection Terminated due to MIC Failure"		},
 	{ 0x3e, "Connection Failed to be Established"			},
 	{ 0x3f, "MAC Connection Failed"					},
-- 
2.11.0

