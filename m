Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/pics: Add PTS PICS for DID
Date: Fri, 22 Nov 2013 11:47:40 +0100
Message-Id: <1385117261-25270-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1385117261-25270-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1385117261-25270-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS PICS for DID, targeting Android 4.4.

---
 android/pics-did.txt | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 android/pics-did.txt

diff --git a/android/pics-did.txt b/android/pics-did.txt
new file mode 100644
index 0000000..8f92bc1
--- /dev/null
+++ b/android/pics-did.txt
@@ -0,0 +1,31 @@
+DID PICS for the PTS tool.
+
+* - different than PTS defaults
+# - not yet implemented/supported
+
+M - mandatory
+O - optional
+
+		Version
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_DID_0_1	False		Device ID 1.2 (C.1)
+TSPC_DID_0_2	True		Device ID 1.3 (C.1)
+-------------------------------------------------------------------------------
+C.1: It is mandatory to support one of the profile versions.
+-------------------------------------------------------------------------------
+
+
+		SDP Requirements
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_DID_1_1	True		Specification ID (M)
+TSPC_DID_1_2	True		Vendor ID (M)
+TSPC_DID_1_3	True		Product ID (M)
+TSPC_DID_1_4	True		Version (M)
+TSPC_DID_1_5	True		Primary Record (M)
+TSPC_DID_1_6	True		Vendor ID Source (M)
+TSPC_ALL	False		Turns on all the test cases
+-------------------------------------------------------------------------------
-- 
1.8.4.1

