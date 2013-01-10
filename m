Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 02/10] plugins: Fix remaining references to bluetooth/uuid.h
Date: Thu, 10 Jan 2013 09:15:01 -0400
Message-Id: <1357823709-8627-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These headers are not public anymore, so need to use "lib/uuid.h".
---
 plugins/gatt-example.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index de090e9..bd0fbff 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -27,10 +27,10 @@
 #endif
 
 #include <glib.h>
-#include <bluetooth/uuid.h>
 #include <errno.h>
 #include <adapter.h>
 
+#include "lib/uuid.h"
 #include "plugin.h"
 #include "hcid.h"
 #include "log.h"
-- 
1.7.9.5

