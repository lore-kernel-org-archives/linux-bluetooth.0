Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/14] obexd/MAP: Fix missing include
Date: Fri, 4 Oct 2013 11:05:28 +0200
Message-ID: <1380877538-22614-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
References: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following build error:

  CC     obexd/client/obexd-mns.o
obexd/client/mns.c: In function ‘parse_event_report_handle’:
obexd/client/mns.c:187:2: error: implicit declaration of function
    ‘strtoull’ [-Werror=implicit-function-declaration]
---
 obexd/client/mns.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/obexd/client/mns.c b/obexd/client/mns.c
index b709650..0663def 100644
--- a/obexd/client/mns.c
+++ b/obexd/client/mns.c
@@ -31,6 +31,7 @@
 #include <fcntl.h>
 #include <inttypes.h>
 #include <stdbool.h>
+#include <stdlib.h>
 
 #include <gobex/gobex.h>
 #include <gobex/gobex-apparam.h>
-- 
1.8.4

