Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/11] client: Make command info print ManufacturerData
Date: Wed, 15 Apr 2015 14:44:24 +0300
Message-Id: <1429098268-9695-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1429098268-9695-1-git-send-email-luiz.dentz@gmail.com>
References: <1429098268-9695-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes command info to also print ManufacturerData if available.
---
 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 1e76aef..f7a50f6 100644
--- a/client/main.c
+++ b/client/main.c
@@ -950,6 +950,7 @@ static void cmd_info(const char *arg)
 	print_property(proxy, "LegacyPairing");
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
+	print_property(proxy, "ManufacturerData");
 }
 
 static void pair_reply(DBusMessage *message, void *user_data)
-- 
2.1.0

