Return-Path: <cyrus@holtmann.org>
From: Tom Gundersen <teg@jklm.no>
To: linux-bluetooth@vger.kernel.org
Cc: Tom Gundersen <teg@jklm.no>
Subject: [PATCH 2/2] udev: remove udev activation of the blutooth daemon
Date: Fri,  4 May 2012 00:21:53 +0200
Message-Id: <1336083713-8417-2-git-send-email-teg@jklm.no>
In-Reply-To: <1336083713-8417-1-git-send-email-teg@jklm.no>
References: <1336083713-8417-1-git-send-email-teg@jklm.no>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Udev is not meant to spawn long-running processes, and as of the next udev
version such processes will be killed.

If using systemd, device activation can be used to get the same effect.

On Arch we have been disabling this rule for a long time, even though we
don't use systemd, as it was causing more problems than it was worth.

Signed-off-by: Tom Gundersen <teg@jklm.no>
---
 Makefile.am                |    5 ++---
 configure.ac               |    3 +--
 scripts/bluetooth.rules.in |    4 ----
 3 files changed, 3 insertions(+), 9 deletions(-)
 delete mode 100644 scripts/bluetooth.rules.in

diff --git a/Makefile.am b/Makefile.am
index 62705f6..44e82c0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -389,7 +389,7 @@ include Makefile.tools
 if DATAFILES
 rulesdir = @UDEV_DIR@/rules.d
 
-udev_files = scripts/bluetooth.rules
+udev_files =
 
 if HID2HCI
 udev_files += scripts/bluetooth-hid2hci.rules
@@ -408,8 +408,7 @@ endif
 
 CLEANFILES += $(rules_DATA)
 
-EXTRA_DIST += scripts/bluetooth.rules \
-		scripts/bluetooth-hid2hci.rules scripts/bluetooth-serial.rules
+EXTRA_DIST += scripts/bluetooth-hid2hci.rules scripts/bluetooth-serial.rules
 
 EXTRA_DIST += doc/manager-api.txt \
 		doc/adapter-api.txt doc/device-api.txt \
diff --git a/configure.ac b/configure.ac
index f298909..44f33ad 100644
--- a/configure.ac
+++ b/configure.ac
@@ -71,5 +71,4 @@ if (test -n "${path_systemdunit}"); then
 fi
 AM_CONDITIONAL(SYSTEMD, test -n "${path_systemdunit}")
 
-AC_OUTPUT(Makefile scripts/bluetooth.rules doc/version.xml
-			src/bluetoothd.8 src/bluetooth.service bluez.pc)
+AC_OUTPUT(Makefile doc/version.xml src/bluetoothd.8 src/bluetooth.service bluez.pc)
diff --git a/scripts/bluetooth.rules.in b/scripts/bluetooth.rules.in
deleted file mode 100644
index 64df69d..0000000
--- a/scripts/bluetooth.rules.in
+++ /dev/null
@@ -1,4 +0,0 @@
-# Run helper every time a Bluetooth device appears
-# On remove actions, bluetoothd should go away by itself
-ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="@prefix@/sbin/bluetoothd --udev"
-ACTION=="change", SUBSYSTEM=="bluetooth", RUN+="@prefix@/sbin/bluetoothd --udev"
-- 
1.7.10.1

