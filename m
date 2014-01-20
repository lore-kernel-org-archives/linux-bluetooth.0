Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH 1/2] tools/bluetooth-player: dispaly searchable value
Date: Mon, 20 Jan 2014 15:04:37 +0200
Message-Id: <1390223078-29096-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/bluetooth-player.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index 1c0348e..32d295c 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -654,6 +654,7 @@ static void cmd_show(int argc, char *argv[])
 	rl_printf("Player %s\n", g_dbus_proxy_get_path(proxy));
 
 	print_property(proxy, "Name");
+	print_property(proxy, "Searchable");
 	print_property(proxy, "Repeat");
 	print_property(proxy, "Equalizer");
 	print_property(proxy, "Shuffle");
-- 
1.8.3.2

---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

