Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] use CONFIGDIR and STORAGEDIR in src/bluetoothd.8
Date: Sun, 21 Jun 2009 17:01:23 +0200
Message-Id: <1245596485-11771-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

also export CONFIGDIR and STORAGEDIR with AC_SUBST
---
 .topdeps            |    1 +
 .topmsg             |    5 +++
 acinclude.m4        |    4 ++
 configure.ac        |    1 +
 src/bluetoothd.8    |   91 ---------------------------------------------------
 src/bluetoothd.8.in |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 102 insertions(+), 91 deletions(-)
 create mode 100644 .topdeps
 create mode 100644 .topmsg
 delete mode 100644 src/bluetoothd.8
 create mode 100644 src/bluetoothd.8.in

diff --git a/.topdeps b/.topdeps
new file mode 100644
index 0000000..1f7391f
--- /dev/null
+++ b/.topdeps
@@ -0,0 +1 @@
+master
diff --git a/.topmsg b/.topmsg
new file mode 100644
index 0000000..5092c31
--- /dev/null
+++ b/.topmsg
@@ -0,0 +1,5 @@
+From: Filippo Giunchedi <filippo@esaurito.net>
+Subject: [PATCH] use of configure variables in manpages
+
+This patch expands CONFIGDIR and STORAGEDIR in src/bluetoothd.8 and
+src/hcid.conf.5
diff --git a/acinclude.m4 b/acinclude.m4
index eb7cdeb..4d52f3e 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -107,6 +107,10 @@ AC_DEFUN([AC_INIT_BLUEZ], [
 				[Directory for the configuration files])
 	AC_DEFINE_UNQUOTED(STORAGEDIR, "${storagedir}",
 				[Directory for the storage files])
+
+	AC_SUBST(CONFIGDIR, "${configdir}")
+	AC_SUBST(STORAGEDIR, "${storagedir}")
+
 ])
 
 AC_DEFUN([AC_PATH_DBUS], [
diff --git a/configure.ac b/configure.ac
index da930e5..e355833 100644
--- a/configure.ac
+++ b/configure.ac
@@ -64,4 +64,5 @@ AC_OUTPUT([
 	doc/Makefile
 	doc/version.xml
 	bluez.pc
+	src/bluetoothd.8
 ])
diff --git a/src/bluetoothd.8 b/src/bluetoothd.8
deleted file mode 100644
index 28c0398..0000000
--- a/src/bluetoothd.8
+++ /dev/null
@@ -1,91 +0,0 @@
-.\" 
-.TH "BLUETOOTHD" "8" "March 2004" "Bluetooth daemon" "System management commands"
-.SH "NAME"
-bluetoothd \- Bluetooth daemon
-
-.SH "SYNOPSIS"
-.B bluetoothd
-[
-.B \-n
-]
-
-.SH "DESCRIPTION"
-This manual page documents briefly the
-.B bluetoothd
-daemon, which manages all the Bluetooth devices. 
-.B bluetoothd
-itself does not accept many command\-line options, as most of its
-configuration is done in the 
-.B /etc/bluetooth/main.conf
-file, which has its own man page.
-.B bluetoothd
-can also provide a number of services via the D-Bus message bus
-system.
-.SH "OPTIONS"
-.TP 
-.BI \-n
-Don't run as daemon in background.
-.TP
-.BI \-d
-Enable debug information output.
-.TP
-.BI \-m\ mtu\-size
-Use specific MTU size for SDP server.
-
-.SH "FILES"
-.TP 
-.I /etc/bluetooth/main.conf
-Default location of the global configuration file.
-
-.TP 
-.I /var/lib/bluetooth/nn:nn:nn:nn:nn:nn/linkkeys
-Default location for link keys of paired devices. The directory
-\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP
-is the address of the local device. The file is line separated, with
-the following columns separated by whitespace:
-
-\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP Remote device address.
-
-\fInnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn\fP Link key.
-
-\fIn\fP Link type integer.
-
-.TP 
-.I /var/lib/bluetooth/nn:nn:nn:nn:nn:nn/names
-Default location for the device name cache. The directory
-\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP
-is the address of the local device. The file is line separated, with
-the following columns separated by whitespace:
-
-\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP Remote device address.
-
-\fIname\fP Remote device name, terminated with newline.
-
-.TP 
-.I /var/lib/bluetooth/nn:nn:nn:nn:nn:nn/features
-Default location for the features cache. The directory
-\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP
-is the address of the local device. The file is line separated, with
-the following columns separated by whitespace:
-
-\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP Remote device address.
-
-\fInnnnnnnnnnnnnnnn\fP Remote device LMP features coded as an 8 byte bitfield.
-
-.TP 
-.I /var/lib/bluetooth/nn:nn:nn:nn:nn:nn/manufacturers
-Default location for the manufacturers cache. The directory
-\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP
-is the address of the local device. The file is line separated, with
-the following columns separated by whitespace:
-
-\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP Remote device address.
-
-\fIn\fP Remote device manufacturer integer.
-
-\fIn\fP Remote device LMP version integer.
-
-\fIn\fP Remote device LMP sub-version integer.
-
-.SH "AUTHOR"
-This manual page was written by Marcel Holtmann, Philipp Matthias Hahn and Fredrik Noring.
diff --git a/src/bluetoothd.8.in b/src/bluetoothd.8.in
new file mode 100644
index 0000000..ce03b84
--- /dev/null
+++ b/src/bluetoothd.8.in
@@ -0,0 +1,91 @@
+.\" 
+.TH "BLUETOOTHD" "8" "March 2004" "Bluetooth daemon" "System management commands"
+.SH "NAME"
+bluetoothd \- Bluetooth daemon
+
+.SH "SYNOPSIS"
+.B bluetoothd
+[
+.B \-n
+]
+
+.SH "DESCRIPTION"
+This manual page documents briefly the
+.B bluetoothd
+daemon, which manages all the Bluetooth devices. 
+.B bluetoothd
+itself does not accept many command\-line options, as most of its
+configuration is done in the 
+.B @CONFIGDIR@/main.conf
+file, which has its own man page.
+.B bluetoothd
+can also provide a number of services via the D-Bus message bus
+system.
+.SH "OPTIONS"
+.TP 
+.BI \-n
+Don't run as daemon in background.
+.TP
+.BI \-d
+Enable debug information output.
+.TP
+.BI \-m\ mtu\-size
+Use specific MTU size for SDP server.
+
+.SH "FILES"
+.TP 
+.I @CONFIGDIR@/main.conf
+Default location of the global configuration file.
+
+.TP 
+.I @STORAGEDIR@/nn:nn:nn:nn:nn:nn/linkkeys
+Default location for link keys of paired devices. The directory
+\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP
+is the address of the local device. The file is line separated, with
+the following columns separated by whitespace:
+
+\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP Remote device address.
+
+\fInnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn\fP Link key.
+
+\fIn\fP Link type integer.
+
+.TP 
+.I @STORAGEDIR@/nn:nn:nn:nn:nn:nn/names
+Default location for the device name cache. The directory
+\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP
+is the address of the local device. The file is line separated, with
+the following columns separated by whitespace:
+
+\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP Remote device address.
+
+\fIname\fP Remote device name, terminated with newline.
+
+.TP 
+.I @STORAGEDIR@/nn:nn:nn:nn:nn:nn/features
+Default location for the features cache. The directory
+\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP
+is the address of the local device. The file is line separated, with
+the following columns separated by whitespace:
+
+\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP Remote device address.
+
+\fInnnnnnnnnnnnnnnn\fP Remote device LMP features coded as an 8 byte bitfield.
+
+.TP 
+.I @STORAGEDIR@/nn:nn:nn:nn:nn:nn/manufacturers
+Default location for the manufacturers cache. The directory
+\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP
+is the address of the local device. The file is line separated, with
+the following columns separated by whitespace:
+
+\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP Remote device address.
+
+\fIn\fP Remote device manufacturer integer.
+
+\fIn\fP Remote device LMP version integer.
+
+\fIn\fP Remote device LMP sub-version integer.
+
+.SH "AUTHOR"
+This manual page was written by Marcel Holtmann, Philipp Matthias Hahn and Fredrik Noring.
-- 
1.6.3.1

