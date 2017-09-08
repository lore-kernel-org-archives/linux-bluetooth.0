Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Laczen JMS <laczenjms@gmail.com>
Date: Fri, 8 Sep 2017 14:30:21 +0200
Message-ID: <CAFxSrVsWAbw4bRwk8En-O1sX3Afr2_N1Y=Snmdb3QTZeW8niUA@mail.gmail.com>
Subject: [PATCH 1/1] mesh: Remove StopNotify method to avoid reading data
 twice on some mesh nodes
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some mesh nodes do not change (e.g. zephyr) the notification when
given the StopNotify. As a result the data from the notification
channel is processed twice. This patch removes the StopNotify.

Kind regards,

Jehudi

  diff --git a/mesh/gatt.c b/mesh/gatt.c
index f9615b3..7d3b869 100644
--- a/mesh/gatt.c
+++ b/mesh/gatt.c
@@ -589,15 +589,10 @@ bool mesh_gatt_notify(GDBusProxy *proxy, bool
enable, GDBusReturnFunction cb,
  cb = notify_reply;
  }
  } else {
- if (notify_io) {
- notify_io_destroy();
- if (cb)
- cb(NULL, user_data);
- return true;
- } else {
- method = "StopNotify";
- cb = notify_reply;
- }
+ if (notify_io) notify_io_destroy();
+ if (cb) cb(NULL, user_data);
+
+ return true;
  }

  if (g_dbus_proxy_method_call(proxy, method, NULL, cb,
