Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 01/26] obexd: Include the headers for types we use
Date: Thu,  9 May 2013 01:16:31 -0300
Message-Id: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 obexd/client/transfer.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/obexd/client/transfer.h b/obexd/client/transfer.h
index b6b835d..0d54733 100644
--- a/obexd/client/transfer.h
+++ b/obexd/client/transfer.h
@@ -22,6 +22,10 @@
  *
  */
 
+#include <dbus/dbus.h>
+#include <glib.h>
+#include <stdlib.h>
+
 struct obc_transfer;
 
 typedef void (*transfer_callback_t) (struct obc_transfer *transfer,
-- 
1.8.2.2

