Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 7/7] TODO: Add new shared/gatt TODO items.
Date: Sun, 26 Oct 2014 14:12:47 -0700
Message-Id: <1414357967-9371-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1414357967-9371-1-git-send-email-armansito@chromium.org>
References: <1414357967-9371-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added items for adding packed structs for ATT PDUs and improving unit test
coverage.
---
 TODO | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/TODO b/TODO
index fe5ebe5..b5a9612 100644
--- a/TODO
+++ b/TODO
@@ -105,6 +105,21 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C1
 
+- Add complete GATT test coverage in unit/test-gatt following the GATT test
+  spec. This could use shared/gatt-client and shared/gatt-server at the same
+  time to test both against eachother. We should definitely have tests for
+  gatt-server and gatt-client simultaneously on one side of the connection.
+
+  Priority: High
+  Complexity: C4
+
+- Define packed structs for ATT protocol PDUs in shared/att-types to improve
+  readability. We should probably do this once there are extensive unit tests
+  for gatt-client/gatt-server so that we don't accidentally break working code.
+
+  Priority: Medium
+  Complexity: C2
+
 - Introduce a handler interface to shared/gatt-client which can be used by the
   upper layer to determine when the link has been disconnected or an ATT
   protocol request times out.
-- 
2.1.0.rc2.206.gedb03e5

