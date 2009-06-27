Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] use CONFIGDIR and STORAGEDIR in src/bluetoothd.8
Date: Sat, 27 Jun 2009 17:01:38 +0200
Message-Id: <1246114900-14482-2-git-send-email-filippo@esaurito.net>
In-Reply-To: <1246114900-14482-1-git-send-email-filippo@esaurito.net>
References: <1246114900-14482-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 configure.ac        |    1 +
 src/bluetoothd.8    |   91 ---------------------------------------------------
 src/bluetoothd.8.in |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 91 deletions(-)
 delete mode 100644 src/bluetoothd.8
 create mode 100644 src/bluetoothd.8.in

diff --git a/configure.ac b/configure.ac
index 412fa22..7acad12 100644
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

