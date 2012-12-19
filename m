Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/3] core: Fix trying to store NULL adapter->name
Date: Tue, 18 Dec 2012 21:16:13 -0400
Message-Id: <1355879775-5809-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When BlueZ starts without a main.conf, adapter->name will be initially
NULL, until adapter_name_changed() is called and name is set to "BlueZ".

Before this, store_adapter_info() will try to access a NULL pointer.

Fixes this GLib error:

(bluetoothd:1721): GLib-CRITICAL **: g_key_file_set_string: assertion
`string != NULL' failed
---
 src/adapter.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9b83afe..d62b0fe 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -193,7 +193,9 @@ static void store_adapter_info(struct btd_adapter *adapter)
 
 	key_file = g_key_file_new();
 
-	g_key_file_set_string(key_file, "General", "Name", adapter->name);
+	if (adapter->name)
+		g_key_file_set_string(key_file, "General", "Name",
+								adapter->name);
 
 	g_key_file_set_boolean(key_file, "General", "Pairable",
 				adapter->pairable);
-- 
1.7.9.5

