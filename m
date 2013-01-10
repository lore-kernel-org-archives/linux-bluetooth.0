Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 10/10] unit: Fix remaining references to bluetooth/uuid.h
Date: Thu, 10 Jan 2013 09:15:09 -0400
Message-Id: <1357823709-8627-10-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These headers are not public anymore, so need to use "lib/uuid.h".
---
 unit/test-uuid.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/unit/test-uuid.c b/unit/test-uuid.c
index cbccc82..79ab3e6 100644
--- a/unit/test-uuid.c
+++ b/unit/test-uuid.c
@@ -28,7 +28,8 @@
 #include <glib.h>
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/uuid.h>
+
+#include "lib/uuid.h"
 
 struct uuid_test_data {
 	const char *str;
-- 
1.7.9.5

