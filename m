Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 10/23] client-api: Rename session interface to org.bluez.obex.Session
Date: Tue,  5 Jun 2012 13:57:08 +0300
Message-Id: <1338893841-14234-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
References: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The base is also changed to /org/bluez/obex to follow the new namespace
---
 client/session.c   |    4 ++--
 doc/client-api.txt |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/client/session.c b/client/session.c
index ac5c7f2..7014396 100644
--- a/client/session.c
+++ b/client/session.c
@@ -45,8 +45,8 @@
 #include "driver.h"
 #include "transport.h"
 
-#define SESSION_INTERFACE  "org.openobex.Session"
-#define SESSION_BASEPATH   "/org/openobex"
+#define SESSION_INTERFACE "org.bluez.obex.Session"
+#define SESSION_BASEPATH "/org/bluez/obex"
 
 #define OBEX_IO_ERROR obex_io_error_quark()
 #define OBEX_IO_ERROR_FIRST (0xff + 1)
diff --git a/doc/client-api.txt b/doc/client-api.txt
index 6d2c05f..23d05dd 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -40,7 +40,7 @@ Session hierarchy
 =================
 
 Service		org.bluez.obex.client
-Interface	org.openobex.Session
+Interface	org.bluez.obex.Session
 Object path	[variable prefix]/{session0,session1,...}
 
 Methods		dict GetProperties()
-- 
1.7.10.2

