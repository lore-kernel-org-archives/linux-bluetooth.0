Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 12/62] Replace bt_get_le32() by get_le32()
Date: Thu, 20 Mar 2014 11:42:37 -0300
Message-Id: <1395326607-27068-13-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c |  3 ++-
 android/bluetooth.c      |  3 ++-
 monitor/control.c        |  2 +-
 monitor/l2cap.c          | 26 +++++++++++++-------------
 monitor/packet.c         | 16 ++++++++--------
 src/adapter.c            |  4 ++--
 src/eir.c                |  2 +-
 tools/btmgmt.c           | 10 +++++-----
 tools/l2test.c           |  2 +-
 tools/mgmt-tester.c      |  3 ++-
 tools/parser/l2cap.c     |  2 +-
 11 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index bab92a1..76dd0ea 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -30,6 +30,7 @@
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
 
+#include "src/shared/util.h"
 #include "src/shared/tester.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/hciemu.h"
@@ -281,7 +282,7 @@ static void command_generic_new_settings(uint16_t index, uint16_t length,
 		return;
 	}
 
-	settings = bt_get_le32(param);
+	settings = get_le32(param);
 
 	if ((settings & test_data->expect_settings_set) !=
 					test_data->expect_settings_set)
diff --git a/android/bluetooth.c b/android/bluetooth.c
index 1becdfb..4ad8298 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -37,6 +37,7 @@
 #include "lib/bluetooth.h"
 #include "lib/sdp.h"
 #include "lib/mgmt.h"
+#include "src/shared/util.h"
 #include "src/shared/mgmt.h"
 #include "src/uuid-helper.h"
 #include "src/eir.h"
@@ -539,7 +540,7 @@ static void new_settings_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	settings = bt_get_le32(param);
+	settings = get_le32(param);
 
 	DBG("settings: 0x%8.8x -> 0x%8.8x", adapter.current_settings,
 								settings);
diff --git a/monitor/control.c b/monitor/control.c
index 6394387..8197813 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -121,7 +121,7 @@ static void mgmt_new_settings(uint16_t len, const void *buf)
 		return;
 	}
 
-	settings = bt_get_le32(buf);
+	settings = get_le32(buf);
 
 	printf("@ New Settings: 0x%4.4x\n", settings);
 
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 362a0b3..75363b5 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -482,15 +482,15 @@ static void print_config_options(const struct l2cap_frame *frame,
 			print_field("  Service type: %s (0x%2.2x)",
 						str, data[consumed + 3]);
 			print_field("  Token rate: 0x%8.8x",
-					bt_get_le32(data + consumed + 4));
+					get_le32(data + consumed + 4));
 			print_field("  Token bucket size: 0x%8.8x",
-					bt_get_le32(data + consumed + 8));
+					get_le32(data + consumed + 8));
 			print_field("  Peak bandwidth: 0x%8.8x",
-					bt_get_le32(data + consumed + 12));
+					get_le32(data + consumed + 12));
 			print_field("  Latency: 0x%8.8x",
-					bt_get_le32(data + consumed + 16));
+					get_le32(data + consumed + 16));
 			print_field("  Delay variation: 0x%8.8x",
-					bt_get_le32(data + consumed + 20));
+					get_le32(data + consumed + 20));
                         break;
 		case 0x04:
 			if (response)
@@ -564,11 +564,11 @@ static void print_config_options(const struct l2cap_frame *frame,
 			print_field("  Maximum SDU size: 0x%4.4x",
 					get_le16(data + consumed + 4));
 			print_field("  SDU inter-arrival time: 0x%8.8x",
-					bt_get_le32(data + consumed + 6));
+					get_le32(data + consumed + 6));
 			print_field("  Access latency: 0x%8.8x",
-					bt_get_le32(data + consumed + 10));
+					get_le32(data + consumed + 10));
 			print_field("  Flush timeout: 0x%8.8x",
-					bt_get_le32(data + consumed + 14));
+					get_le32(data + consumed + 14));
 			break;
 		case 0x07:
 			print_field("  Max window size: %d",
@@ -924,7 +924,7 @@ static void sig_info_rsp(const struct l2cap_frame *frame)
 			packet_hexdump(data, size);
 			break;
 		}
-		print_features(bt_get_le32(data));
+		print_features(get_le32(data));
 		break;
 	case 0x0003:
 		if (size != 8) {
@@ -1701,16 +1701,16 @@ static void print_uuid(const char *label, const void *data, uint16_t size)
 		print_field("%s: %s (0x%4.4x)", label, str, get_le16(data));
 		break;
 	case 4:
-		str = uuid32_to_str(bt_get_le32(data));
-		print_field("%s: %s (0x%8.8x)", label, str, bt_get_le32(data));
+		str = uuid32_to_str(get_le32(data));
+		print_field("%s: %s (0x%8.8x)", label, str, get_le32(data));
 		break;
 	case 16:
 		str = uuid128_to_str(data);
 		print_field("%s: %s (%8.8x-%4.4x-%4.4x-%4.4x-%8.8x%4.4x)",
 				label, str,
-				bt_get_le32(data + 12), get_le16(data + 10),
+				get_le32(data + 12), get_le16(data + 10),
 				get_le16(data + 8), get_le16(data + 6),
-				bt_get_le32(data + 2), get_le16(data + 0));
+				get_le32(data + 2), get_le16(data + 0));
 		break;
 	default:
 		packet_hexdump(data, size);
diff --git a/monitor/packet.c b/monitor/packet.c
index 73c804a..8fec2eb 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -1917,9 +1917,9 @@ static void print_flow_spec(const char *label, const uint8_t *data)
 	print_field("%s flow spec: 0x%2.2x", label, data[0]);
 	print_field("  Service type: %s (0x%2.2x)", str, data[1]);
 	print_field("  Maximum SDU size: 0x%4.4x", get_le16(data + 2));
-	print_field("  SDU inter-arrival time: 0x%8.8x", bt_get_le32(data + 4));
-	print_field("  Access latency: 0x%8.8x", bt_get_le32(data + 8));
-	print_field("  Flush timeout: 0x%8.8x", bt_get_le32(data + 12));
+	print_field("  SDU inter-arrival time: 0x%8.8x", get_le32(data + 4));
+	print_field("  Access latency: 0x%8.8x", get_le32(data + 8));
+	print_field("  Flush timeout: 0x%8.8x", get_le32(data + 12));
 }
 
 static void print_short_range_mode(uint8_t mode)
@@ -2767,9 +2767,9 @@ static void print_manufacturer_apple(const void *data, uint8_t data_len)
 
 		uuid = data + 2;
 		print_field("  iBeacon: %8.8x-%4.4x-%4.4x-%4.4x-%8.8x%4.4x",
-				bt_get_le32(&uuid[12]), get_le16(&uuid[10]),
+				get_le32(&uuid[12]), get_le16(&uuid[10]),
 				get_le16(&uuid[8]), get_le16(&uuid[6]),
-				bt_get_le32(&uuid[2]), get_le16(&uuid[0]));
+				get_le32(&uuid[2]), get_le16(&uuid[0]));
 
 		major = get_le16(data + 18);
 		minor = get_le16(data + 20);
@@ -2885,7 +2885,7 @@ static void print_uuid32_list(const char *label, const void *data,
 	print_field("%s: %u entr%s", label, count, count == 1 ? "y" : "ies");
 
 	for (i = 0; i < count; i++) {
-		uint32_t uuid = bt_get_le32(data + (i * 4));
+		uint32_t uuid = get_le32(data + (i * 4));
 		print_field("  %s (0x%8.8x)", uuid32_to_str(uuid), uuid);
 	}
 }
@@ -2902,9 +2902,9 @@ static void print_uuid128_list(const char *label, const void *data,
 		const uint8_t *uuid = data + (i * 16);
 
 		print_field("  %8.8x-%4.4x-%4.4x-%4.4x-%8.8x%4.4x",
-				bt_get_le32(&uuid[12]), get_le16(&uuid[10]),
+				get_le32(&uuid[12]), get_le16(&uuid[10]),
 				get_le16(&uuid[8]), get_le16(&uuid[6]),
-				bt_get_le32(&uuid[2]), get_le16(&uuid[0]));
+				get_le32(&uuid[2]), get_le16(&uuid[0]));
 	}
 }
 
diff --git a/src/adapter.c b/src/adapter.c
index 56bee35..14366df 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -497,7 +497,7 @@ static void new_settings_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	settings = bt_get_le32(param);
+	settings = get_le32(param);
 
 	if (settings == adapter->current_settings)
 		return;
@@ -5025,7 +5025,7 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	passkey = bt_get_le32(&ev->passkey);
+	passkey = get_le32(&ev->passkey);
 
 	DBG("passkey %06u entered %u", passkey, ev->entered);
 
diff --git a/src/eir.c b/src/eir.c
index 62e91ac..db9175b 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -84,7 +84,7 @@ static void eir_parse_uuid32(struct eir_data *eir, const void *data,
 
 	service.type = SDP_UUID32;
 	for (i = 0; i < len / 4; i++, uuid32++) {
-		service.value.uuid32 = bt_get_le32(uuid32);
+		service.value.uuid32 = get_le32(uuid32);
 
 		uuid_str = bt_uuid2string(&service);
 		if (!uuid_str)
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index e8552e2..adb5747 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -123,7 +123,7 @@ static void new_settings(uint16_t index, uint16_t len,
 
 	if (monitor) {
 		printf("hci%u new_settings: ", index);
-		print_settings(bt_get_le32(ev));
+		print_settings(get_le32(ev));
 		printf("\n");
 	}
 }
@@ -561,7 +561,7 @@ static void user_confirm(uint16_t index, uint16_t len, const void *param,
 	}
 
 	ba2str(&ev->addr.bdaddr, addr);
-	val = bt_get_le32(&ev->value);
+	val = get_le32(&ev->value);
 
 	if (monitor)
 		printf("hci%u %s User Confirm %06u hint %u\n", index, addr,
@@ -719,10 +719,10 @@ static void info_rsp(uint8_t status, uint16_t len, const void *param,
 			rp->dev_class[2], rp->dev_class[1], rp->dev_class[0]);
 
 	printf("\tsupported settings: ");
-	print_settings(bt_get_le32(&rp->supported_settings));
+	print_settings(get_le32(&rp->supported_settings));
 
 	printf("\n\tcurrent settings: ");
-	print_settings(bt_get_le32(&rp->current_settings));
+	print_settings(get_le32(&rp->current_settings));
 
 	printf("\n\tname %s\n", rp->name);
 	printf("\tshort name %s\n", rp->short_name);
@@ -886,7 +886,7 @@ static void setting_rsp(uint16_t op, uint16_t id, uint8_t status, uint16_t len,
 	}
 
 	printf("hci%u %s complete, settings: ", id, mgmt_opstr(op));
-	print_settings(bt_get_le32(rp));
+	print_settings(get_le32(rp));
 	printf("\n");
 
 done:
diff --git a/tools/l2test.c b/tools/l2test.c
index 5381a50..c70bac0 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -911,7 +911,7 @@ static void recv_mode(int sk)
 			}
 
 			/* Check sequence */
-			sq = bt_get_le32(buf);
+			sq = get_le32(buf);
 			if (seq != sq) {
 				syslog(LOG_INFO, "seq missmatch: %d -> %d", seq, sq);
 				seq = sq;
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index a3c1c72..567efa0 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -36,6 +36,7 @@
 #include "monitor/bt.h"
 #include "emulator/bthost.h"
 
+#include "src/shared/util.h"
 #include "src/shared/tester.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/hciemu.h"
@@ -3236,7 +3237,7 @@ static void command_generic_new_settings_alt(uint16_t index, uint16_t length,
 		return;
 	}
 
-	settings = bt_get_le32(param);
+	settings = get_le32(param);
 
 	tester_print("New settings 0x%08x received", settings);
 
diff --git a/tools/parser/l2cap.c b/tools/parser/l2cap.c
index b6bb8be..f1f6a97 100644
--- a/tools/parser/l2cap.c
+++ b/tools/parser/l2cap.c
@@ -253,7 +253,7 @@ static uint32_t get_val(uint8_t *ptr, uint8_t len)
 	case 2:
 		return get_le16(ptr);
 	case 4:
-		return bt_get_le32(ptr);
+		return get_le32(ptr);
 	}
 	return 0;
 }
-- 
1.8.3.1

