Return-Path: <noring@nocrew.org>
Subject: [PATCH] Updated man page for hcid
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-o+XiVszNw3DKDuH/hqTq"
Date: Sat, 17 Sep 2005 21:44:28 +0200
Message-Id: <1126986268.14893.32.camel@yeti>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>


--=-o+XiVszNw3DKDuH/hqTq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Marcel,

Attached is a patch to update the man page for hcid.

Will the documentation for the new D-BUS features go in here as well?

Fredrik


--=-o+XiVszNw3DKDuH/hqTq
Content-Disposition: attachment; filename=hcid.8-updates.patch
Content-Type: text/x-patch; name=hcid.8-updates.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- bluez-utils-2.21.orig/hcid/hcid.8	2004-03-24 17:54:41.000000000 +0100
+++ bluez-utils-2.21.new/hcid/hcid.8	2005-09-17 21:35:28.000000000 +0200
@@ -21,6 +21,9 @@
 configuration is done in the 
 .B hcid.conf
 file, which has its own man page.
+.B hcid
+can also provide a number of services via the D-BUS message bus
+system.
 .SH "OPTIONS"
 .TP 
 .B \-n
@@ -33,7 +36,57 @@
 .I /etc/bluetooth/hcid.conf
 Default location of the global configuration file.
 
+.TP 
+.I /var/lib/bluetooth/nn:nn:nn:nn:nn:nn/linkkeys
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
+.I /var/lib/bluetooth/nn:nn:nn:nn:nn:nn/names
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
+.I /var/lib/bluetooth/nn:nn:nn:nn:nn:nn/features
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
+.I /var/lib/bluetooth/nn:nn:nn:nn:nn:nn/manufacturers
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
 .SH "SEE ALSO"
 \fBhcid.conf\fR(5)
 .SH "AUTHOR"
-This manual page was written by Philipp Matthias Hahn.
+This manual page was written by Philipp Matthias Hahn and Fredrik Noring.

--=-o+XiVszNw3DKDuH/hqTq--
