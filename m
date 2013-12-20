Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/bluetooth: Remove not needed local variable
Date: Fri, 20 Dec 2013 13:50:42 +0100
Message-Id: <1387543842-6489-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1387543842-6489-1-git-send-email-szymon.janc@tieto.com>
References: <1387543842-6489-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Both manufacturer and sub_version already have correct type and struct
is marked as packed so there is no need to memcpy to temp variable.
---
 android/hal-bluetooth.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 3dbc435..9f9814a 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -150,17 +150,14 @@ static void device_props_to_hal(bt_property_t *send_props,
 		{
 			static bt_remote_version_t e;
 			const struct hal_prop_device_info *p;
-			uint16_t tmp;
 
 			send_props[i].val = &e;
 			send_props[i].len = sizeof(e);
 
 			p = (struct hal_prop_device_info *) prop->val;
 
-			memcpy(&tmp, &p->manufacturer, sizeof(tmp));
-			e.manufacturer = tmp;
-			memcpy(&tmp, &p->sub_version, sizeof(tmp));
-			e.sub_ver = tmp;
+			e.manufacturer = p->manufacturer;
+			e.sub_ver = p->sub_version;
 			e.version = p->version;
 		}
 			break;
-- 
1.8.3.2

