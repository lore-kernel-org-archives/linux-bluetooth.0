Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 14/16] pcsuite: remove unnecessary openobex includes
Date: Tue, 15 Nov 2011 15:28:05 +0200
Message-Id: <1321363687-32490-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
References: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/pcsuite.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/plugins/pcsuite.c b/plugins/pcsuite.c
index f321207..f3d0b1a 100644
--- a/plugins/pcsuite.c
+++ b/plugins/pcsuite.c
@@ -36,13 +36,11 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <inttypes.h>
 
 #include <glib.h>
 #include "gdbus.h"
 
-#include <openobex/obex.h>
-#include <openobex/obex_const.h>
-
 #include "obexd.h"
 #include "plugin.h"
 #include "log.h"
-- 
1.7.7.1

