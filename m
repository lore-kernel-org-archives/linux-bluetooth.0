Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] Remove unneeded hcid.h header include
Date: Thu, 14 Jul 2011 10:52:43 -0300
Message-Id: <1310651563-21492-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/agent.c |    1 -
 src/event.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index 7bba849..607d8c2 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -41,7 +41,6 @@
 
 #include "log.h"
 
-#include "hcid.h"
 #include "adapter.h"
 #include "device.h"
 #include "agent.h"
diff --git a/src/event.c b/src/event.c
index f72c579..4d68fb3 100644
--- a/src/event.c
+++ b/src/event.c
@@ -47,7 +47,6 @@
 #include "log.h"
 #include "textfile.h"
 
-#include "hcid.h"
 #include "adapter.h"
 #include "manager.h"
 #include "device.h"
-- 
1.7.6

