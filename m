Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Remove unnecessary headers from main.c
Date: Thu,  5 May 2011 17:33:54 -0300
Message-Id: <1304627636-22358-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1304627636-22358-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1304627636-22358-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/main.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/src/main.c b/src/main.c
index 34d291f..e451e72 100644
--- a/src/main.c
+++ b/src/main.c
@@ -33,10 +33,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <signal.h>
-#include <sys/stat.h>
-#include <sys/ioctl.h>
-#include <sys/socket.h>
 #include <sys/types.h>
+#include <sys/stat.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/uuid.h>
@@ -53,7 +51,6 @@
 #include "sdpd.h"
 #include "attrib-server.h"
 #include "adapter.h"
-#include "event.h"
 #include "dbus-common.h"
 #include "agent.h"
 #include "manager.h"
-- 
1.7.5.rc3

