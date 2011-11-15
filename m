Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 15/16] syncevolution: remove unnecessary openobex includes
Date: Tue, 15 Nov 2011 15:28:06 +0200
Message-Id: <1321363687-32490-15-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
References: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/syncevolution.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
index 0a50a24..41386b3 100644
--- a/plugins/syncevolution.c
+++ b/plugins/syncevolution.c
@@ -34,9 +34,6 @@
 
 #include <bluetooth/bluetooth.h>
 
-#include <openobex/obex.h>
-#include <openobex/obex_const.h>
-
 #include "plugin.h"
 #include "obex.h"
 #include "service.h"
-- 
1.7.7.1

