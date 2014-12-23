Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android: Provide SELinux policy files
Date: Tue, 23 Dec 2014 12:48:23 +0100
Message-Id: <1419335303-3982-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds required policy files and updates documentation with more
SELinux information.
---
 android/README              |  7 ++++++-
 android/bluetoothd.te       | 47 +++++++++++++++++++++++++++++++++++++++++++++
 android/bluetoothd_snoop.te | 17 ++++++++++++++++
 3 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 android/bluetoothd.te
 create mode 100644 android/bluetoothd_snoop.te

diff --git a/android/README b/android/README
index b2864de..7b1f126 100644
--- a/android/README
+++ b/android/README
@@ -57,7 +57,9 @@ Since 5.0 release Android moved to full enforcement of SELinux. This requires
 proper policy to be provided for all BlueZ for Android services (and services
 interacting with BlueZ). Policies should be placed in external/selinux/ path.
 
-Required policy files are provided at <TBD>.
+Required policy files are provided at:
+bluetoothd.te
+bluetoothd_snoop.te
 
 For convenience sepolicy.git with all required policies is available at:
 https://code.google.com/p/aosp-bluez.external-sepolicy/
@@ -176,6 +178,9 @@ will break at e.g. g_free() function without prior callers. It's possible to
 have proper library installed automatically by appropriate entry in Android.mk,
 see https://code.google.com/p/aosp-bluez.glib/ for an example.
 
+When running with valgrind SElinux needs to be set into permissive mode. This
+can be done by executing 'setenforce 0' from root shell.
+
 
 Enabling BlueZ debugs
 ---------------------
diff --git a/android/bluetoothd.te b/android/bluetoothd.te
new file mode 100644
index 0000000..532bfbb
--- /dev/null
+++ b/android/bluetoothd.te
@@ -0,0 +1,47 @@
+type bluetoothd, domain;
+type bluetoothd_exec, exec_type, file_type;
+type bluetoothd_main_exec, exec_type, file_type;
+
+# Start bluetoothd from init
+init_daemon_domain(bluetoothd)
+
+# Data file accesses
+allow bluetoothd bluetooth_data_file:dir w_dir_perms;
+allow bluetoothd bluetooth_data_file:notdevfile_class_set create_file_perms;
+
+allow bluetoothd self:capability { setuid net_admin net_bind_service net_raw };
+allow bluetoothd kernel:system module_request;
+
+# TODO: this may be romoved for userbuild where we don't use bluetoothd_wrapper
+allow bluetoothd bluetoothd_main_exec:file { execute execute_no_trans read open };
+
+# IPC socket communication
+allow bluetoothd self:socket { create_socket_perms accept listen setopt getopt };
+
+# Allow clients to use a socket provided by the bluetooth app.
+allow bluetoothd { bluetooth mediaserver }:unix_stream_socket connectto;
+
+# Allow system app to use sockets and fds
+allow bluetooth bluetoothd:fd use;
+allow bluetooth bluetoothd:unix_stream_socket rw_socket_perms;
+
+# Allow user bluetooth apps to use sockets and fds
+allow bluetoothdomain bluetoothd:fd use;
+allow bluetoothdomain bluetoothd:unix_stream_socket { getopt setopt getattr read write ioctl shutdown };
+
+# Other domains that can create and use bluetooth sockets.
+allow bluetoothdomain self:socket create_socket_perms;
+
+#This we might should put to mediaserver.te ?
+allow mediaserver bluetoothd:fd use;
+allow mediaserver bluetoothd:socket rw_socket_perms;
+
+# needs /system/bin/log access
+allow bluetoothd devpts:chr_file rw_file_perms;
+
+# access to uhid device
+allow bluetoothd uhid_device:chr_file rw_file_perms;
+
+# tethering
+allow bluetoothd self:udp_socket create_socket_perms;
+allow bluetoothd self:tcp_socket { create ioctl };
diff --git a/android/bluetoothd_snoop.te b/android/bluetoothd_snoop.te
new file mode 100644
index 0000000..ef817b5
--- /dev/null
+++ b/android/bluetoothd_snoop.te
@@ -0,0 +1,17 @@
+type bluetoothd_snoop, domain;
+type bluetoothd_snoop_exec, exec_type, file_type;
+
+# Start bluetoothd_snoop from init
+init_daemon_domain(bluetoothd_snoop)
+
+# directory search and read caps
+allow bluetoothd_snoop self:capability dac_read_search;
+# use raw and packet sockets caps
+allow bluetoothd_snoop self:capability net_raw;
+
+# monitor socket access
+allow bluetoothd_snoop self:socket { create bind setopt read };
+
+# sdcard access
+allow bluetoothd_snoop fuse:dir w_dir_perms;
+allow bluetoothd_snoop fuse:file create_file_perms;
-- 
1.9.3

