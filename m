Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/11] client: Make command info print ServiceData
Date: Wed, 15 Apr 2015 14:44:28 +0300
Message-Id: <1429098268-9695-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1429098268-9695-1-git-send-email-luiz.dentz@gmail.com>
References: <1429098268-9695-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes command info to also print ServiceData if available.
---
 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index f7a50f6..5250a33 100644
--- a/client/main.c
+++ b/client/main.c
@@ -951,6 +951,7 @@ static void cmd_info(const char *arg)
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
 	print_property(proxy, "ManufacturerData");
+	print_property(proxy, "ServiceData");
 }
 
 static void pair_reply(DBusMessage *message, void *user_data)
-- 
2.1.0

