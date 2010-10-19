Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] TODO: Define Auto Connection Establishment Procedure
Date: Tue, 19 Oct 2010 19:27:12 -0200
Message-Id: <1287523632-5966-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1287523632-5966-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1287523632-5966-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 948d4d0..c0a25f1 100644
--- a/TODO
+++ b/TODO
@@ -40,6 +40,20 @@ Low Energy
   Priority: Medium
   Complexity: C2
 
+- Define Auto Connection Establishment Procedure. Some profiles such as
+  Proximity requires an active link to identify path lost situation. It is
+  necessary to define how to manage connections, it seems that White List
+  is appropriated to address auto connections, however is not clear if the
+  this procedure shall be a profile specific detail or if the remote device
+  object can expose a property "WhiteList", maybe "Trusted" property can be
+  also used for this purpose. Another alternative is to define a method to
+  allow application to request/register the wanted scanning/connection
+  parameters. Before start this task, a RFC/PATCH shall be sent to the ML.
+  See Volume 3, Part C, section 9.3.5 for more information.
+
+  Priority: Medium
+  Complexity: C2
+
 - Device Name Characteristic is a GAP characteristic for Low Energy. This
   characteristic shall be integrated/used in the discovery procedure. The
   ideia is to report the value of this characteristic using DeviceFound signals.
-- 
1.7.3.1

