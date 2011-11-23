Return-Path: <cyrus@holtmann.org>
From: Timo Gienger <timo.gienger@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fixed reading of on_mode in btd_adapter_get_mode
Date: Wed, 23 Nov 2011 14:11:56 +0100
Message-Id: <c594ae0af9ab028cb1d6e273cc8ae35b560f6fbb.1322040739.git.timo.gienger@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If InitiallyPowered was set to false, it was not possible to
use hciconfig tool, as on_mode variable was set to MODE_OFF
making it impossible to enable BT via hciconfig until a DBUS
call was done and the variable was set in config file as
connectable.
Furthermore removed if-else condition, as the both calls
done exactly the same. Removed also last else condition
as MODE_OFF should not be valid for on_mode.
Fix tested with hciops interface.

Signed-off-by: Timo Gienger <timo.gienger@nokia.com>
---
 src/adapter.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2b4b7e3..c58eb47 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2220,14 +2220,8 @@ void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
 			*mode = main_opts.mode;
 	}
 
-	if (on_mode) {
-		if (main_opts.remember_powered == FALSE)
-			*on_mode = get_mode(&adapter->bdaddr, "on");
-		else if (read_on_mode(address, str, sizeof(str)) == 0)
-			*on_mode = get_mode(&adapter->bdaddr, str);
-		else
-			*on_mode = main_opts.mode;
-	}
+	if (on_mode)
+		*on_mode = get_mode(&adapter->bdaddr, "on");
 
 	if (pairable)
 		*pairable = adapter->pairable;
-- 
1.7.0.4

