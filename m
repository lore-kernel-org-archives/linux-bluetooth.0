Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 4/5] TODO: Refactoring of gatt.c functions
Date: Mon,  3 Jan 2011 18:45:53 -0300
Message-Id: <1294091154-7367-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1294091154-7367-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1294091154-7367-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 319bdf5..9c5389c 100644
--- a/TODO
+++ b/TODO
@@ -105,6 +105,17 @@ ATT/GATT
   Priority: Low
   Complexity: C1
 
+- Refactoring of gatt.c functions. Currently, the callbacks of the services
+  and characteristics discovery functions return the ATT PDU and the caller
+  needs to call again the same function to fetch the remaining data when
+  necessary. Investigate if all results can be returned in the callback
+  result to avoid repeated code. Before change the code, please analyze
+  if this change will not break the GATT/ATT qualification tests. Maybe
+  an interactive fetch/query is necessary to pass the tests.
+
+  Priority: Low
+  Complexity: C1
+
 - Client needs to export a property in the Device Characteristic hierarchy
   to manage characteristic value changes reports in the remote device.
   Currently, Client Characteristic Configuration attribute is not exposed
-- 
1.7.3.4

