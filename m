Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] client: Use rl_hexdump to print fixed sized iterators
Date: Fri, 28 Jul 2017 15:07:54 +0300
Message-Id: <20170728120754.5263-5-luiz.dentz@gmail.com>
In-Reply-To: <20170728120754.5263-1-luiz.dentz@gmail.com>
References: <20170728120754.5263-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the output less clutter with duplicated infomation:

before:

[CHG] Device 00:1B:DC:07:31:88 ServiceData Key: 00001827-0000-1000-8000-00805f9b34fb
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0xdd
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0xdd
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00

after:

[CHG] Device 00:1B:DC:07:31:88 ServiceData Key: 00001827-0000-1000-8000-00805f9b34fb
  dd dd 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  00 00                                            ..
---
 client/main.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/client/main.c b/client/main.c
index 5eb83e33f..6ed0f7a94 100644
--- a/client/main.c
+++ b/client/main.c
@@ -203,6 +203,72 @@ static void print_device(GDBusProxy *proxy, const char *description)
 				address, name);
 }
 
+static void print_fixed_iter(const char *label, const char *name,
+						DBusMessageIter *iter)
+{
+	dbus_bool_t *valbool;
+	dbus_uint32_t *valu32;
+	dbus_uint16_t *valu16;
+	dbus_int16_t *vals16;
+	unsigned char *byte;
+	int len;
+
+	switch (dbus_message_iter_get_arg_type(iter)) {
+	case DBUS_TYPE_BOOLEAN:
+		dbus_message_iter_get_fixed_array(iter, &valbool, &len);
+
+		if (len <= 0)
+			return;
+
+		rl_printf("%s%s:", label, name);
+		rl_hexdump((void *)valbool, len * sizeof(*valbool));
+
+		break;
+	case DBUS_TYPE_UINT32:
+		dbus_message_iter_get_fixed_array(iter, &valu32, &len);
+
+		if (len <= 0)
+			return;
+
+		rl_printf("%s%s:", label, name);
+		rl_hexdump((void *)valu32, len * sizeof(*valu32));
+
+		break;
+	case DBUS_TYPE_UINT16:
+		dbus_message_iter_get_fixed_array(iter, &valu16, &len);
+
+		if (len <= 0)
+			return;
+
+		rl_printf("%s%s:", label, name);
+		rl_hexdump((void *)valu16, len * sizeof(*valu16));
+
+		break;
+	case DBUS_TYPE_INT16:
+		dbus_message_iter_get_fixed_array(iter, &vals16, &len);
+
+		if (len <= 0)
+			return;
+
+		rl_printf("%s%s:", label, name);
+		rl_hexdump((void *)vals16, len * sizeof(*vals16));
+
+		break;
+	case DBUS_TYPE_BYTE:
+		dbus_message_iter_get_fixed_array(iter, &byte, &len);
+
+		if (len <= 0)
+			return;
+
+		rl_printf("%s%s:", label, name);
+		rl_hexdump((void *)byte, len * sizeof(*byte));
+
+		break;
+	default:
+		return;
+	};
+}
+
 static void print_iter(const char *label, const char *name,
 						DBusMessageIter *iter)
 {
@@ -256,6 +322,13 @@ static void print_iter(const char *label, const char *name,
 		break;
 	case DBUS_TYPE_ARRAY:
 		dbus_message_iter_recurse(iter, &subiter);
+
+		if (dbus_type_is_fixed(
+				dbus_message_iter_get_arg_type(&subiter))) {
+			print_fixed_iter(label, name, &subiter);
+			break;
+		}
+
 		while (dbus_message_iter_get_arg_type(&subiter) !=
 							DBUS_TYPE_INVALID) {
 			print_iter(label, name, &subiter);
-- 
2.13.3

