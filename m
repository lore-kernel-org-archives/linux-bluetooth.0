Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 09/16] usb: remove unnecessary openobex includes
Date: Tue, 15 Nov 2011 15:28:00 +0200
Message-Id: <1321363687-32490-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
References: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/usb.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/plugins/usb.c b/plugins/usb.c
index 12fb30c..3da77d0 100644
--- a/plugins/usb.c
+++ b/plugins/usb.c
@@ -34,9 +34,7 @@
 #include <signal.h>
 #include <fcntl.h>
 #include <termios.h>
-
-#include <openobex/obex.h>
-#include <openobex/obex_const.h>
+#include <inttypes.h>
 
 #include <glib.h>
 #include <gdbus.h>
-- 
1.7.7.1

