Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 04/10] gatt: Fix remaining references to bluetooth/uuid.h
Date: Thu, 10 Jan 2013 09:15:03 -0400
Message-Id: <1357823709-8627-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These headers are not public anymore, so need to use "lib/uuid.h".
---
 profiles/gatt/gas.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index b5e0e52..429850b 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -32,9 +32,9 @@
 #include <errno.h>
 
 #include <glib.h>
-#include <bluetooth/uuid.h>
 #include <btio/btio.h>
 
+#include "lib/uuid.h"
 #include "adapter.h"
 #include "device.h"
 #include "attrib/att.h"
-- 
1.7.9.5

