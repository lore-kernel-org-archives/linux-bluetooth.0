Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 05/10] scanparam: Fix remaining references to bluetooth/uuid.h
Date: Thu, 10 Jan 2013 09:15:04 -0400
Message-Id: <1357823709-8627-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These headers are not public anymore, so need to use "lib/uuid.h".
---
 profiles/scanparam/scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 7c21ac3..268bdc8 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -30,8 +30,8 @@
 #include <errno.h>
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/uuid.h>
 
+#include "lib/uuid.h"
 #include "log.h"
 #include "plugin.h"
 #include "adapter.h"
-- 
1.7.9.5

