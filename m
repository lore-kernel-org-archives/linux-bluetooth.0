Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] TODO: Export Client Characteristic Configuration as a property
Date: Wed,  6 Oct 2010 17:43:23 -0300
Message-Id: <1286397803-12433-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 6722af7..59a20d3 100644
--- a/TODO
+++ b/TODO
@@ -25,6 +25,16 @@ ATT/GATT
   Priority: Low
   Complexity: C1
 
+- Client needs to export a property in the Device Characteristic hierarchy
+  to manage characteristic value changes reports in the remote device.
+  Currently, Client Characteristic Configuration attribute is not exposed
+  as an object. The user needs to use gatttool to change the value of the
+  this attribute to receive notification/indications. Export this attribute
+  as a property is a proposal that needs further discussion.
+
+  Priority: Low
+  Complexity: C1
+
 - Attribute server shall implement attribute permission verification,
   returning an error code if necessary. See Volume 3, Part F, 3.2.5
   for more information.
-- 
1.7.3.1

