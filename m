Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] TODO: Attribute server should process queued commands at disconnection
Date: Wed,  6 Oct 2010 18:00:05 -0300
Message-Id: <1286398805-12542-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 59a20d3..a9f1339 100644
--- a/TODO
+++ b/TODO
@@ -42,6 +42,15 @@ ATT/GATT
   Priority: Low
   Complexity: C2
 
+- Attribute server should process queued GATT/ATT commands if the
+  client disconnects. The client can simply send a command and quit,
+  without wait for a response(ex: Write Command). For this scenario
+  that the client disconnects the link quickly the queued received
+  command is ignored.
+
+  Priority: Low
+  Complecity: C1
+
 - Long reads/writes don't work (consisting of multiple request packets)
 
   Priority: Low
-- 
1.7.3.1

