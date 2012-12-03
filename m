Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/3] input: Remove unneeded headers include
Date: Mon,  3 Dec 2012 13:41:19 -0300
Message-Id: <1354552880-31864-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1354552880-31864-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1354552880-31864-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/device.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index c2db6d1..1a33337 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -30,23 +30,21 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <sys/ioctl.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hidp.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
-#include <bluetooth/uuid.h>
 
 #include <gdbus.h>
 
 #include "log.h"
-#include "uinput.h"
 
 #include "../src/adapter.h"
 #include "../src/device.h"
 #include "../src/profile.h"
 #include "../src/storage.h"
-#include "../src/manager.h"
 #include "../src/dbus-common.h"
 
 #include "device.h"
-- 
1.7.11.7

