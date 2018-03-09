Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 1/4 v1] monitor: Add support PHY management commands and event
Date: Fri,  9 Mar 2018 12:55:51 +0530
Message-Id: <1520580354-2185-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/packet.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index b800a2d..e3b5ab7 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -97,6 +97,7 @@
 #define COLOR_UNKNOWN_ADDRESS_TYPE	COLOR_WHITE_BG
 #define COLOR_UNKNOWN_DEVICE_FLAG	COLOR_WHITE_BG
 #define COLOR_UNKNOWN_ADV_FLAG		COLOR_WHITE_BG
+#define COLOR_UNKNOWN_PHY		COLOR_WHITE_BG
 
 #define COLOR_PHY_PACKET		COLOR_BLUE
 
@@ -10611,6 +10612,7 @@ static const struct {
 	{ 13, "Privacy"			},
 	{ 14, "Controller Configuration"},
 	{ 15, "Static Address"		},
+	{ 16, "PHY Configuration"	},
 	{ }
 };
 
@@ -11905,6 +11907,54 @@ static void mgmt_set_apperance_cmd(const void *data, uint16_t size)
 	print_appearance(appearance);
 }
 
+static const struct {
+	uint8_t bit;
+	const char *str;
+} mgmt_phy_table[] = {
+	{  0, "1MTX"	},
+	{  1, "1MRX"	},
+	{  2, "2MTX"	},
+	{  3, "2MRX"	},
+	{  4, "CODEDTX"	},
+	{  5, "CODEDRX"	},
+	{ }
+};
+
+static void mgmt_print_phys(const char *label, uint16_t phys)
+{
+	uint16_t mask = phys;
+	int i;
+
+	print_field("%s: 0x%4.4x", label, phys);
+
+	for (i = 0; mgmt_phy_table[i].str; i++) {
+		if (phys & (1 << mgmt_phy_table[i].bit)) {
+			print_field("  %s", mgmt_phy_table[i].str);
+			mask &= ~(1 << mgmt_phy_table[i].bit);
+		}
+	}
+
+	if (mask)
+		print_text(COLOR_UNKNOWN_PHY, "  Unknown PHYs"
+							" (0x%8.8x)", mask);
+}
+
+static void mgmt_get_phy_rsp(const void *data, uint16_t size)
+{
+	uint16_t supported_phys = get_le16(data);
+	uint16_t selected_phys = get_le16(data + 2);
+
+	mgmt_print_phys("Supported PHYs", supported_phys);
+	mgmt_print_phys("Selected PHYs", selected_phys);
+}
+
+static void mgmt_set_phy_cmd(const void *data, uint16_t size)
+{
+	uint16_t default_phys = get_le16(data);
+
+	mgmt_print_phys("Default PHYs", default_phys);
+}
+
 struct mgmt_data {
 	uint16_t opcode;
 	const char *str;
@@ -12118,6 +12168,12 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x0043, "Set Appearance",
 				mgmt_set_apperance_cmd, 2, true,
 				mgmt_null_rsp, 0, true },
+	{ 0x0044, "Get PHY Configuration",
+				mgmt_null_cmd, 0, true,
+				mgmt_get_phy_rsp, 4, true },
+	{ 0x0045, "Set PHY Configuration",
+				mgmt_set_phy_cmd, 2, true,
+				mgmt_null_rsp, 0, true },
 	{ }
 };
 
@@ -12496,6 +12552,13 @@ static void mgmt_ext_controller_info_changed_evt(const void *data, uint16_t size
 	print_eir(data + 2, size - 2, false);
 }
 
+static void mgmt_phy_changed_evt(const void *data, uint16_t size)
+{
+	uint16_t selected_phys = get_le16(data);
+
+	mgmt_print_phys("Selected PHYs", selected_phys);
+}
+
 static const struct mgmt_data mgmt_event_table[] = {
 	{ 0x0001, "Command Complete",
 			mgmt_command_complete_evt, 3, false },
@@ -12571,6 +12634,8 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_advertising_removed_evt, 1, true },
 	{ 0x0025, "Extended Controller Information Changed",
 			mgmt_ext_controller_info_changed_evt, 2, false },
+	{ 0x0026, "PHY Configuration Changed",
+			mgmt_phy_changed_evt, 2, true },
 	{ }
 };
 
-- 
2.7.4

