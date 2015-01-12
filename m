Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/4] tools/hcitool: Update manual page
Date: Mon, 12 Jan 2015 17:19:40 +0100
Message-Id: <1421079580-26470-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1421079580-26470-1-git-send-email-szymon.janc@tieto.com>
References: <1421079580-26470-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This updates hcitool manual with new options.
---

Should be enhanced with options description but it is still better
than nothing :)

 tools/hcitool.1 | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/hcitool.1 b/tools/hcitool.1
index 85498dc..7d06556 100644
--- a/tools/hcitool.1
+++ b/tools/hcitool.1
@@ -203,6 +203,52 @@ The clock can be
 for the local clock or
 .BR 1
 for the piconet clock (which is default).
+.TP
+.BI lescan " [--privacy] [--passive] [--whitelist] [--discovery=g|l] \
+[--duplicates]"
+Start LE scan
+.TP
+.BI leinfo " [--static] [--random] <bdaddr>"
+Get LE remote information
+.TP
+.BI lewladd " [--random] <bdaddr>"
+Add device to LE White List
+.TP
+.BI lewlrm " <bdaddr>"
+Remove device from LE White List
+.TP
+.BI lewlsz
+Read size of LE White List
+.TP
+.BI lewlclr
+Clear LE White List
+.TP
+.BI lerladd " [--local irk] [--peer irk] [--random] <bdaddr>"
+Add device to LE Resolving List
+.TP
+.BI lerlrm " <bdaddr>"
+Remove device from LE Resolving List
+.TP
+.BI lerlclr
+Clear LE Resolving List
+.TP
+.BI lerlsz
+Read size of LE Resolving List
+.TP
+.BI lerlon
+Enable LE Address Resolution
+.TP
+.BI lerloff
+Disable LE Address Resolution
+.TP
+.BI lecc " [--static] [--random] <bdaddr> | [--whitelist]"
+Create a LE Connection
+.TP
+.BI ledc " <handle> [reason]"
+Disconnect a LE Connection
+.TP
+.BI lecup " <handle> <min> <max> <latency> <timeout>"
+LE Connection Update
 .SH AUTHORS
 Written by Maxim Krasnyansky <maxk@qualcomm.com> and Marcel Holtmann <marcel@holtmann.org>
 .PP
-- 
1.9.1

