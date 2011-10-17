Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] fix build
Date: Mon, 17 Oct 2011 12:56:20 +0200
Message-Id: <1318848980-569-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

src/eir.c: In function ‘eir_parse’:
src/eir.c:72: error: ‘name_len’ may be used uninitialized in this function

and

thermometer/thermometer.c: In function ‘destroy_char’:
thermometer/thermometer.c:79: error: implicit declaration of function ‘g_slist_free_full’
---
 src/eir.c                 |    2 +-
 thermometer/thermometer.c |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index 8772191..8ada364 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -69,7 +69,7 @@ int eir_parse(struct eir_data *eir, uint8_t *eir_data)
 	uuid_t service;
 	char *uuid_str;
 	const char *name = NULL;
-	size_t name_len;
+	size_t name_len = 0;
 	unsigned int i;
 
 	eir->flags = -1;
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 7621926..653ec76 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -20,6 +20,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <gdbus.h>
 #include <errno.h>
 #include <bluetooth/uuid.h>
@@ -34,6 +38,7 @@
 #include "att.h"
 #include "gatt.h"
 #include "thermometer.h"
+#include "glib-helper.h"
 
 #define THERMOMETER_INTERFACE "org.bluez.Thermometer"
 
-- 
1.7.1

