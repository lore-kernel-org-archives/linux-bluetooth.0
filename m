Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 6/7] TODO: Add item for reconnection address
Date: Tue, 22 Feb 2011 17:43:10 -0300
Message-Id: <1298407391-19260-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298407391-19260-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298407391-19260-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index b5e4d09..c53339b 100644
--- a/TODO
+++ b/TODO
@@ -78,6 +78,14 @@ Low Energy
   Priority: Low
   Complexity: C1
 
+- Reconnection address: Reconnection address is a non resolvable private
+  address that the central writes in the peripheral. BlueZ will support
+  multiple profiles, it is not clear how it needs to be implemented.
+  Further discussion is necessary.
+
+  Priority: Low
+  Complexity: C2
+
 - Device Name Characteristic is a GAP characteristic for Low Energy. This
   characteristic shall be integrated/used in the discovery procedure. The
   ideia is to report the value of this characteristic using DeviceFound signals.
-- 
1.7.4.1

