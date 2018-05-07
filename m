Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] client: Print AD Data and Flags once registered
Date: Mon,  7 May 2018 19:14:03 +0300
Message-Id: <20180507161403.14181-5-luiz.dentz@gmail.com>
In-Reply-To: <20180507161403.14181-1-luiz.dentz@gmail.com>
References: <20180507161403.14181-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints both Data and Flags if advertise command succeeds:

[bluetooth]# advertise.data 0x26 0x01 0x00
[bluetooth]# advertise.flags 0x02
[bluetooth]# advertise on
Advertising object registered
Data Type: 0x26
  01 00                                            ..
Flags:
  02                                               .
Tx Power: off
Name: off
Apperance: off
---
 client/advertising.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index a0fc32eea..44ffd4a94 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -164,6 +164,16 @@ static void print_ad(void)
 						ad.manufacturer.data.len);
 	}
 
+	if (ad.data.data.len) {
+		bt_shell_printf("Data Type: 0x%02x\n", ad.data.type);
+		bt_shell_hexdump(ad.data.data.data, ad.data.data.len);
+	}
+
+	if (ad.flags[0]) {
+		bt_shell_printf("Flags:\n");
+		bt_shell_hexdump(ad.flags, sizeof(ad.flags));
+	}
+
 	bt_shell_printf("Tx Power: %s\n", ad.tx_power ? "on" : "off");
 
 	if (ad.local_name)
-- 
2.14.3

