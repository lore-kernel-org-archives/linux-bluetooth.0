Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-Id: <380b1f56d9e84d503d2d11fb9510b0eda274cad2.1448381195.git.hramrach@gmail.com>
From: Michal Suchanek <hramrach@gmail.com>
Date: Tue, 24 Nov 2015 17:01:32 +0100
Subject: Fix crash when incorrect reply is received from SelectConfiguration
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no check that SelectConfiguration call on MediaEndpoint1
returns an array before accessing the array. When the return from
SelectConfiguration is not an array type bluetoothd crashes.

Ignore the reply in that case.
---
 profiles/audio/media.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 69070bf..a5cb490 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -292,6 +292,12 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 
 		dbus_message_iter_init(reply, &args);
 
+		if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY) {
+			error("SelectConfiguration did not return an array: %s",
+				dbus_message_get_signature(reply));
+			goto done;
+		}
+
 		dbus_message_iter_recurse(&args, &array);
 
 		dbus_message_iter_get_fixed_array(&array, &configuration, &size);
-- 
2.6.2

