Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 5/5] TODO: Start Discover All Primary Services after SDP if necessary
Date: Mon,  3 Jan 2011 18:45:54 -0300
Message-Id: <1294091154-7367-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1294091154-7367-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1294091154-7367-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 9c5389c..1357db9 100644
--- a/TODO
+++ b/TODO
@@ -80,6 +80,13 @@ Low Energy
 ATT/GATT
 ========
 
+- For BR/EDR, Discover All Primary Services shall be started after SDP if the
+  remote device exports a Generic Attribute Profile service record. It is
+  applied to CreateDevice and CreatePairedDevice.
+
+  Priority: Medium
+  Complexity: C1
+
 - Add ATT/GATT parsing to hcidump
 
   Priority: Medium
-- 
1.7.3.4

