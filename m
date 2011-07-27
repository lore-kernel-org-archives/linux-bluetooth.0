Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/2] Remove unneeded header includes in event.c
Date: Wed, 27 Jul 2011 10:32:06 -0300
Message-Id: <1311773526-15856-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1311773526-15856-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1311773526-15856-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/event.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/src/event.c b/src/event.c
index 52b4a9d..92a73b4 100644
--- a/src/event.c
+++ b/src/event.c
@@ -33,16 +33,11 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/param.h>
-#include <sys/ioctl.h>
-#include <sys/socket.h>
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
-#include <gdbus.h>
 
 #include "log.h"
 
@@ -50,13 +45,10 @@
 #include "manager.h"
 #include "device.h"
 #include "error.h"
-#include "glib-helper.h"
 #include "dbus-common.h"
 #include "agent.h"
 #include "storage.h"
 #include "event.h"
-#include "sdpd.h"
-#include "eir.h"
 
 static gboolean get_adapter_and_device(bdaddr_t *src, bdaddr_t *dst,
 					struct btd_adapter **adapter,
-- 
1.7.6

