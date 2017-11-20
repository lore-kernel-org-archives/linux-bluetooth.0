Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 3/3 v2] doc/mgmt-api: Add advertising phys support to flags
Date: Mon, 20 Nov 2017 15:56:57 +0530
Message-Id: <1511173617-25442-4-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index b59bf0c..c138f47 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2504,6 +2504,9 @@ Read Advertising Features Command
 		4	Add TX Power field to Adv_Data
 		5	Add Appearance field to Scan_Rsp
 		6	Add Local Name in Scan_Rsp
+		7	Secondary Channel with LE 1M
+		8	Secondary Channel with LE 2M
+		9	Secondary Channel with LE Coded
 
 	The Flags bit 0 indicates support for connectable advertising
 	and for switching to connectable advertising independent of the
@@ -2553,6 +2556,15 @@ Read Advertising Features Command
 	space is limited a short version or no name information. The
 	Local Name will be added at the end of the scan response data.
 
+	The Flags bit 7 indicates support for advertising in secondary
+	channel in LE 1M PHY.
+
+	The Flags bit 8 indicates support for advertising in secondary
+	channel in LE 2M PHY. Primary channel would be on 1M.
+
+	The Flags bit 9 indicates support for advertising in secondary
+	channel in LE CODED PHY.
+
 	The valid range for Instance identifiers is 1-254. The value 0
 	is reserved for internal use and the value 255 is reserved for
 	future extensions. However the Max_Instances value for indicating
@@ -2613,6 +2625,9 @@ Add Advertising Command
 		4	Add TX Power field to Adv_Data
 		5	Add Appearance field to Scan_Rsp
 		6	Add Local Name in Scan_Rsp
+		7	Secondary Channel with LE 1M
+		8	Secondary Channel with LE 2M
+		9	Secondary Channel with LE Coded
 
 	When the connectable flag is set, then the controller will use
 	undirected connectable advertising. The value of the connectable
@@ -2640,6 +2655,13 @@ Add Advertising Command
 	supported to provide less air traffic for devices implementing
 	broadcaster role.
 
+	Secondary channel flags can be used to advertise in secondary
+	channel with the corresponding PHYs. In case of 2M, the primary
+	channel used would be 1M. If none of them are set then secondary
+	channel advertising would be disabled for this instance which is as
+	good as legacy advertising. Combining the sets would result in
+	multiple advertising sets being created.
+
 	The Duration parameter configures the length of an Instance. The
 	value is in seconds.
 
-- 
2.7.4

