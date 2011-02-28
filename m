Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 4/4] TODO: Add item to implement device type in the DeviceFound signal
Date: Mon, 28 Feb 2011 10:44:13 -0300
Message-Id: <1298900653-7567-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298900653-7567-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298900653-7567-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 9f899b0..4e3585e 100644
--- a/TODO
+++ b/TODO
@@ -78,6 +78,12 @@ Low Energy
   Priority: Medium
   Complexity: C2
 
+- Add new property in the DeviceFound signal to report the device type:
+  BR/EDR, single mode or dual-mode.
+
+  Priority: Medium
+  Complexity: C1
+
 - Privacy: When privacy is enabled in the adapter, LE scanning/connection
   should use a private address. StartDiscovery method shall be changed and
   new adapter property shall be added.
-- 
1.7.4.1

