Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] client: Fix output for DBUS_TYPE_UINT32 iter
Date: Fri, 28 Jul 2017 15:07:53 +0300
Message-Id: <20170728120754.5263-4-luiz.dentz@gmail.com>
In-Reply-To: <20170728120754.5263-1-luiz.dentz@gmail.com>
References: <20170728120754.5263-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The correct for should be 0x%08x not 0x%06x.
---
 client/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 76e337c3d..5eb83e33f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -236,7 +236,7 @@ static void print_iter(const char *label, const char *name,
 		break;
 	case DBUS_TYPE_UINT32:
 		dbus_message_iter_get_basic(iter, &valu32);
-		rl_printf("%s%s: 0x%06x\n", label, name, valu32);
+		rl_printf("%s%s: 0x%08x\n", label, name, valu32);
 		break;
 	case DBUS_TYPE_UINT16:
 		dbus_message_iter_get_basic(iter, &valu16);
-- 
2.13.3

