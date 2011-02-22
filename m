Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/7] TODO: Add item for privacy feature in the central
Date: Tue, 22 Feb 2011 17:43:06 -0300
Message-Id: <1298407391-19260-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298407391-19260-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298407391-19260-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 3617777..5ee892c 100644
--- a/TODO
+++ b/TODO
@@ -65,6 +65,13 @@ Low Energy
   Priority: Medium
   Complexity: C2
 
+- Privacy: When privacy is enabled in the adapter, LE scanning/connection
+  should use a private address. StartDiscovery method shall be changed and
+  new adapter property shall be added.
+
+  Priority: Medium
+  Complexity: C1
+
 - Device Name Characteristic is a GAP characteristic for Low Energy. This
   characteristic shall be integrated/used in the discovery procedure. The
   ideia is to report the value of this characteristic using DeviceFound signals.
-- 
1.7.4.1

