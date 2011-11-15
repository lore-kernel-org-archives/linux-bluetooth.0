Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 07/16] opp: remove unnecessary openobex includes
Date: Tue, 15 Nov 2011 15:27:58 +0200
Message-Id: <1321363687-32490-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
References: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/opp.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/plugins/opp.c b/plugins/opp.c
index f93206d..2375a21 100644
--- a/plugins/opp.c
+++ b/plugins/opp.c
@@ -28,9 +28,8 @@
 
 #include <errno.h>
 #include <string.h>
-
-#include <openobex/obex.h>
-#include <openobex/obex_const.h>
+#include <unistd.h>
+#include <inttypes.h>
 
 #include <glib.h>
 
-- 
1.7.7.1

