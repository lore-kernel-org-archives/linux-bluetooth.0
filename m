Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 5/5] scanparam: Remove unneeded header include
Date: Mon, 29 Jul 2013 09:59:32 -0400
Message-Id: <1375106372-2255-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1375106372-2255-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1375106372-2255-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 profiles/scanparam/scan.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index ebdb7b8..0236af6 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -29,8 +29,6 @@
 #include <stdbool.h>
 #include <errno.h>
 
-#include <bluetooth/bluetooth.h>
-
 #include "lib/uuid.h"
 #include "log.h"
 #include "plugin.h"
-- 
1.7.9.5

