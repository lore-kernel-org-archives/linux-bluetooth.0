Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 08/16] bluetooth: remove unnecessary openobex includes
Date: Tue, 15 Nov 2011 15:27:59 +0200
Message-Id: <1321363687-32490-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
References: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/bluetooth.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 1a57654..c73beb6 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -28,9 +28,8 @@
 
 #include <errno.h>
 #include <string.h>
-
-#include <openobex/obex.h>
-#include <openobex/obex_const.h>
+#include <unistd.h>
+#include <inttypes.h>
 
 #include <glib.h>
 #include <gdbus.h>
-- 
1.7.7.1

