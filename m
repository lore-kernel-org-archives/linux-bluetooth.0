Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 16/23] client-api: Rename Transfer interface to org.bluez.obex.Transfer
Date: Tue,  5 Jun 2012 13:57:14 +0300
Message-Id: <1338893841-14234-17-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
References: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/transfer.c  |    4 ++--
 doc/client-api.txt |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index b807014..000a510 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -43,8 +43,8 @@
 #include "log.h"
 #include "transfer.h"
 
-#define TRANSFER_INTERFACE  "org.openobex.Transfer"
-#define TRANSFER_BASEPATH   "/org/openobex"
+#define TRANSFER_INTERFACE "org.bluez.obex.Transfer"
+#define TRANSFER_BASEPATH "/org/bluez/obex"
 
 #define OBC_TRANSFER_ERROR obc_transfer_error_quark()
 
diff --git a/doc/client-api.txt b/doc/client-api.txt
index 76bf722..473920f 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -356,7 +356,7 @@ Transfer hierarchy
 ==================
 
 Service		org.bluez.obex.client
-Interface	org.openobex.Transfer
+Interface	org.bluez.obex.Transfer
 Object path	[variable prefix]/{transfer0,transfer1,...}
 
 Methods		dict GetProperties()
-- 
1.7.10.2

