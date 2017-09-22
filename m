Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 3/6] client: Prevent to pass invalid type to D-Bus
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <d5f5eeb2-9207-ae2e-231e-0826307926a9@jp.fujitsu.com>
Message-ID: <1260244d-edf5-a4a6-01ad-03fdf1cd7ad3@jp.fujitsu.com>
Date: Fri, 22 Sep 2017 21:19:53 +0900
MIME-Version: 1.0
In-Reply-To: <d5f5eeb2-9207-ae2e-231e-0826307926a9@jp.fujitsu.com>
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

