Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH v2 2/5] man: Update bluetoothd manual
Date: Fri, 31 May 2013 22:40:45 +0200
Message-Id: <1370032845-17123-1-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1369951317-16789-2-git-send-email-szymon.janc@gmail.com>
References: <1369951317-16789-2-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This puts manual up-to-date with bluetoothd options.
---

V2: Removed list-plugins option description

 src/bluetoothd.8.in |   45 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/src/bluetoothd.8.in b/src/bluetoothd.8.in
index 09f7f47..0bf3914 100644
--- a/src/bluetoothd.8.in
+++ b/src/bluetoothd.8.in
@@ -4,10 +4,9 @@
 bluetoothd \- Bluetooth daemon
 
 .SH "SYNOPSIS"
-.B bluetoothd
-[
-.B \-n
-]
+.B bluetoothd [--version] | [--help]
+
+.B bluetoothd [--nodetach] [--compat] [--experimental] [--debug=<files>] [--plugin=<plugins>] [--noplugin=<plugins>]
 
 .SH "DESCRIPTION"
 This manual page documents briefly the
@@ -18,19 +17,43 @@ can also provide a number of services via the D-Bus message bus
 system.
 .SH "OPTIONS"
 .TP
-.BI \-n
-Don't run as daemon in background.
+.B -v, --version
+Print bluetoothd version and exit.
 .TP
-.BI \-d
-Enable debug information output.
+.B -h, --help
+Print bluetoothd options and exit.
 .TP
-.BI \-m\ mtu\-size
-Use specific MTU size for SDP server.
+.B -n, --nodetach
+Enable logging in foreground. Directs log output to the controlling terminal \
+in addition to syslog.
+.TP
+.B -d, --debug=<file1>:<file2>:...
+Sets how much information bluetoothd sends to the log destination (usually \
+syslog's "daemon" facility). If the file options are omitted, then debugging \
+information from all the source files are printed. If file options are \
+present, then only debug prints from that source file are printed. The option \
+can be a pattern containing "*" and "?" characters.
 
+Example: --debug=src/adapter.c:src/agent.c
+.TP
+.B -p, --plugin=<plugin1>,<plugin2>,..
+Load these plugins only. The option can be a pattern containing "*" and "?" \
+characters.
+.TP
+.B -P, --noplugin=<plugin1>,<plugin2>,..
+Never load these plugins. The option can be a pattern containing "*" and "?" \
+characters.
+.TP
+.B -C, --compat
+Provide deprecated command line interfaces.
+.TP
+.B -E, -experimental
+Enable experimental interfaces. Those interfaces are not guaranteed to be
+compatible or present in future releases.
 .SH "FILES"
 .TP
 .I @CONFIGDIR@/main.conf
-Default location of the global configuration file.
+Location of the global configuration file.
 
 .SH "AUTHOR"
 This manual page was written by Marcel Holtmann, Philipp Matthias Hahn and Fredrik Noring.
-- 
1.7.10.4

