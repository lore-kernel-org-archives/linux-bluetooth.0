Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] build: Fix make distcheck for src/profile.c
Date: Wed, 26 Sep 2012 14:22:42 -0400
Message-Id: <1348683762-28057-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix this "make distcheck" error:

../src/profile.c:39:18: fatal error: uuid.h: No such file or directory
---
 src/profile.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/profile.c b/src/profile.c
index 4e84d19..ad2ad4a 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -34,9 +34,9 @@
 #include <gdbus.h>
 
 #include <bluetooth/bluetooth.h>
+#include <bluetooth/uuid.h>
 
 #include "btio.h"
-#include "uuid.h"
 #include "log.h"
 #include "error.h"
 #include "dbus-common.h"
-- 
1.7.9.5

