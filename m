Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/2] Remove unneeded textfile header includes
Date: Wed, 27 Jul 2011 10:32:05 -0300
Message-Id: <1311773526-15856-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/device.c   |    1 -
 audio/manager.c  |    1 -
 input/device.c   |    1 -
 serial/manager.c |    1 -
 serial/proxy.c   |    1 -
 src/event.c      |    1 -
 6 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/audio/device.c b/audio/device.c
index e38e598..18e873e 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -42,7 +42,6 @@
 #include <gdbus.h>
 
 #include "log.h"
-#include "textfile.h"
 #include "../src/adapter.h"
 #include "../src/device.h"
 
diff --git a/audio/manager.c b/audio/manager.c
index 911af45..05ca654 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -53,7 +53,6 @@
 #include "../src/device.h"
 
 #include "log.h"
-#include "textfile.h"
 #include "ipc.h"
 #include "device.h"
 #include "error.h"
diff --git a/input/device.c b/input/device.c
index aa593e0..70d0ba2 100644
--- a/input/device.c
+++ b/input/device.c
@@ -43,7 +43,6 @@
 #include <gdbus.h>
 
 #include "log.h"
-#include "textfile.h"
 #include "uinput.h"
 
 #include "../src/adapter.h"
diff --git a/serial/manager.c b/serial/manager.c
index eba8a91..e97f1a9 100644
--- a/serial/manager.c
+++ b/serial/manager.c
@@ -54,7 +54,6 @@
 #include "device.h"
 
 #include "log.h"
-#include "textfile.h"
 
 #include "error.h"
 #include "port.h"
diff --git a/serial/proxy.c b/serial/proxy.c
index f9aa41b..371ad5f 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -53,7 +53,6 @@
 #include "../src/adapter.h"
 
 #include "log.h"
-#include "textfile.h"
 
 #include "error.h"
 #include "sdpd.h"
diff --git a/src/event.c b/src/event.c
index 95e47f2..52b4a9d 100644
--- a/src/event.c
+++ b/src/event.c
@@ -45,7 +45,6 @@
 #include <gdbus.h>
 
 #include "log.h"
-#include "textfile.h"
 
 #include "adapter.h"
 #include "manager.h"
-- 
1.7.6

