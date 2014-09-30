Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/12] android: Remove few not needed blank lines
Date: Tue, 30 Sep 2014 13:06:24 +0200
Message-Id: <1412075187-5518-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
References: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/main.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/android/main.c b/android/main.c
index 9ee9960..014b763 100644
--- a/android/main.c
+++ b/android/main.c
@@ -397,38 +397,28 @@ static void configuration(const void *buf, uint16_t len)
 		case HAL_CONFIG_VENDOR:
 			config_vendor = get_prop(config_vendor, prop->len,
 								prop->val);
-
 			DBG("vendor %s", config_vendor);
-
 			break;
 		case HAL_CONFIG_NAME:
 			config_name = get_prop(config_name, prop->len,
 								prop->val);
-
 			DBG("name %s", config_name);
-
 			break;
 		case HAL_CONFIG_MODEL:
 			config_model = get_prop(config_model, prop->len,
 								prop->val);
-
 			DBG("model %s", config_model);
-
 			break;
 		case HAL_CONFIG_SERIAL_NUMBER:
 			config_serial = get_prop(config_serial, prop->len,
 								prop->val);
-
 			DBG("serial %s", config_serial);
-
 			break;
 		case HAL_CONFIG_SYSTEM_ID:
 			parse_system_id(prop->len, prop->val);
-
 			break;
 		case HAL_CONFIG_PNP_ID:
 			parse_pnp_id(prop->len, prop->val);
-
 			break;
 		default:
 			error("Invalid configuration option (%u), terminating",
-- 
1.9.1

