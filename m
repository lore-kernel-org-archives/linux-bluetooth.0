Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH] input: fix coding style
Date: Tue, 27 Mar 2012 18:14:32 -0300
Message-Id: <1332882872-11889-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix line going over 80 columns.
---
 input/main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/input/main.c b/input/main.c
index e165ab4..da09b86 100644
--- a/input/main.c
+++ b/input/main.c
@@ -82,5 +82,5 @@ static void input_exit(void)
 	dbus_connection_unref(connection);
 }
 
-BLUETOOTH_PLUGIN_DEFINE(input, VERSION,
-			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, input_init, input_exit)
+BLUETOOTH_PLUGIN_DEFINE(input, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							input_init, input_exit)
-- 
1.7.7.6

