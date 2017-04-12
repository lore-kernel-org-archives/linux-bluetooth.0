Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 1/5] monitor: Add description for filter in scan parameters
Date: Wed, 12 Apr 2017 14:13:32 +0200
Message-Id: <20170412121336.783-1-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
        Type: Active (0x01)
        Interval: 30.000 msec (0x0030)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Accept all advertisement, inc. directed unresolved RPA (0x02)
---
 monitor/packet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 5d927f5..219542e 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -6309,6 +6309,12 @@ static void le_set_scan_parameters_cmd(const void *data, uint8_t size)
 	case 0x01:
 		str = "Ignore not in white list";
 		break;
+	case 0x02:
+		str = "Accept all advertisement, inc. directed unresolved RPA";
+		break;
+	case 0x03:
+		str = "Ignore not in white list, exc. directed unresolved RPA";
+		break;
 	default:
 		str = "Reserved";
 		break;
-- 
2.9.3

