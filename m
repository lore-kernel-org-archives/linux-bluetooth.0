Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 8/9] client: Make info command print Advertising{Flags,Data}
Date: Wed,  2 May 2018 12:24:41 +0300
Message-Id: <20180502092442.10567-8-luiz.dentz@gmail.com>
In-Reply-To: <20180502092442.10567-1-luiz.dentz@gmail.com>
References: <20180502092442.10567-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/client/main.c b/client/main.c
index ebd7c195c..54bd5371a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1490,6 +1490,8 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "ServiceData");
 	print_property(proxy, "RSSI");
 	print_property(proxy, "TxPower");
+	print_property(proxy, "AdvertisingFlags");
+	print_property(proxy, "AdvertisingData");
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
-- 
2.14.3

