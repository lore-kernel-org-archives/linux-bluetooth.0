Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/14] obexd/MAP: Fix missing include
Date: Fri, 4 Oct 2013 11:05:34 +0200
Message-ID: <1380877538-22614-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
References: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following build error:

  CC     obexd/client/obexd-map.o
obexd/client/map.c: In function ‘msg_element’:
obexd/client/map.c:1113:2: error: implicit declaration of function ‘strtoull’ [-Werror=implicit-function-declaration]
---
 obexd/client/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index fe15bab..801d715 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -29,6 +29,7 @@
 #include <stdio.h>
 #include <stdbool.h>
 #include <inttypes.h>
+#include <stdlib.h>
 #include <glib.h>
 #include <gdbus/gdbus.h>
 #include <gobex/gobex-apparam.h>
-- 
1.8.4

