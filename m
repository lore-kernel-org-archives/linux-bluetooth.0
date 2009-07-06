Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] add test/hciemu.1 manpage
Date: Mon,  6 Jul 2009 18:05:04 +0200
Message-Id: <1246896305-26018-2-git-send-email-filippo@esaurito.net>
In-Reply-To: <1246890054-13479-2-git-send-email-filippo@esaurito.net>
References: <1246890054-13479-2-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/hciemu.1 |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 test/hciemu.1

diff --git a/test/hciemu.1 b/test/hciemu.1
new file mode 100644
index 0000000..cecaeb7
--- /dev/null
+++ b/test/hciemu.1
@@ -0,0 +1,31 @@
+.TH HCIEMU 1 "Jul 6 2009" BlueZ ""
+.SH NAME
+hciemu \- HCI emulator
+.SH SYNOPSIS
+.B hciemu
+[\fIoptions\fR] \fIlocal_address\fR
+
+.SH DESCRIPTION
+.LP
+.B
+hciemu
+is used to emulate an HCI via \fBhci_vhci\fR kernel module
+
+.SH OPTIONS
+.TP
+.BI -d\  device
+use specified \fIdevice\fR
+.TP
+.BI -b\  bdaddr
+emulate \fIbdaddr\fR
+.TP
+.BI -s\  file
+create snoop file \fIfile\fR
+.TP
+.B -n
+do not detach
+
+.SH AUTHORS
+Written by Marcel Holtmann <marcel@holtmann.org> and Maxim Krasnyansky
+<maxk@qualcomm.com>, man page by Filippo Giunchedi <filippo@debian.org>
+.PP
-- 
1.6.3.3

