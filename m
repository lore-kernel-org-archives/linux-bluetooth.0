Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/14] obexd/MAP: Fix missing include
Date: Fri, 4 Oct 2013 11:05:27 +0200
Message-ID: <1380877538-22614-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
References: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following build error:

  CC     obexd/client/obexd-mns.o
obexd/client/mns.c: In function ‘mns_connect’:
obexd/client/mns.c:105:2: error: implicit declaration of function
    ‘manager_register_session’ [-Werror=implicit-function-declaration]
obexd/client/mns.c: In function ‘mns_disconnect’:
obexd/client/mns.c:128:2: error: implicit declaration of function
    ‘manager_unregister_session’ [-Werror=implicit-function-declaration]
---
 obexd/client/mns.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/obexd/client/mns.c b/obexd/client/mns.c
index ee64ed6..b709650 100644
--- a/obexd/client/mns.c
+++ b/obexd/client/mns.c
@@ -44,6 +44,8 @@
 #include "map_ap.h"
 #include "map-event.h"
 
+#include "../src/manager.h"
+
 struct mns_session {
 	GString *buffer;
 	GObexApparam *inparams;
-- 
1.8.4

