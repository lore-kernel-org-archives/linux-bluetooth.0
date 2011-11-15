Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 10/16] filesystem: remove unnecessary openobex includes
Date: Tue, 15 Nov 2011 15:28:01 +0200
Message-Id: <1321363687-32490-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
References: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/filesystem.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index 12ca209..68785c6 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -39,12 +39,10 @@
 #include <sys/sendfile.h>
 #include <fcntl.h>
 #include <wait.h>
+#include <inttypes.h>
 
 #include <glib.h>
 
-#include <openobex/obex.h>
-#include <openobex/obex_const.h>
-
 #include "obexd.h"
 #include "plugin.h"
 #include "log.h"
-- 
1.7.7.1

