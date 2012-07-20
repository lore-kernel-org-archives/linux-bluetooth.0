Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 20 Jul 2012 10:30:32 -0600
Message-ID: <CAAbnaHY8BAx=JZRQ-m6BKkW3by60zo3o=Qu6tJ_JJxVNa0x9KQ@mail.gmail.com>
Subject: [RFC generichid 4/5]
From: Nathaniel Haggard <natester@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds the rest of the keyboard functions.

 input/generichid.c |  175 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 175 insertions(+), 0 deletions(-)

diff --git a/input/generichid.c b/input/generichid.c
index 3a5f073..42d6a29 100644
--- a/input/generichid.c
+++ b/input/generichid.c
@@ -363,10 +363,185 @@ static void initiate_keyboard(struct
keyboard_state *keyboard)
 	keyboard->last_value = 3;
 }

+static char is_control(unsigned char code)
+{
+	unsigned char hidcode = keycode2hidp[code];
+
+	if (hidcode >= 224 && hidcode <= 231)
+		return 1;
+
+	return 0;
+}
+
+static unsigned char mask(unsigned char code)
+{
+	unsigned char hidcode = keycode2hidp[code];
+
+	return 1 << (hidcode - 224);
+}
+
+static int key_up(struct keyboard_state *keyboard, unsigned char code)
+{
+    unsigned char i;
+
+    for (i = 4; i <= keyboard->last_value &&
+            keyboard->value[i] != keycode2hidp[code]; i++)
+        ;
+
+    if (i > keyboard->last_value)
+        return -EINVAL;
+
+    keyboard->value[i] = keyboard->value[keyboard->last_value];
+    keyboard->value[keyboard->last_value] = 0;
+    keyboard->last_value--;
+
+    return 0;
+}
+
+static int key_down(struct keyboard_state *keyboard, unsigned char code)
+{
+	int i;
+	unsigned char keycode;
+
+	keycode = keycode2hidp[code];
+	for (i = 4; i <= keyboard->last_value; i++)
+		if (keyboard->value[i] == keycode)
+			return 0;
+
+	if (keyboard->last_value == HIDP_KEYB_SIZE - 1)
+		return -EPERM;
+
+	keyboard->last_value++;
+	keyboard->value[keyboard->last_value] = keycode;
+
+	return 0;
+}
+
+static DBusMessage *phantom_state(GIOChannel *chan,
+		struct keyboard_state *keyboard, DBusMessage *msg)
+{
+	int fd, err;
+	unsigned char value[10];
+
+	value[0] = 0xa1;
+	value[1] = 0x01;
+	value[2] = value[3] = 0;
+
+	/* phantom state */
+	memset(&value[4], 1, 6);
+
+	if (chan == NULL)
+		return btd_error_not_connected(msg);
+
+	fd = g_io_channel_unix_get_fd(chan);
+
+	err = write(fd, value, HIDP_KEYB_SIZE);
+	if (err < 0)
+		return btd_error_not_connected(msg);
+
+	return NULL;
+}
+
+static DBusMessage *send_report(GIOChannel *chan,
+		struct keyboard_state *keyboard, DBusMessage *msg)
+{
+	int fd, err;
+
+	if (chan == NULL)
+		return btd_error_not_connected(msg);;
+
+	fd = g_io_channel_unix_get_fd(chan);
+
+	err = write(fd, keyboard->value, HIDP_KEYB_SIZE);
+	if (err < 0)
+		return btd_error_not_connected(msg);
+
+	return NULL;
+}
+
+
+
+static DBusMessage *keyboard_event(GIOChannel *chan, DBusMessage *msg,
+					struct keyboard_state *keyboard,
+					unsigned char code,
+					char value)
+{
+	DBusMessage *ret_msg;
+	int err = 0;
+
+	if (is_control(code)) {
+
+		if (value)
+			keyboard->value[2] |= mask(code);
+		else
+			keyboard->value[2] &= ~mask(code);
+
+	} else {
+
+		if (value)
+			err = key_down(keyboard, code);
+		else
+			err = key_up(keyboard, code);
+	}
+
+	if (err < 0) {
+
+		ret_msg = phantom_state(chan, keyboard, msg);
+
+		if (ret_msg)
+			return ret_msg;
+
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	}
+
+	ret_msg = send_report(chan, keyboard, msg);
+
+	if (ret_msg)
+		return ret_msg;
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+

 static DBusMessage *send_event(DBusConnection *conn,
 		DBusMessage *msg, void *data)
 {
+	DBusMessageIter iter;
+	char mode, value;
+	unsigned int code;
+	struct adapter_data *adapt = data;
+	struct device_data *dev = adapt->dev;
+
+	if (!dbus_message_iter_init(msg, &iter))
+			return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BYTE)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &mode);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &code);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BYTE)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &value);
+
+	if (dev->intr == NULL)
+		return btd_error_not_connected(msg);
+
+	if (mode == EV_KEY) /* keboard */
+		return keyboard_event(dev->intr, msg,
+					&(dev->keyboard),
+					(unsigned char) code, value);
+
+
 	return btd_error_failed(msg, "Invalid profile mode");
 }
