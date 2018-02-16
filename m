Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 2/7] client: Not output ad service info if no uuid sets
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
Message-ID: <e2d7e444-0f79-44fe-9ad9-fb93d06d5270@jp.fujitsu.com>
Date: Fri, 16 Feb 2018 14:51:08 +0900
MIME-Version: 1.0
In-Reply-To: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/advertising.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 80a48652c..e500a2e86 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -541,8 +541,11 @@ void ad_advertise_service(DBusConnection *conn, int argc, char *argv[])
 	struct ad_data *data;
 
 	if (argc < 2 || !strlen(argv[1])) {
-		print_uuid(ad.service.uuid);
-		bt_shell_hexdump(ad.service.data.data, ad.service.data.len);
+		if (ad.service.uuid) {
+			print_uuid(ad.service.uuid);
+			bt_shell_hexdump(ad.service.data.data,
+						ad.service.data.len);
+		}
 		return;
 	}
 
-- 
2.14.1

