Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 3/3] Remove old defines from serial code
Date: Fri, 21 May 2010 09:26:16 -0300
Message-Id: <1274444776-14284-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1274444776-14284-2-git-send-email-gustavo@padovan.org>
References: <1274444776-14284-1-git-send-email-gustavo@padovan.org>
 <1274444776-14284-2-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 serial/manager.c |    4 ----
 serial/proxy.c   |    6 ------
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/serial/manager.c b/serial/manager.c
index a7deab1..1b3f1d6 100644
--- a/serial/manager.c
+++ b/serial/manager.c
@@ -66,10 +66,6 @@
 #include "sdpd.h"
 #include "glib-helper.h"
 
-#define SERIAL_PORT_UUID	"00001101-0000-1000-8000-00805F9B34FB"
-#define DIALUP_NET_UUID		"00001103-0000-1000-8000-00805F9B34FB"
-#define OBJECT_PUSH_UUID	"00001105-0000-1000-8000-00805F9B34FB"
-#define FILE_TRANSFER_UUID	"00001106-0000-1000-8000-00805F9B34FB"
 #define RFCOMM_UUID_STR		"00000003-0000-1000-8000-00805F9B34FB"
 
 static DBusConnection *connection = NULL;
diff --git a/serial/proxy.c b/serial/proxy.c
index 80c1189..6577fe2 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -63,12 +63,6 @@
 #include "btio.h"
 #include "proxy.h"
 
-#define SERIAL_PORT_NAME	"spp"
-#define SERIAL_PORT_UUID	"00001101-0000-1000-8000-00805F9B34FB"
-
-#define DIALUP_NET_NAME		"dun"
-#define DIALUP_NET_UUID		"00001103-0000-1000-8000-00805F9B34FB"
-
 #define SERIAL_PROXY_INTERFACE	"org.bluez.SerialProxy"
 #define SERIAL_MANAGER_INTERFACE "org.bluez.SerialProxyManager"
 #define BUF_SIZE		1024
-- 
1.7.1

