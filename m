Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/2] TODO: Trivial typo fixes
Date: Tue, 13 Nov 2012 11:49:46 -0400
Message-Id: <1352821786-20230-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1352821786-20230-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1352821786-20230-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/TODO b/TODO
index 4f58423..ad3232b 100644
--- a/TODO
+++ b/TODO
@@ -24,7 +24,7 @@ General
   Priority: high
   Complexity: C4
 
-- Rename glib-helper file to a more convenient name. The ideia is try to keep
+- Rename glib-helper file to a more convenient name. The idea is try to keep
   only sdp helpers functions. bt_* prefix shall be also changed.
 
   Priority: Low
@@ -48,7 +48,7 @@ General
 BlueZ 5
 =======
 
-Priority/Complexity ommited as all items are required before 5.0 is
+Priority/Complexity omitted as all items are required before 5.0 is
 released.
 
 - Remove telephony driver framework and replace with a org.bluez.Profile
@@ -163,7 +163,7 @@ Low Energy
   Complexity: C1
 
 - Static random address setup and storage. Once this address is written
-  in the a given remote, the address can not be changed anymore.
+  in a given remote, the address can not be changed anymore.
 
   Priority: Low
   Complexity: C1
@@ -178,7 +178,7 @@ Low Energy
 
 - Device Name Characteristic is a GAP characteristic for Low Energy. This
   characteristic shall be integrated/used in the discovery procedure. The
-  ideia is to report the value of this characteristic using DeviceFound signals.
+  idea is to report the value of this characteristic using DeviceFound signals.
   Discussion with the community is needed before to start this task. Other GAP
   characteristics for LE needs to follow a similar approach. It is not clear
   if all GAP characteristics can be exposed using properties instead of a primary
@@ -268,7 +268,7 @@ ATT/GATT
   Priority: Low
   Complecity: C1
 
-- Add sdp discovery support to gattool with BR (--sdp, default is 0x1f)
+- Add sdp discovery support to gatttool with BR (--sdp, default is 0x1f)
 
   Priority: Low
   Complexity: C1
-- 
1.7.9.5

