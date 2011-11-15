Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 11/16] irmc: remove unnecessary openobex includes
Date: Tue, 15 Nov 2011 15:28:02 +0200
Message-Id: <1321363687-32490-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
References: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/irmc.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/plugins/irmc.c b/plugins/irmc.c
index 2a198c8..6f28e51 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -34,9 +34,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-
-#include <openobex/obex.h>
-#include <openobex/obex_const.h>
+#include <inttypes.h>
 
 #include "obexd.h"
 #include "plugin.h"
-- 
1.7.7.1

