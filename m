Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] tools/bluetooth-player: check path validity
Date: Fri, 10 Jan 2014 18:31:01 +0200
Message-Id: <1389371461-11578-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth-player change-folder cmd approves any argument however it
can be and then should a valid path only. Failing in providing
a valid path crashes bluetooth-player thus argument should be
checked if it's a valid path.
---
 tools/bluetooth-player.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index 2afdd17..f10d9be 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -738,6 +738,11 @@ static void cmd_change_folder(int argc, char *argv[])
 		return;
 	}
 
+	if (dbus_validate_path(argv[1], NULL) == FALSE) {
+		rl_printf("Not a valid path\n");
+		return;
+	}
+
 	if (check_default_player() == FALSE)
 		return;
 
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

