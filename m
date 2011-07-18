Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 3/7] Load HTP plugin only if LE is enabled
Date: Mon, 18 Jul 2011 15:10:38 +0200
Message-Id: <1310994642-16375-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1310994642-16375-2-git-send-email-sancane@gmail.com>
References: <1310994642-16375-1-git-send-email-sancane@gmail.com>
 <1310994642-16375-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/main.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/thermometer/main.c b/thermometer/main.c
index 33649a7..df3f1ff 100644
--- a/thermometer/main.c
+++ b/thermometer/main.c
@@ -30,14 +30,19 @@
 #include <glib.h>
 #include <errno.h>
 #include <gdbus.h>
+#include <stdint.h>
 
 #include "plugin.h"
+#include "hcid.h"
 #include "manager.h"
 
 static DBusConnection *connection = NULL;
 
 static int thermometer_init(void)
 {
+	if (!main_opts.le)
+		return -EINVAL;
+
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
 	if (connection == NULL)
 		return -EIO;
-- 
1.7.6

