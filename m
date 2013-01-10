Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 03/10] input: Fix remaining references to bluetooth/uuid.h
Date: Thu, 10 Jan 2013 09:15:02 -0400
Message-Id: <1357823709-8627-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These headers are not public anymore, so need to use "lib/uuid.h".
---
 profiles/input/hog.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 7f13abc..7f7bfd2 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -37,12 +37,12 @@
 #include "uhid_copy.h"
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/uuid.h>
 
 #include <glib.h>
 
 #include "log.h"
 
+#include "lib/uuid.h"
 #include "src/adapter.h"
 #include "src/device.h"
 #include "src/profile.h"
-- 
1.7.9.5

