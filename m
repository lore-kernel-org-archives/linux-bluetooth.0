Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Subject: [PATCH] btmgmt: Add BREDR PHYs in PHY Configuration commands
Date: Tue,  4 Sep 2018 13:38:04 +0530
Message-Id: <1536048484-31754-1-git-send-email-jaganath.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This also adds LE prefix for LE phys to make it more
descriptive
---
 lib/mgmt.h     | 32 +++++++++++++++--------
 tools/btmgmt.c | 81 +++++++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 81 insertions(+), 32 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index ec6a380..570dec9 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -552,16 +552,26 @@ struct mgmt_cp_set_appearance {
 
 #define MGMT_OP_GET_PHY_CONFIGURATION	0x0044
 struct mgmt_rp_get_phy_confguration {
-	uint16_t	supported_phys;
-	uint16_t	selected_phys;
-} __packed;
-
-#define MGMT_PHY_LE_1M_TX		0x0001
-#define MGMT_PHY_LE_1M_RX		0x0002
-#define MGMT_PHY_LE_2M_TX		0x0004
-#define MGMT_PHY_LE_2M_RX		0x0008
-#define MGMT_PHY_LE_CODED_TX		0x0010
-#define MGMT_PHY_LE_CODED_RX		0x0020
+	uint32_t	supported_phys;
+	uint32_t	configurable_phys;
+	uint32_t	selected_phys;
+} __packed;
+
+#define MGMT_PHY_BR_1M_1SLOT	0x00000001
+#define MGMT_PHY_BR_1M_3SLOT	0x00000002
+#define MGMT_PHY_BR_1M_5SLOT	0x00000004
+#define MGMT_PHY_EDR_2M_1SLOT	0x00000008
+#define MGMT_PHY_EDR_2M_3SLOT	0x00000010
+#define MGMT_PHY_EDR_2M_5SLOT	0x00000020
+#define MGMT_PHY_EDR_3M_1SLOT	0x00000040
+#define MGMT_PHY_EDR_3M_3SLOT	0x00000080
+#define MGMT_PHY_EDR_3M_5SLOT	0x00000100
+#define MGMT_PHY_LE_1M_TX		0x00000200
+#define MGMT_PHY_LE_1M_RX		0x00000400
+#define MGMT_PHY_LE_2M_TX		0x00000800
+#define MGMT_PHY_LE_2M_RX		0x00001000
+#define MGMT_PHY_LE_CODED_TX	0x00002000
+#define MGMT_PHY_LE_CODED_RX	0x00004000
 
 #define MGMT_PHY_LE_TX_MASK (MGMT_PHY_LE_1M_TX | MGMT_PHY_LE_2M_TX | \
 			     MGMT_PHY_LE_CODED_TX)
@@ -570,7 +580,7 @@ struct mgmt_rp_get_phy_confguration {
 
 #define MGMT_OP_SET_PHY_CONFIGURATION	0x0045
 struct mgmt_cp_set_phy_confguration {
-	uint16_t	default_phys;
+	uint32_t	selected_phys;
 } __packed;
 
 
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 9e3a3ca..d200f69 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4181,15 +4181,24 @@ static void cmd_appearance(int argc, char **argv)
 }
 
 static const char *phys_str[] = {
-	"1MTX",
-	"1MRX",
-	"2MTX",
-	"2MRX",
-	"CODEDTX",
-	"CODEDRX",
+	"BR1M1SLOT",
+	"BR1M3SLOT",
+	"BR1M5SLOT",
+	"EDR2M1SLOT",
+	"EDR2M3SLOT",
+	"EDR2M5SLOT",
+	"EDR3M1SLOT",
+	"EDR3M3SLOT",
+	"EDR3M5SLOT",
+	"LE1MTX",
+	"LE1MRX",
+	"LE2MTX",
+	"LE2MRX",
+	"LECODEDTX",
+	"LECODEDRX",
 };
 
-static const char *phys2str(uint16_t phys)
+static const char *phys2str(uint32_t phys)
 {
 	static char str[256];
 	unsigned int i;
@@ -4211,7 +4220,7 @@ static void get_phy_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
 	const struct mgmt_rp_get_phy_confguration *rp = param;
-	uint16_t supported_flags, selected_phys;
+	uint32_t supported_phys, selected_phys, configurable_phys;
 
 	if (status != 0) {
 		error("Get PHY Configuration failed with status 0x%02x (%s)",
@@ -4224,10 +4233,12 @@ static void get_phy_rsp(uint8_t status, uint16_t len, const void *param,
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	supported_flags = get_le16(&rp->supported_phys);
-	selected_phys = get_le16(&rp->selected_phys);
+	supported_phys = get_le32(&rp->supported_phys);
+	configurable_phys = get_le32(&rp->configurable_phys);
+	selected_phys = get_le32(&rp->selected_phys);
 
-	print("Supported phys: %s", phys2str(supported_flags));
+	print("Supported phys: %s", phys2str(supported_phys));
+	print("Configurable phys: %s", phys2str(configurable_phys));
 	print("Selected phys: %s", phys2str(selected_phys));
 
 	bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -4266,33 +4277,60 @@ static void cmd_phy(int argc, char **argv)
 {
 	struct mgmt_cp_set_phy_confguration cp;
 	int i;
-	uint16_t phys = 0;
+	uint32_t phys = 0;
 	uint16_t index;
 
 	if (argc < 2)
 		return get_phy();
 
 	for (i = 1; i < argc; i++) {
-		if (strcasecmp(argv[i], "1MTX") == 0)
+		if (strcasecmp(argv[i], "BR1M1SLOT") == 0)
+			phys |= MGMT_PHY_BR_1M_1SLOT;
+
+		if (strcasecmp(argv[i], "BR1M3SLOT") == 0)
+			phys |= MGMT_PHY_BR_1M_3SLOT;
+
+		if (strcasecmp(argv[i], "BR1M5SLOT") == 0)
+			phys |= MGMT_PHY_BR_1M_5SLOT;
+
+		if (strcasecmp(argv[i], "EDR2M1SLOT") == 0)
+			phys |= MGMT_PHY_EDR_2M_1SLOT;
+
+		if (strcasecmp(argv[i], "EDR2M3SLOT") == 0)
+			phys |= MGMT_PHY_EDR_2M_3SLOT;
+
+		if (strcasecmp(argv[i], "EDR2M5SLOT") == 0)
+			phys |= MGMT_PHY_EDR_2M_5SLOT;
+
+		if (strcasecmp(argv[i], "EDR3M1SLOT") == 0)
+			phys |= MGMT_PHY_EDR_3M_1SLOT;
+
+		if (strcasecmp(argv[i], "EDR3M3SLOT") == 0)
+			phys |= MGMT_PHY_EDR_3M_3SLOT;
+
+		if (strcasecmp(argv[i], "EDR3M5SLOT") == 0)
+			phys |= MGMT_PHY_EDR_3M_5SLOT;
+
+		if (strcasecmp(argv[i], "LE1MTX") == 0)
 			phys |= MGMT_PHY_LE_1M_TX;
 
-		if (strcasecmp(argv[i], "1MRX") == 0)
+		if (strcasecmp(argv[i], "LE1MRX") == 0)
 			phys |= MGMT_PHY_LE_1M_RX;
 
-		if (strcasecmp(argv[i], "2MTX") == 0)
+		if (strcasecmp(argv[i], "LE2MTX") == 0)
 			phys |= MGMT_PHY_LE_2M_TX;
 
-		if (strcasecmp(argv[i], "2MRX") == 0)
+		if (strcasecmp(argv[i], "LE2MRX") == 0)
 			phys |= MGMT_PHY_LE_2M_RX;
 
-		if (strcasecmp(argv[i], "CODEDTX") == 0)
+		if (strcasecmp(argv[i], "LECODEDTX") == 0)
 			phys |= MGMT_PHY_LE_CODED_TX;
 
-		if (strcasecmp(argv[i], "CODEDRX") == 0)
+		if (strcasecmp(argv[i], "LECODEDRX") == 0)
 			phys |= MGMT_PHY_LE_CODED_RX;
 	}
 
-	cp.default_phys = cpu_to_le16(phys);
+	cp.selected_phys = cpu_to_le32(phys);
 
 	index = mgmt_index;
 	if (index == MGMT_INDEX_NONE)
@@ -4501,8 +4539,9 @@ static const struct bt_shell_menu main_menu = {
 		cmd_clr_adv,		"Clear advertising instances"	},
 	{ "appearance",		"<appearance>",
 		cmd_appearance,		"Set appearance"		},
-	{ "phy",		"[1MTX] [1MRX] [2MTX] [2MRX] [CODEDTX] "
-				"[CODEDRX] [BR1M1SLOT] [BR1M3SLOT] [BR1M5SLOT]"
+	{ "phy",		"[LE1MTX] [LE1MRX] [LE2MTX] [LE2MRX] "
+				"[LECODEDTX] [LECODEDRX] "
+				"[BR1M1SLOT] [BR1M3SLOT] [BR1M5SLOT]"
 				"[EDR2M1SLOT] [EDR2M3SLOT] [EDR2M5SLOT]"
 				"[EDR3M1SLOT] [EDR3M3SLOT] [EDR3M5SLOT]",
 		cmd_phy,		"Get/Set PHY Configuration"	},
-- 
2.7.4
