Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 1/2] input: Remove unneeded header include
Date: Wed, 19 Sep 2012 16:33:41 -0300
Message-Id: <1348083222-15294-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/manager.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 13096c7..30a3c05 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -39,7 +39,6 @@
 #include "../src/profile.h"
 
 #include "device.h"
-#include "hog_device.h"
 #include "server.h"
 #include "manager.h"
 
-- 
1.7.12

