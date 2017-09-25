Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 3/5] client: Prevent to pass invalid ad type to D-Bus
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <f2c9e252-ce40-25e7-c814-84247157ce6d@jp.fujitsu.com>
Message-ID: <fd572e1e-acdf-2aa0-8fae-bb61b0f6edf0@jp.fujitsu.com>
Date: Mon, 25 Sep 2017 13:33:25 +0900
MIME-Version: 1.0
In-Reply-To: <f2c9e252-ce40-25e7-c814-84247157ce6d@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/advertising.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/advertising.c b/client/advertising.c
index bfdebd5..76cee3d 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -131,7 +131,7 @@ static gboolean get_type(const GDBusPropertyTable *property,
 {
 	const char *type = "peripheral";
 
-	if (!ad.type || strlen(ad.type) > 0)
+	if (ad.type && strlen(ad.type) > 0)
 		type = ad.type;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &type);
-- 
2.7.4


