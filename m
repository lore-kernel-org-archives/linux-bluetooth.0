Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ v2 1/7] monitor: Add BREDR PHYs in PHY configuration commands
Date: Wed, 25 Jul 2018 15:51:20 +0530
Message-Id: <1532514086-14790-2-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1532514086-14790-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1532514086-14790-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/packet.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 14ce294..d99470c 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11744,12 +11744,21 @@ static void mgmt_set_apperance_cmd(const void *data, uint16_t size)
 }
 
 static const struct bitfield_data mgmt_phy_table[] = {
-	{  0, "1MTX"	},
-	{  1, "1MRX"	},
-	{  2, "2MTX"	},
-	{  3, "2MRX"	},
-	{  4, "CODEDTX"	},
-	{  5, "CODEDRX"	},
+	{  0, "BR 1M 1SLOT"	},
+	{  1, "BR 1M 3SLOT"	},
+	{  2, "BR 1M 5SLOT"	},
+	{  3, "EDR 2M 1SLOT"	},
+	{  4, "EDR 2M 3SLOT"	},
+	{  5, "EDR 2M 5SLOT"	},
+	{  6, "EDR 3M 1SLOT"	},
+	{  7, "EDR 3M 3SLOT"	},
+	{  8, "EDR 3M 5SLOT"	},
+	{  9, "LE 1M TX"	},
+	{  10, "LE 1M RX"	},
+	{  11, "LE 2M TX"	},
+	{  12, "LE 2M RX"	},
+	{  13, "LE CODED TX"	},
+	{  14, "LE CODED RX"	},
 	{ }
 };
 
@@ -11767,18 +11776,20 @@ static void mgmt_print_phys(const char *label, uint16_t phys)
 
 static void mgmt_get_phy_rsp(const void *data, uint16_t size)
 {
-	uint16_t supported_phys = get_le16(data);
-	uint16_t selected_phys = get_le16(data + 2);
+	uint32_t supported_phys = get_le32(data);
+	uint32_t configurable_phys = get_le32(data + 4);
+	uint32_t selected_phys = get_le32(data + 8);
 
 	mgmt_print_phys("Supported PHYs", supported_phys);
+	mgmt_print_phys("Configurable PHYs", configurable_phys);
 	mgmt_print_phys("Selected PHYs", selected_phys);
 }
 
 static void mgmt_set_phy_cmd(const void *data, uint16_t size)
 {
-	uint16_t default_phys = get_le16(data);
+	uint32_t selected_phys = get_le32(data);
 
-	mgmt_print_phys("Default PHYs", default_phys);
+	mgmt_print_phys("Selected PHYs", selected_phys);
 }
 
 struct mgmt_data {
@@ -11996,9 +12007,9 @@ static const struct mgmt_data mgmt_command_table[] = {
 				mgmt_null_rsp, 0, true },
 	{ 0x0044, "Get PHY Configuration",
 				mgmt_null_cmd, 0, true,
-				mgmt_get_phy_rsp, 4, true },
+				mgmt_get_phy_rsp, 12, true },
 	{ 0x0045, "Set PHY Configuration",
-				mgmt_set_phy_cmd, 2, true,
+				mgmt_set_phy_cmd, 4, true,
 				mgmt_null_rsp, 0, true },
 	{ }
 };
@@ -12380,7 +12391,7 @@ static void mgmt_ext_controller_info_changed_evt(const void *data, uint16_t size
 
 static void mgmt_phy_changed_evt(const void *data, uint16_t size)
 {
-	uint16_t selected_phys = get_le16(data);
+	uint32_t selected_phys = get_le32(data);
 
 	mgmt_print_phys("Selected PHYs", selected_phys);
 }
@@ -12461,7 +12472,7 @@ static const struct mgmt_data mgmt_event_table[] = {
 	{ 0x0025, "Extended Controller Information Changed",
 			mgmt_ext_controller_info_changed_evt, 2, false },
 	{ 0x0026, "PHY Configuration Changed",
-			mgmt_phy_changed_evt, 2, true },
+			mgmt_phy_changed_evt, 4, true },
 	{ }
 };
 
-- 
2.7.4
