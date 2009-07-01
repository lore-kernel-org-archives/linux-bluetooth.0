Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] move tools/l2ping.1 to man section 8
Date: Wed,  1 Jul 2009 12:58:45 +0200
Message-Id: <1246445925-14815-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

usually only root is able to invoke l2ping thus move to man section 8
---
 tools/Makefile.am |    2 +-
 tools/l2ping.1    |   76 -----------------------------------------------------
 tools/l2ping.8    |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 77 deletions(-)
 delete mode 100644 tools/l2ping.1
 create mode 100644 tools/l2ping.8

diff --git a/tools/Makefile.am b/tools/Makefile.am
index 6b0ad49..ee4c6b3 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -1,7 +1,7 @@
 
 if TOOLS
 tools_programs = hcitool l2ping sdptool ciptool
-tools_manfiles = hcitool.1 l2ping.1 sdptool.1 ciptool.1
+tools_manfiles = hcitool.1 l2ping.8 sdptool.1 ciptool.1
 else
 tools_programs =
 tools_manfiles =
diff --git a/tools/l2ping.1 b/tools/l2ping.1
deleted file mode 100644
index 4d09b05..0000000
--- a/tools/l2ping.1
+++ /dev/null
@@ -1,76 +0,0 @@
-.TH L2PING 1 "Jan 22 2002" BlueZ "Linux System Administration"
-.SH NAME
-l2ping \- Send L2CAP echo request and receive answer
-.SH SYNOPSIS
-.B l2ping
-.RB [\| \-i
-.IR <hciX> \|]
-.RB [\| \-s
-.IR size \|]
-.RB [\| \-c
-.IR count \|]
-.RB [\| \-t
-.IR timeout \|]
-.RB [\| \-d
-.IR delay \|]
-.RB [\| \-f \|]
-.RB [\| \-r \|]
-.RB [\| \-v \|]
-.I bd_addr
-
-.SH DESCRIPTION
-.LP
-L2ping sends a L2CAP echo request to the Bluetooth MAC address
-.I bd_addr
-given in dotted hex notation.
-.SH OPTIONS
-.TP
-.BI \-i " <hciX>"
-The command is applied to device
-.BI
-hciX
-, which must be the name of an installed Bluetooth device (X = 0, 1, 2, ...)
-If not specified, the command will be sent to the first available Bluetooth
-device.
-.TP
-.BI \-s " size"
-The
-.I size
-of the data packets to be sent.
-.TP
-.BI \-c " count"
-Send
-.I count
-number of packets then exit.
-.TP
-.BI \-t " timeout"
-Wait
-.I timeout
-seconds for the response.
-.TP
-.BI \-d " delay"
-Wait
-.I delay
-seconds between pings.
-.TP
-.B \-f
-Kind of flood ping. Use with care! It reduces the delay time between packets
-to 0.
-.TP
-.B \-r
-Reverse ping (gnip?). Send echo response instead of echo request.
-.TP
-.B \-v
-Verify response payload is identical to request payload. It is not required for
-remote stacks to return the request payload, but most stacks do (including
-Bluez).
-.TP
-.I bd_addr
-The Bluetooth MAC address to be pinged in dotted hex notation like
-.B 01:02:03:ab:cd:ef
-or
-.B 01:EF:cd:aB:02:03
-.SH AUTHORS
-Written by Maxim Krasnyansky <maxk@qualcomm.com> and Marcel Holtmann <marcel@holtmann.org>
-.PP
-man page by Nils Faerber <nils@kernelconcepts.de>, Adam Laurie <adam@algroup.co.uk>.
diff --git a/tools/l2ping.8 b/tools/l2ping.8
new file mode 100644
index 0000000..8b77ee2
--- /dev/null
+++ b/tools/l2ping.8
@@ -0,0 +1,76 @@
+.TH L2PING 8 "Jan 22 2002" BlueZ "Linux System Administration"
+.SH NAME
+l2ping \- Send L2CAP echo request and receive answer
+.SH SYNOPSIS
+.B l2ping
+.RB [\| \-i
+.IR <hciX> \|]
+.RB [\| \-s
+.IR size \|]
+.RB [\| \-c
+.IR count \|]
+.RB [\| \-t
+.IR timeout \|]
+.RB [\| \-d
+.IR delay \|]
+.RB [\| \-f \|]
+.RB [\| \-r \|]
+.RB [\| \-v \|]
+.I bd_addr
+
+.SH DESCRIPTION
+.LP
+L2ping sends a L2CAP echo request to the Bluetooth MAC address
+.I bd_addr
+given in dotted hex notation.
+.SH OPTIONS
+.TP
+.BI \-i " <hciX>"
+The command is applied to device
+.BI
+hciX
+, which must be the name of an installed Bluetooth device (X = 0, 1, 2, ...)
+If not specified, the command will be sent to the first available Bluetooth
+device.
+.TP
+.BI \-s " size"
+The
+.I size
+of the data packets to be sent.
+.TP
+.BI \-c " count"
+Send
+.I count
+number of packets then exit.
+.TP
+.BI \-t " timeout"
+Wait
+.I timeout
+seconds for the response.
+.TP
+.BI \-d " delay"
+Wait
+.I delay
+seconds between pings.
+.TP
+.B \-f
+Kind of flood ping. Use with care! It reduces the delay time between packets
+to 0.
+.TP
+.B \-r
+Reverse ping (gnip?). Send echo response instead of echo request.
+.TP
+.B \-v
+Verify response payload is identical to request payload. It is not required for
+remote stacks to return the request payload, but most stacks do (including
+Bluez).
+.TP
+.I bd_addr
+The Bluetooth MAC address to be pinged in dotted hex notation like
+.B 01:02:03:ab:cd:ef
+or
+.B 01:EF:cd:aB:02:03
+.SH AUTHORS
+Written by Maxim Krasnyansky <maxk@qualcomm.com> and Marcel Holtmann <marcel@holtmann.org>
+.PP
+man page by Nils Faerber <nils@kernelconcepts.de>, Adam Laurie <adam@algroup.co.uk>.
-- 
1.6.3.3

