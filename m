Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 3/3] doc/mgmt-api: Add advertising phys support to flags
Date: Tue, 14 Nov 2017 16:02:18 +0530
Message-Id: <1510655538-12883-5-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1510655538-12883-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1510655538-12883-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Technically it is possible to advertise on LE Coded in Primary
and LE 1M/2M in secondary, but that is not added in the interface
since advertising in Coded means that scanners are expected to be
in long range and then advertising in other phys in secondary
does not make sense.
---
 doc/mgmt-api.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 25739cc..fe1c0a5 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2613,6 +2613,8 @@ Add Advertising Command
 		4	Add TX Power field to Adv_Data
 		5	Add Appearance field to Scan_Rsp
 		6	Add Local Name in Scan_Rsp
+		7 	Advertise in Coded PHY
+		8	Advertise in 2M PHY
 
 	When the connectable flag is set, then the controller will use
 	undirected connectable advertising. The value of the connectable
@@ -2640,6 +2642,16 @@ Add Advertising Command
 	supported to provide less air traffic for devices implementing
 	broadcaster role.
 
+	Advertising PHY flags should be used only if the controller
+	supports the corresponding phy which can be retrieved using
+	Get Supported Phys command otherwise Invalid Parameter would
+	be returned. If none of the flags are set and if controller
+	supports extended advertising then 1M would be used for both
+	Primary and Secondary channel. If 2M is set then 1M
+	would be selected for primary and 2M for secondary channel.
+	If Coded is set then it would be used for both primary
+	and secondary channels.
+
 	The Duration parameter configures the length of an Instance. The
 	value is in seconds.
 
-- 
2.7.4

