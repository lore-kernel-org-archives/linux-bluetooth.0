Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org, connman@lists.01.org
Cc: Grant Erickson <marathon96@gmail.com>
Subject: [PATCH] gdbus: Move typedefs for interwork with strict compilers
Date: Tue,  8 Dec 2015 18:09:02 +0200
Message-Id: <1449590942-19235-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grant Erickson <marathon96@gmail.com>

Move enumeration type defintions AFTER the enumerations themselves are declared
and defined such that the header works with strict compilers.

This occurs when building a plugin, compiled with C++, and occurs on all of:

arm-none-linux-gnueabi-g++ (Sourcery G++ Lite 2010q1-202) 4.4.1
arm-poky-linux-gnueabi-g++ (GCC) 4.8.2
g++ (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4
---

	Hi,

This patch came up on the ConnMan mailing list, applies to Bluez too.

The patch is rebased to latest upstream and commit message amended with
more information.

Cheers,

	Patrik
	

 gdbus/gdbus.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 9ece4b0..69fbc10 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -31,12 +31,6 @@ extern "C" {
 #include <dbus/dbus.h>
 #include <glib.h>
 
-typedef enum GDBusMethodFlags GDBusMethodFlags;
-typedef enum GDBusSignalFlags GDBusSignalFlags;
-typedef enum GDBusPropertyFlags GDBusPropertyFlags;
-typedef enum GDBusSecurityFlags GDBusSecurityFlags;
-typedef enum GDbusPropertyChangedFlags GDbusPropertyChangedFlags;
-
 typedef struct GDBusArgInfo GDBusArgInfo;
 typedef struct GDBusMethodTable GDBusMethodTable;
 typedef struct GDBusSignalTable GDBusSignalTable;
@@ -120,6 +114,12 @@ enum GDbusPropertyChangedFlags {
 	G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH = (1 << 0),
 };
 
+typedef enum GDBusMethodFlags GDBusMethodFlags;
+typedef enum GDBusSignalFlags GDBusSignalFlags;
+typedef enum GDBusPropertyFlags GDBusPropertyFlags;
+typedef enum GDBusSecurityFlags GDBusSecurityFlags;
+typedef enum GDbusPropertyChangedFlags GDbusPropertyChangedFlags;
+
 struct GDBusArgInfo {
 	const char *name;
 	const char *signature;
-- 
2.1.4

