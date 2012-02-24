Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mgmt-api: Format fixes
Date: Fri, 24 Feb 2012 11:06:11 +0200
Message-Id: <1330074371-11018-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/mgmt-api.txt |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 6bf18d7..635c552 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -347,7 +347,6 @@ Add UUID Command
 				SVC_Hint (1 Octet)
 	Return Parameters:	Class_Of_Device (3 Octets)
 
-	
 	This command can be used when the controller is not powered and
 	all settings will be programmed once powered.
 
@@ -544,7 +543,6 @@ Pair Device Command
 Cancel Pair Device
 ==================
 
-
 	Command Code:		0x001A
 	Controller Index:	<controller id>
 	Command Parameters:	Address (6 Octets)
@@ -841,6 +839,7 @@ Controller Index:	<controller id> or <non-controller>
 Event Parameters	Command_Opcode (2 Octets)
 			Status (1 Octet)
 
+
 Controller Error Event
 ======================
 
-- 
1.7.7.6

