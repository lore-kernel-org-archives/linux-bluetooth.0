Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] TODO: Fix GATT over BR/EDR
Date: Tue,  1 Mar 2011 10:28:19 -0300
Message-Id: <1298986099-4720-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---

 Needs to be applied after: "[PATCH 4/4] TODO: Add item to implement device
 type in the DeviceFound signal"

 TODO |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/TODO b/TODO
index 4e3585e..1c22c86 100644
--- a/TODO
+++ b/TODO
@@ -120,9 +120,12 @@ Low Energy
 ATT/GATT
 ========
 
-- For BR/EDR, Discover All Primary Services shall be started after SDP if the
-  remote device exports a Generic Attribute Profile service record. It is
-  applied to CreateDevice and CreatePairedDevice.
+- For BR/EDR, primary services can be registered based on the information
+  extracted from the service records. UUIDs, start and end handles information
+  are available in the record, Discover All Primary Services procedure is not
+  necessary. If a GATT service doesn't export a service record means that
+  it should not be used over BR/EDR. Don't start this task before to move the
+  attribute client code to the bluetoothd core.
 
   Priority: Medium
   Complexity: C1
-- 
1.7.4.1

