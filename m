Return-Path: <cyrus@holtmann.org>
From: Burt Silverman <burtms@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Burt Silverman <burtms@gmail.com>
Subject: [PATCH] Print an error message if g_dbus_setup_bus fails.
Date: Fri, 26 Aug 2011 18:39:01 -0400
Message-Id: <1314398341-2733-1-git-send-email-burtms@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

That is standard processing when dbus_error_is_set() returns true, according to
dbus/dbus/dbus-errors.c.
In this case of g_dbus_setup_bus(), it provides extra help for determing the
specific cause of the error.
---
 src/main.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/main.c b/src/main.c
index 7fecc5a..6dc60a4 100644
--- a/src/main.c
+++ b/src/main.c
@@ -311,6 +311,7 @@ static int connect_dbus(void)
 	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, BLUEZ_NAME, &err);
 	if (!conn) {
 		if (dbus_error_is_set(&err)) {
+			g_printerr("an error occurred: %s\n", err.message);
 			dbus_error_free(&err);
 			return -EIO;
 		}
-- 
1.7.6

