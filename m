Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/13] bluetoothd: Remove storage info from man page
Date: Mon, 17 Dec 2012 16:09:53 +0100
Message-Id: <1355756994-18953-12-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/bluetoothd.8.in |   50 --------------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/src/bluetoothd.8.in b/src/bluetoothd.8.in
index a7ae77b..a89f02c 100644
--- a/src/bluetoothd.8.in
+++ b/src/bluetoothd.8.in
@@ -37,55 +37,5 @@ Use specific MTU size for SDP server.
 .I @CONFIGDIR@/main.conf
 Default location of the global configuration file.
 
-.TP
-.I @STORAGEDIR@/nn:nn:nn:nn:nn:nn/linkkeys
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
-.I @STORAGEDIR@/nn:nn:nn:nn:nn:nn/names
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
-.I @STORAGEDIR@/nn:nn:nn:nn:nn:nn/features
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
-.I @STORAGEDIR@/nn:nn:nn:nn:nn:nn/manufacturers
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
 .SH "AUTHOR"
 This manual page was written by Marcel Holtmann, Philipp Matthias Hahn and Fredrik Noring.
-- 
1.7.9.5

