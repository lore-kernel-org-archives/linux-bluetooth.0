Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 12/16] mas: remove unnecessary openobex includes
Date: Tue, 15 Nov 2011 15:28:03 +0200
Message-Id: <1321363687-32490-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
References: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/mas.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index b104d8f..3c3104c 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -27,8 +27,8 @@
 
 #include <errno.h>
 #include <glib.h>
-#include <openobex/obex.h>
 #include <fcntl.h>
+#include <inttypes.h>
 
 #include "obexd.h"
 #include "plugin.h"
-- 
1.7.7.1

