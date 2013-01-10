Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 09/10] attrib: Fix remaining references to bluetooth/uuid.h
Date: Thu, 10 Jan 2013 09:15:08 -0400
Message-Id: <1357823709-8627-9-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These headers are not public anymore, so need to use "lib/uuid.h".
---
 attrib/att.c          |    2 +-
 attrib/gatt-service.c |    2 +-
 attrib/gatt.c         |    2 +-
 attrib/gattrib.c      |    4 ++--
 attrib/gatttool.c     |    2 +-
 attrib/interactive.c  |    3 +--
 attrib/utils.c        |    2 +-
 7 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index de11811..b26273e 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -31,10 +31,10 @@
 #include <stdlib.h>
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/uuid.h>
 
 #include <glib.h>
 
+#include "lib/uuid.h"
 #include "att.h"
 
 const char *att_ecode2str(uint8_t status)
diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index e8788d9..bdb12cd 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -27,10 +27,10 @@
 #endif
 
 #include <glib.h>
-#include <bluetooth/uuid.h>
 #include <bluetooth/sdp.h>
 #include <adapter.h>
 
+#include "lib/uuid.h"
 #include "gattrib.h"
 #include "att.h"
 #include "gatt.h"
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 38c050e..d54feac 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -29,10 +29,10 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <glib.h>
-#include <bluetooth/uuid.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
+#include "lib/uuid.h"
 #include "att.h"
 #include "gattrib.h"
 #include "gatt.h"
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index bf40532..58f19d0 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -33,9 +33,9 @@
 #include <stdio.h>
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/uuid.h>
-
 #include <btio/btio.h>
+
+#include "lib/uuid.h"
 #include "log.h"
 #include "att.h"
 #include "gattrib.h"
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index e66059d..29e3261 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -34,8 +34,8 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
-#include <bluetooth/uuid.h>
 
+#include "lib/uuid.h"
 #include "att.h"
 #include <btio/btio.h>
 #include "gattrib.h"
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 51f620a..a99ad0a 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -31,11 +31,10 @@
 #include <stdio.h>
 #include <glib.h>
 
-#include <bluetooth/uuid.h>
-
 #include <readline/readline.h>
 #include <readline/history.h>
 
+#include "lib/uuid.h"
 #include <btio/btio.h>
 #include "att.h"
 #include "gattrib.h"
diff --git a/attrib/utils.c b/attrib/utils.c
index 43244c2..f9813d1 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -31,9 +31,9 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
-#include <bluetooth/uuid.h>
 #include <bluetooth/sdp.h>
 
+#include "lib/uuid.h"
 #include <btio/btio.h>
 #include "att.h"
 #include "gattrib.h"
-- 
1.7.9.5

