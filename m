Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 1/7] client: Fix null output for ad service uuid
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
Message-ID: <47445278-d6cf-d79c-f645-8d4d88a213b7@jp.fujitsu.com>
Date: Fri, 16 Feb 2018 14:51:03 +0900
MIME-Version: 1.0
In-Reply-To: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If getting the advertise service information without setting, outputs
null as UUID as below:

  [bluetooth]# service
  UUID: ((null))
---
 client/advertising.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/advertising.c b/client/advertising.c
index b9b9a7371..80a48652c 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -131,7 +131,7 @@ static void print_uuid(const char *uuid)
 
 		bt_shell_printf("UUID: %s(%s)\n", str, uuid);
 	} else
-		bt_shell_printf("UUID: (%s)\n", uuid);
+		bt_shell_printf("UUID: (%s)\n", uuid ? uuid : "");
 }
 
 static void print_ad_uuids(void)
-- 
2.14.1

