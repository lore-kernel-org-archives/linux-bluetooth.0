Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Fri, 22 Jan 2016 15:21:45 +0100
Message-ID: <CAEZxfGO7N0FykMj2bm9jpX9JSYreJF+O_3BUFMAgxq2Dn5=dNw@mail.gmail.com>
Subject: [PATCH] Updated bluetoothctl command to remove all devices
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As discussed on IRC, removing all devices will be easier thanks to
"remove *" in bluetoothctl.

---
 client/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/client/main.c b/client/main.c
index b695744..1361e80 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1317,6 +1317,7 @@ static void remove_device_setup(DBusMessageIter
*iter, void *user_data)
 static void cmd_remove(const char *arg)
 {
  GDBusProxy *proxy;
+ GList *list;
  char *path;

  if (!arg || !strlen(arg)) {
@@ -1327,6 +1328,14 @@ static void cmd_remove(const char *arg)
  if (check_default_ctrl() == FALSE)
  return;

+ if (strcmp(arg, "*") == 0) {
+ for (list = g_list_first(dev_list); list; list = g_list_next(list)) {
+ GDBusProxy *proxy = list->data;
+ cmd_remove(g_dbus_proxy_get_path(proxy));
+ }
+ return;
+ }
+
  proxy = find_proxy_by_address(dev_list, arg);
  if (!proxy) {
  rl_printf("Device %s not available\n", arg);
-- 
2.7.0
