Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 07/10] time: Fix remaining references to bluetooth/uuid.h
Date: Thu, 10 Jan 2013 09:15:06 -0400
Message-Id: <1357823709-8627-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These headers are not public anymore, so need to use "lib/uuid.h".
---
 profiles/time/server.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/profiles/time/server.c b/profiles/time/server.c
index ab9fbb4..518a29f 100644
--- a/profiles/time/server.c
+++ b/profiles/time/server.c
@@ -31,13 +31,12 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include <bluetooth/uuid.h>
-
 #include <adapter.h>
 #include <device.h>
 #include <profile.h>
 #include <plugin.h>
 
+#include "lib/uuid.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
 #include "attrib/gatt.h"
-- 
1.7.9.5

