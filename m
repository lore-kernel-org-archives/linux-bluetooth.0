Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ] lib: Add new company identifiers
Date: Mon, 30 Jul 2012 14:41:20 -0400
Message-Id: <1343673680-30775-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index a0be884..d092d01 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -522,6 +522,46 @@ char *bt_compidtostr(int compid)
 		return "Autonet Mobile";
 	case 128:
 		return "DeLorme Publishing Company, Inc.";
+	case 129:
+		return "WuXi Vimicro";
+	case 130:
+		return "Sennheiser Communications A/S";
+	case 131:
+		return "TimeKeeping Systems, Inc.";
+	case 132:
+		return "Ludus Helsinki Ltd.";
+	case 133:
+		return "BlueRadios, Inc.";
+	case 134:
+		return "equinux AG";
+	case 135:
+		return "Garmin International, Inc.";
+	case 136:
+		return "Ecotest";
+	case 137:
+		return "GN ReSound A/S";
+	case 138:
+		return "Jawbone";
+	case 139:
+		return "Topcon Positioning Systems, LLC";
+	case 140:
+		return "Qualcomm Labs, Inc.";
+	case 141:
+		return "Zscan Software";
+	case 142:
+		return "Quintic Corp.";
+	case 143:
+		return "Stollmann E+V GmbH";
+	case 144:
+		return "Funai Electric Co., Ltd.";
+	case 145:
+		return "Advanced PANMOBIL systems GmbH & Co. KG";
+	case 146:
+		return "ThinkOptics, Inc.";
+	case 147:
+		return "Universal Electronics, Inc.";
+	case 148:
+		return "Airoha Technology Corp.";
 	case 65535:
 		return "internal use";
 	default:
-- 
1.7.11.3

