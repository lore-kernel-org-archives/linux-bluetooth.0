Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] sdptool: Clarify 'add' and 'remove' commands in manual
Date: Tue, 24 Sep 2013 09:09:08 +0200
Message-Id: <1380006548-5011-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adapters are no longer notified about external changes in SDP
database. This results in 'add' and 'remove' commands being
usefull only for SDP testing or qualification.
---
 tools/sdptool.1 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/sdptool.1 b/tools/sdptool.1
index 88ad818..ea95933 100644
--- a/tools/sdptool.1
+++ b/tools/sdptool.1
@@ -91,9 +91,15 @@ the \fB--handle\fP option.
 .IP "" 10
 You can specify a channel to add the service on
 using the \fB--channel\fP option.
+.IP "" 10
+NOTE: Local adapters configuration will not be updated and this command should
+be used only for SDP testing.
 .IP "\fBdel record_handle\fP" 10
 Remove a service from the local
 SDP database.
+.IP "" 10
+NOTE: Local adapters configuration will not be updated and this command should
+be used only for SDP testing.
 .IP "\fBget [--tree] [--raw] [--xml] [--bdaddr bdaddr] record_handle\fP" 10
 Retrieve a service from the local
 SDP database.
-- 
1.8.4

