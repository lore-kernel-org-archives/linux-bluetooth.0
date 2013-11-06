Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/daemon: Move include mgmt.h to adapter.h
Date: Wed,  6 Nov 2013 16:03:32 +0200
Message-Id: <1383746614-15077-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383746614-15077-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383746614-15077-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Without including src/shared/mgmt.h adapter.h cannot be included.
This force some profiles which do not use mgmt interface to include
src/shared/mgmt.h like hid.c and socket.c
---
 android/adapter.c |    1 -
 android/adapter.h |    1 +
 android/hid.c     |    1 -
 android/main.c    |    1 -
 4 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index cf5edcd..db70b46 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -32,7 +32,6 @@
 #include "lib/bluetooth.h"
 #include "lib/sdp.h"
 #include "lib/mgmt.h"
-#include "src/shared/mgmt.h"
 #include "src/glib-helper.h"
 #include "src/eir.h"
 #include "lib/sdp.h"
diff --git a/android/adapter.h b/android/adapter.h
index 2afc67a..eca77ae 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -27,6 +27,7 @@
 #include <glib.h>
 
 #include "lib/bluetooth.h"
+#include "src/shared/mgmt.h"
 
 typedef void (*bt_adapter_ready)(int err);
 
diff --git a/android/hid.c b/android/hid.c
index c38c4c1..2ef2733 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -38,7 +38,6 @@
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
 #include "lib/uuid.h"
-#include "src/shared/mgmt.h"
 #include "src/sdp-client.h"
 #include "src/glib-helper.h"
 #include "profiles/input/uhid_copy.h"
diff --git a/android/main.c b/android/main.c
index 75004cf..80d7c24 100644
--- a/android/main.c
+++ b/android/main.c
@@ -46,7 +46,6 @@
 
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
-#include "src/shared/mgmt.h"
 
 #include "adapter.h"
 #include "socket.h"
-- 
1.7.10.4

