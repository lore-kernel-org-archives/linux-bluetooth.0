Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 06/10] alert: Fix remaining references to bluetooth/uuid.h
Date: Thu, 10 Jan 2013 09:15:05 -0400
Message-Id: <1357823709-8627-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These headers are not public anymore, so need to use "lib/uuid.h".
---
 profiles/alert/server.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 3736a0b..4536c81 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -30,9 +30,9 @@
 #include <errno.h>
 #include <gdbus/gdbus.h>
 #include <glib.h>
-#include <bluetooth/uuid.h>
 #include <stdlib.h>
 
+#include "lib/uuid.h"
 #include "plugin.h"
 #include "dbus-common.h"
 #include "attrib/att.h"
-- 
1.7.9.5

