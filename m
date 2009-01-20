Return-Path: <cyrus@holtmann.org>
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Nick Pelly <npelly@google.com>
Subject: [PATCH] Update l2ping man page for recent changes to l2ping.
Date: Tue, 20 Jan 2009 12:51:22 -0800
Message-Id: <1232484682-7103-1-git-send-email-npelly@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/l2ping.1 |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/l2ping.1 b/tools/l2ping.1
index 8f56fb5..4d09b05 100644
--- a/tools/l2ping.1
+++ b/tools/l2ping.1
@@ -11,12 +11,11 @@ l2ping \- Send L2CAP echo request and receive answer
 .IR count \|]
 .RB [\| \-t
 .IR timeout \|]
+.RB [\| \-d
+.IR delay \|]
 .RB [\| \-f \|]
 .RB [\| \-r \|]
-.I bd_addr
-
-.SH DESCRIPTION
-.LP
+.RB [\| \-v \|]
 .I bd_addr
 
 .SH DESCRIPTION
@@ -49,6 +48,11 @@ Wait
 .I timeout
 seconds for the response.
 .TP
+.BI \-d " delay"
+Wait
+.I delay
+seconds between pings.
+.TP
 .B \-f
 Kind of flood ping. Use with care! It reduces the delay time between packets
 to 0.
@@ -56,6 +60,11 @@ to 0.
 .B \-r
 Reverse ping (gnip?). Send echo response instead of echo request.
 .TP
+.B \-v
+Verify response payload is identical to request payload. It is not required for
+remote stacks to return the request payload, but most stacks do (including
+Bluez).
+.TP
 .I bd_addr
 The Bluetooth MAC address to be pinged in dotted hex notation like
 .B 01:02:03:ab:cd:ef
-- 
1.6.0.1

