Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/13] attrib: List all enum values in switch
Date: Tue,  2 Dec 2014 18:28:30 +0100
Message-Id: <1417541318-24259-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
References: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As described in coding style M10
---
 attrib/gatt-service.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 874552b..f592a70 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -118,6 +118,10 @@ static GSList *parse_opts(gatt_option opt1, va_list args)
 		case GATT_OPT_CHR_AUTHORIZATION:
 			info->authorization = va_arg(args, gatt_option);
 			break;
+		case GATT_CHR_VALUE_READ:
+		case GATT_CHR_VALUE_WRITE:
+		case GATT_CHR_VALUE_BOTH:
+		case GATT_OPT_INVALID:
 		default:
 			error("Invalid option: %d", opt);
 		}
-- 
1.9.1

