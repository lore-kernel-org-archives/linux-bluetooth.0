Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] TODO: Device Name Characteristic for Low Energy
Date: Wed, 13 Oct 2010 14:44:27 -0300
Message-Id: <1286991867-26866-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 0a7b482..2c17c6b 100644
--- a/TODO
+++ b/TODO
@@ -14,6 +14,20 @@ Background
   Higher complexity tasks should be refined into several lower complexity tasks
   once the task is better understood.
 
+LE Generic Access Profile
+=========================
+
+- Device Name Characteristic is a GAP characteristic for Low Energy. This
+  characteristic shall be integrated/used in the discovery procedure. The
+  ideia is to report the value of this characteristic using DeviceFound signals.
+  Discussion with the community is needed before to start this task. Other GAP
+  characteristics for LE needs to follow a similar approach. It is not clear
+  if all GAP characteristics can be exposed using properties instead of a primary
+  service characteristics.
+  See Volume 3, Part C, section 12.1 for more information.
+
+  Priority: Low
+  Complexity: C2
 
 ATT/GATT
 ========
-- 
1.7.3.1

