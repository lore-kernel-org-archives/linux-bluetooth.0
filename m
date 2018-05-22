Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/8] client: Print AD Data and Discoverable once registered
Date: Tue, 22 May 2018 12:50:08 +0300
Message-Id: <20180522095011.517-5-luiz.dentz@gmail.com>
In-Reply-To: <20180522095011.517-1-luiz.dentz@gmail.com>
References: <20180522095011.517-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints both Data and Discoverable if advertise command succeeds:

[bluetooth]# advertise.data 0x26 0x01 0x00
[bluetooth]# advertise.discoverable on
[bluetooth]# advertise on
Advertising object registered
Data Type: 0x26
  01 00                                            ..
Tx Power: off
Name: off
Apperance: off
Discoverable: on
---
 client/advertising.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index cb0ca4a57..8abf4785b 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -164,6 +164,11 @@ static void print_ad(void)
 						ad.manufacturer.data.len);
 	}
 
+	if (ad.data.data.len) {
+		bt_shell_printf("Data Type: 0x%02x\n", ad.data.type);
+		bt_shell_hexdump(ad.data.data.data, ad.data.data.len);
+	}
+
 	bt_shell_printf("Tx Power: %s\n", ad.tx_power ? "on" : "off");
 
 	if (ad.local_name)
@@ -179,6 +184,8 @@ static void print_ad(void)
 		bt_shell_printf("Apperance: %s\n",
 					ad.appearance ? "on" : "off");
 
+	bt_shell_printf("Discoverable: %s\n", ad.discoverable ? "on": "off");
+
 	if (ad.duration)
 		bt_shell_printf("Duration: %u sec\n", ad.duration);
 
-- 
2.14.3

