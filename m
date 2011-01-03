Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/5] TODO: Setup advertising parameters and data
Date: Mon,  3 Jan 2011 18:45:50 -0300
Message-Id: <1294091154-7367-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 54fef16..6c5c58d 100644
--- a/TODO
+++ b/TODO
@@ -54,6 +54,17 @@ Low Energy
   Priority: Medium
   Complexity: C2
 
+- Implement a tool(or extend hciconfig) to setup the advertising parameters
+  and data. Extend hciconfig passing extra arguments when enabling the
+  advertises is not the right approach, it will be almost impossible to
+  address all arguments needed in an acceptable way. For testing, we need
+  a tool to change easily the AD Flags, the UUIDs and other data that can be
+  exported through the advertising data field. Suggestions: 1) extend hciconfig
+  passing a config file when enabling advertises; 2) write a ncurses based tool
+
+  Priority: Medium
+  Complexity: C2
+
 - Device Name Characteristic is a GAP characteristic for Low Energy. This
   characteristic shall be integrated/used in the discovery procedure. The
   ideia is to report the value of this characteristic using DeviceFound signals.
-- 
1.7.3.4

