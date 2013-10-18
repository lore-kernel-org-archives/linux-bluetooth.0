Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] core: Remove unneeded includes in device.c
Date: Fri, 18 Oct 2013 09:32:31 -0300
Message-Id: <1382099552-5562-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1382099552-5562-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1382099552-5562-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index 3dd3584..77f2322 100644
--- a/src/device.c
+++ b/src/device.c
@@ -31,8 +31,6 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <stdbool.h>
-#include <sys/stat.h>
-#include <sys/ioctl.h>
 #include <errno.h>
 #include <dirent.h>
 #include <time.h>
@@ -64,7 +62,6 @@
 #include "sdp-client.h"
 #include "attrib/gatt.h"
 #include "agent.h"
-#include "sdp-xml.h"
 #include "storage.h"
 #include "attrib-server.h"
 
-- 
1.8.3.1

