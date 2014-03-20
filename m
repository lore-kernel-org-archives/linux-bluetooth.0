Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0] attrib: Remove unneeded sdp.h header include
Date: Thu, 20 Mar 2014 14:25:59 -0300
Message-Id: <1395336359-16138-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt-service.c | 1 -
 attrib/utils.c        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 227d4d4..d15536c 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -27,7 +27,6 @@
 #endif
 
 #include <glib.h>
-#include <bluetooth/sdp.h>
 
 #include "src/adapter.h"
 #include "lib/uuid.h"
diff --git a/attrib/utils.c b/attrib/utils.c
index 17f02be..8f9a4c07 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -31,7 +31,6 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
-#include <bluetooth/sdp.h>
 
 #include "lib/uuid.h"
 #include "btio/btio.h"
-- 
1.8.3.1

