Return-Path: <john@metanate.com>
From: John Keeping <john@metanate.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	John Keeping <john@metanate.com>
Subject: [PATCH 1/2] tools/btattach: add manual page
Date: Wed,  2 Dec 2015 10:34:59 +0000
Message-Id: <1449052500-10755-2-git-send-email-john@metanate.com>
In-Reply-To: <1449052500-10755-1-git-send-email-john@metanate.com>
References: <1449052500-10755-1-git-send-email-john@metanate.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btattach.1 | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 tools/btattach.1

diff --git a/tools/btattach.1 b/tools/btattach.1
new file mode 100644
index 0000000..ffd653d
--- /dev/null
+++ b/tools/btattach.1
@@ -0,0 +1,53 @@
+.TH "btattach" "1" "November 2015" "BlueZ" "Linux System Administration"
+.SH NAME
+btattach \- attach serial devices to BlueZ stack
+
+.SH SYNOPSIS
+.B btattach
+.RB [\| \-B
+.IR device \|]
+.RB [\| \-A
+.IR device \|]
+.RB [\| \-P
+.IR protocol \|]
+.RB [\| \-R \|]
+
+.SH DESCRIPTION
+.LP
+btattach is used to attach a serial UART to the Bluetooth stack as a
+transport interface.
+
+.SH OPTIONS
+.TP
+.BI \-B " device" , " " \--bredr " device"
+Attach a BR/EDR controller.
+.TP
+.BI \-A " device" , " " \--amp " device"
+Attach an AMP controller.
+.TP
+.BI \-P " protocol" , " " \--protocol " protocol"
+Specify the protocol type for talking to the device.
+Supported values are:
+.RS
+.IP \(bu 2
+.B h4
+.IP \(bu 2
+.B bcsp
+.IP \(bu 2
+.B 3wire
+.IP \(bu 2
+.B h4ds
+.IP \(bu 2
+.B ll
+.IP \(bu 2
+.B ath3k
+.IP \(bu 2
+.B intel
+.IP \(bu 2
+.B bcm
+.IP \(bu 2
+.B qca
+.RE
+.TP
+.B \-R
+Set the device into raw mode (the kernel and bluetoothd will ignore it).
-- 
2.6.3.462.gbe2c914
