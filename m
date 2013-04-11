Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/2] lib: Fix list of company identifiers
Date: Thu, 11 Apr 2013 14:59:12 -0400
Message-Id: <1365706752-4442-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1365706752-4442-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1365706752-4442-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix minor typos on company names.
---
 lib/bluetooth.c |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index cc40ac5..80849b9 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -290,13 +290,13 @@ const char *bt_compidtostr(int compid)
 	case 13:
 		return "Texas Instruments Inc.";
 	case 14:
-		return "Ceva, Inc. (formerly Parthus Technologies Inc.)";
+		return "Ceva, Inc. (formerly Parthus Technologies, Inc.)";
 	case 15:
 		return "Broadcom Corporation";
 	case 16:
 		return "Mitel Semiconductor";
 	case 17:
-		return "Widcomm, Inc.";
+		return "Widcomm, Inc";
 	case 18:
 		return "Zeevo, Inc.";
 	case 19:
@@ -308,11 +308,11 @@ const char *bt_compidtostr(int compid)
 	case 22:
 		return "KC Technology Inc.";
 	case 23:
-		return "Newlogic";
+		return "NewLogic";
 	case 24:
 		return "Transilica, Inc.";
 	case 25:
-		return "Rohde & Schwartz GmbH & Co. KG";
+		return "Rohde & Schwarz GmbH & Co. KG";
 	case 26:
 		return "TTPCom Limited";
 	case 27:
@@ -360,7 +360,7 @@ const char *bt_compidtostr(int compid)
 	case 48:
 		return "ST Microelectronics";
 	case 49:
-		return "Synopsys";
+		return "Synopsis";
 	case 50:
 		return "Red-M (Communications) Ltd";
 	case 51:
@@ -386,13 +386,13 @@ const char *bt_compidtostr(int compid)
 	case 61:
 		return "IPextreme, Inc.";
 	case 62:
-		return "Systems and Chips, Inc";
+		return "Systems and Chips, Inc.";
 	case 63:
-		return "Bluetooth SIG, Inc";
+		return "Bluetooth SIG, Inc.";
 	case 64:
 		return "Seiko Epson Corporation";
 	case 65:
-		return "Integrated Silicon Solution Taiwain, Inc.";
+		return "Integrated Silicon Solution Taiwan, Inc.";
 	case 66:
 		return "CONWISE Technology Corporation Ltd";
 	case 67:
@@ -422,7 +422,7 @@ const char *bt_compidtostr(int compid)
 	case 79:
 		return "APT Licensing Ltd.";
 	case 80:
-		return "SiRF Technology, Inc.";
+		return "SiRF Technology";
 	case 81:
 		return "Tzero Technologies, Inc.";
 	case 82:
@@ -512,7 +512,7 @@ const char *bt_compidtostr(int compid)
 	case 124:
 		return "A & R Cambridge";
 	case 125:
-		return "Seers Technology Co. Ltd.";
+		return "Seers Technology Co. Ltd";
 	case 126:
 		return "Sports Tracking Technologies Ltd.";
 	case 127:
@@ -530,7 +530,7 @@ const char *bt_compidtostr(int compid)
 	case 133:
 		return "BlueRadios, Inc.";
 	case 134:
-		return "equinux AG";
+		return "equinox AG";
 	case 135:
 		return "Garmin International, Inc.";
 	case 136:
@@ -540,7 +540,7 @@ const char *bt_compidtostr(int compid)
 	case 138:
 		return "Jawbone";
 	case 139:
-		return "Topcon Positioning Systems, LLC";
+		return "Topcorn Positioning Systems, LLC";
 	case 140:
 		return "Qualcomm Labs, Inc.";
 	case 141:
@@ -548,11 +548,11 @@ const char *bt_compidtostr(int compid)
 	case 142:
 		return "Quintic Corp.";
 	case 143:
-		return "Stollmann E+V GmbH";
+		return "Stollman E+V GmbH";
 	case 144:
 		return "Funai Electric Co., Ltd.";
 	case 145:
-		return "Advanced PANMOBIL systems GmbH & Co. KG";
+		return "Advanced PANMOBIL Systems GmbH & Co. KG";
 	case 146:
 		return "ThinkOptics, Inc.";
 	case 147:
@@ -566,7 +566,7 @@ const char *bt_compidtostr(int compid)
 	case 151:
 		return "Bluetrek Technologies Limited";
 	case 152:
-		return "zero1.tv GmbH";
+		return "zer01.tv GmbH";
 	case 153:
 		return "i.Tech Dynamic Global Distribution Ltd.";
 	case 154:
@@ -600,7 +600,7 @@ const char *bt_compidtostr(int compid)
 	case 168:
 		return "ARP Devices Limited";
 	case 169:
-		return "Magneti Marelli S.p.A.";
+		return "Magneti Marelli S.p.A";
 	case 170:
 		return "CAEN RFID srl";
 	case 171:
@@ -638,7 +638,7 @@ const char *bt_compidtostr(int compid)
 	case 187:
 		return "S-Power Electronics Limited";
 	case 188:
-		return "Ace Sensor Inc.";
+		return "Ace Sensor Inc";
 	case 189:
 		return "Aplix Corporation";
 	case 190:
-- 
1.7.9.5

