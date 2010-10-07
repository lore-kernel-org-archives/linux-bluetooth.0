Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Sort TODO by priority
Date: Thu,  7 Oct 2010 19:21:55 +0300
Message-Id: <1286468515-20738-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Items shall be sorted by priority and latter by complexity so that tasks
with higher priority and lower complexity always appear on top.
---
 TODO |   58 +++++++++++++++++++++++++++++-----------------------------
 1 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/TODO b/TODO
index 271fc45..3885c78 100644
--- a/TODO
+++ b/TODO
@@ -25,6 +25,29 @@ ATT/GATT
   Complexity: C2
   Owner: Claudio Takahasi <claudio.takahasi@openbossa.org>
 
+- Add ATT/GATT parsing to hcidump
+
+  Priority: Medium
+  Complexity: C2
+
+- GATT server: fix MTU exchange
+
+  Priority: Medium
+  Complexity: C2
+
+- GATT server: fix read by UUID (read by handle works)
+
+  Priority: Medium
+  Complexity: C2
+
+- gatttool: add an interactive command prompt mode. Many LE devices
+  expect the connection to stay up a long time and disable advertising
+  after a disconnection so it's inconvenient to use gatttool in the
+  current "single operation at a time" mode.
+
+  Priority: Medium
+  Complexity: C2
+
 - gatttool should have the ability to wait for req responses before
   quitting (some servers require a small sleep even with cmd's). Maybe a
   --delay-exit or --timeout command line switch.
@@ -42,13 +65,6 @@ ATT/GATT
   Priority: Low
   Complexity: C1
 
-- Attribute server shall implement attribute permission verification,
-  returning an error code if necessary. See Volume 3, Part F, 3.2.5
-  for more information.
-
-  Priority: Low
-  Complexity: C2
-
 - Attribute server should process queued GATT/ATT commands if the
   client disconnects. The client can simply send a command and quit,
   without wait for a response(ex: Write Command). For this scenario
@@ -58,11 +74,6 @@ ATT/GATT
   Priority: Low
   Complecity: C1
 
-- Long reads/writes don't work (consisting of multiple request packets)
-
-  Priority: Low
-  Complexity: C2
-
 - Add sdp discovery support to gattool with BR (--sdp, default is 0x1f)
 
   Priority: Low
@@ -74,25 +85,14 @@ ATT/GATT
   Priority: Low
   Complexity: C1
 
-- Add ATT/GATT parsing to hcidump
-
-  Priority: Medium
-  Complexity: C2
-
-- GATT server: fix MTU exchange
-
-  Priority: Medium
-  Complexity: C2
-
-- GATT server: fix read by UUID (read by handle works)
+- Long reads/writes don't work (consisting of multiple request packets)
 
-  Priority: Medium
+  Priority: Low
   Complexity: C2
 
-- gatttool: add an interactive command prompt mode. Many LE devices
-  expect the connection to stay up a long time and disable advertising
-  after a disconnection so it's inconvenient to use gatttool in the
-  current "single operation at a time" mode.
+- Attribute server shall implement attribute permission verification,
+  returning an error code if necessary. See Volume 3, Part F, 3.2.5
+  for more information.
 
-  Priority: Medium
+  Priority: Low
   Complexity: C2
-- 
1.7.1

