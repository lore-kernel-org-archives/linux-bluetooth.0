Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 06/16] ftp: remove unnecessary openobex includes
Date: Tue, 15 Nov 2011 15:27:57 +0200
Message-Id: <1321363687-32490-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
References: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/ftp.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 9a82754..9b102d0 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -36,12 +36,10 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
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

