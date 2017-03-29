Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Seulki Shin <sskcorea@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Seulki Shin <sskcorea@gmail.com>
Subject: [PATCH] lib: Add company names and identifiers upto 1190
Date: Wed, 29 Mar 2017 11:25:57 +0900
Message-Id: <20170329022557.7056-1-sskcorea@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds company names with reference to Bluetooth SIG's assigned
numbers
---
 lib/bluetooth.c | 306 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 306 insertions(+)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index 3276b68a5..f6ebe84d6 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -2337,6 +2337,312 @@ const char *bt_compidtostr(int compid)
 		return "Senix Corporation";
 	case 1037:
 		return "NorthStar Battery Company, LLC";
+	case 1038:
+		return "SKF (U.K.) Limited";
+	case 1039:
+		return "CO-AX Technology, Inc.";
+	case 1040:
+		return "Fender Musical Instruments";
+	case 1041:
+		return "Luidia Inc";
+	case 1042:
+		return "SEFAM";
+	case 1043:
+		return "Wireless Cables Inc";
+	case 1044:
+		return "Lightning Protection International Pty Ltd";
+	case 1045:
+		return "Uber Technologies Inc";
+	case 1046:
+		return "SODA GmbH";
+	case 1047:
+		return "Fatigue Science";
+	case 1048:
+		return "Alpine Electronics Inc.";
+	case 1049:
+		return "Novalogy LTD";
+	case 1050:
+		return "Friday Labs Limited";
+	case 1051:
+		return "OrthoAccel Technologies";
+	case 1052:
+		return "WaterGuru, Inc.";
+	case 1053:
+		return "Benning Elektrotechnik und Elektronik GmbH & Co. KG";
+	case 1054:
+		return "Dell Computer Corporation";
+	case 1055:
+		return "Kopin Corporation";
+	case 1056:
+		return "TecBakery GmbH";
+	case 1057:
+		return "Backbone Labs, Inc.";
+	case 1058:
+		return "DELSEY SA";
+	case 1059:
+		return "Chargifi Limited";
+	case 1060:
+		return "Trainesense Ltd.";
+	case 1061:
+		return "Unify Software and Solutions GmbH & Co. KG";
+	case 1062:
+		return "Husqvarna AB";
+	case 1063:
+		return "Focus fleet and fuel management inc";
+	case 1064:
+		return "SmallLoop, LLC";
+	case 1065:
+		return "Prolon Inc.";
+	case 1066:
+		return "BD Medical";
+	case 1067:
+		return "iMicroMed Incorporated";
+	case 1068:
+		return "Ticto N.V.";
+	case 1069:
+		return "Meshtech AS";
+	case 1070:
+		return "MemCachier Inc.";
+	case 1071:
+		return "Danfoss A/S";
+	case 1072:
+		return "SnapStyk Inc.";
+	case 1073:
+		return "Amway Corporation";
+	case 1074:
+		return "Silk Labs, Inc.";
+	case 1075:
+		return "Pillsy Inc.";
+	case 1076:
+		return "Hatch Baby, Inc.";
+	case 1077:
+		return "Blocks Wearables Ltd.";
+	case 1078:
+		return "Drayson Technologies (Europe) Limited";
+	case 1079:
+		return "eBest IOT Inc.";
+	case 1080:
+		return "Helvar Ltd";
+	case 1081:
+		return "Radiance Technologies";
+	case 1082:
+		return "Nuheara Limited";
+	case 1083:
+		return "Appside co., ltd.";
+	case 1084:
+		return "DeLaval";
+	case 1085:
+		return "Coiler Corporation";
+	case 1086:
+		return "Thermomedics, Inc.";
+	case 1087:
+		return "Tentacle Sync GmbH";
+	case 1088:
+		return "Valencell, Inc.";
+	case 1089:
+		return "iProtoXi Oy";
+	case 1090:
+		return "SECOM CO., LTD.";
+	case 1091:
+		return "Tucker International LLC";
+	case 1092:
+		return "Metanate Limited";
+	case 1093:
+		return "Kobian Canada Inc.";
+	case 1094:
+		return "NETGEAR, Inc.";
+	case 1095:
+		return "Fabtronics Australia Pty Ltd";
+	case 1096:
+		return "Grand Centrix GmbH";
+	case 1097:
+		return "1UP USA.com llc";
+	case 1098:
+		return "SHIMANO INC.";
+	case 1099:
+		return "Nain Inc.";
+	case 1100:
+		return "LifeStyle Lock, LLC";
+	case 1101:
+		return "VEGA Grieshaber KG";
+	case 1102:
+		return "Xtrava Inc.";
+	case 1103:
+		return "TTS Tooltechnic Systems AG & Co. KG";
+	case 1104:
+		return "Teenage Engineering AB";
+	case 1105:
+		return "Tunstall Nordic AB";
+	case 1106:
+		return "Svep Design Center AB";
+	case 1107:
+		return "GreenPeak Technologies BV";
+	case 1108:
+		return "Sphinx Electronics GmbH & Co KG";
+	case 1109:
+		return "Atomation";
+	case 1110:
+		return "Nemik Consulting Inc";
+	case 1111:
+		return "RF INNOVATION";
+	case 1112:
+		return "Mini Solution Co., Ltd.";
+	case 1113:
+		return "Lumenetix, Inc";
+	case 1114:
+		return "2048450 Ontario Inc";
+	case 1115:
+		return "SPACEEK LTD";
+	case 1116:
+		return "Delta T Corporation";
+	case 1117:
+		return "Boston Scientific Corporation";
+	case 1118:
+		return "Nuviz, Inc.";
+	case 1119:
+		return "Real Time Automation, Inc.";
+	case 1120:
+		return "Kolibree";
+	case 1121:
+		return "vhf elektronik GmbH";
+	case 1122:
+		return "Bonsai Systems GmbH";
+	case 1123:
+		return "Fathom Systems Inc.";
+	case 1124:
+		return "Bellman & Symfon";
+	case 1125:
+		return "International Forte Group LLC";
+	case 1126:
+		return "CycleLabs Solutions inc.";
+	case 1127:
+		return "Codenex Oy";
+	case 1128:
+		return "Kynesim Ltd";
+	case 1129:
+		return "Palago AB";
+	case 1130:
+		return "INSIGMA INC.";
+	case 1131:
+		return "PMD Solutions";
+	case 1132:
+		return "Qingdao Realtime Technology Co., Ltd.";
+	case 1133:
+		return "BEGA Gantenbrink-Leuchten KG";
+	case 1134:
+		return "Pambor Ltd.";
+	case 1135:
+		return "Develco Products A/S";
+	case 1136:
+		return "iDesign s.r.l.";
+	case 1137:
+		return "TiVo Corp";
+	case 1138:
+		return "Control-J Pty Ltd";
+	case 1139:
+		return "Steelcase, Inc.";
+	case 1140:
+		return "iApartment co., ltd.";
+	case 1141:
+		return "Icom inc.";
+	case 1142:
+		return "Oxstren Wearable Technologies Private Limited";
+	case 1143:
+		return "Blue Spark Technologies";
+	case 1144:
+		return "FarSite Communications Limited";
+	case 1145:
+		return "mywerk system GmbH";
+	case 1146:
+		return "Sinosun Technology Co., Ltd.";
+	case 1147:
+		return "MIYOSHI ELECTRONICS CORPORATION";
+	case 1148:
+		return "POWERMAT LTD";
+	case 1149:
+		return "Occly LLC";
+	case 1150:
+		return "OurHub Dev IvS";
+	case 1151:
+		return "Pro-Mark, Inc.";
+	case 1152:
+		return "Dynometrics Inc.";
+	case 1153:
+		return "Quintrax Limited";
+	case 1154:
+		return "POS Tuning Udo Vosshenrich GmbH & Co. KG";
+	case 1155:
+		return "Multi Care Systems B.V.";
+	case 1156:
+		return "Revol Technologies Inc";
+	case 1157:
+		return "SKIDATA AG";
+	case 1158:
+		return "DEV TECNOLOGIA INDUSTRIA, COMERCIO E MANUTENCAO DE EQUIPAMENTOS LTDA. - ME";
+	case 1159:
+		return "Centrica Connected Home";
+	case 1160:
+		return "Automotive Data Solutions Inc";
+	case 1161:
+		return "Igarashi Engineering";
+	case 1162:
+		return "Taelek Oy";
+	case 1163:
+		return "CP Electronics Limited";
+	case 1164:
+		return "Vectronix AG";
+	case 1165:
+		return "S-Labs Sp. z o.o.";
+	case 1166:
+		return "Companion Medical, Inc.";
+	case 1167:
+		return "BlueKitchen GmbH";
+	case 1168:
+		return "Matting AB";
+	case 1169:
+		return "SOREX - Wireless Solutions GmbH";
+	case 1170:
+		return "ADC Technology, Inc.";
+	case 1171:
+		return "Lynxemi Pte Ltd";
+	case 1172:
+		return "SENNHEISER electronic GmbH & Co. KG";
+	case 1173:
+		return "LMT Mercer Group, Inc";
+	case 1174:
+		return "Polymorphic Labs LLC";
+	case 1175:
+		return "Cochlear Limited";
+	case 1176:
+		return "METER Group, Inc. USA";
+	case 1177:
+		return "Ruuvi Innovations Ltd.";
+	case 1178:
+		return "Situne AS";
+	case 1179:
+		return "nVisti, LLC";
+	case 1180:
+		return "DyOcean";
+	case 1181:
+		return "Uhlmann & Zacher GmbH";
+	case 1182:
+		return "AND!XOR LLC";
+	case 1183:
+		return "tictote AB";
+	case 1184:
+		return "Vypin, LLC";
+	case 1185:
+		return "PNI Sensor Corporation";
+	case 1186:
+		return "ovrEngineered, LLC";
+	case 1187:
+		return "GTronix";
+	case 1188:
+		return "Herbert Waldmann GmbH & Co. KG";
+	case 1189:
+		return "Guangzhou FiiO Electronics Technology Co.,Ltd";
+	case 1190:
+		return "Vinetech Co., Ltd";
 	case 65535:
 		return "internal use";
 	default:
-- 
2.11.1.windows.1

