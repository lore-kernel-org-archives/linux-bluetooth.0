Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ 2/8] btmgmt: Add BREDR PHYs in PHY Configuration commands
Date: Fri,  6 Jul 2018 16:57:59 +0530
Message-Id: <1530876485-17218-3-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1530876485-17218-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1530876485-17218-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/mgmt.h     | 32 +++++++++++++++++++-----------
 tools/btmgmt.c | 62 ++++++++++++++++++++++++++++------------------------------
 2 files changed, 51 insertions(+), 43 deletions(-)

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
index f5bef63..9dc6712 100644
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
+	"BR_1M_1SLOT",
+	"BR_1M_3SLOT",
+	"BR_1M_5SLOT",
+	"EDR_2M_1SLOT",
+	"EDR_2M_3SLOT",
+	"EDR_2M_5SLOT",
+	"EDR_3M_1SLOT",
+	"EDR_3M_3SLOT",
+	"EDR_3M_5SLOT",
+	"LE_1M_TX",
+	"LE_1M_RX",
+	"LE_2M_TX",
+	"LE_2M_RX",
+	"LE_CODED_TX",
+	"LE_CODED_RX",
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
@@ -4265,34 +4276,21 @@ static void set_phy_rsp(uint8_t status, uint16_t len, const void *param,
 static void cmd_phy(int argc, char **argv)
 {
 	struct mgmt_cp_set_phy_confguration cp;
-	int i;
-	uint16_t phys = 0;
+	int i, j;
+	uint32_t phys = 0;
 	uint16_t index;
 
 	if (argc < 2)
 		return get_phy();
 
 	for (i = 1; i < argc; i++) {
-		if (strcasecmp(argv[i], "1MTX") == 0)
-			phys |= MGMT_PHY_LE_1M_TX;
-
-		if (strcasecmp(argv[i], "1MRX") == 0)
-			phys |= MGMT_PHY_LE_1M_RX;
-
-		if (strcasecmp(argv[i], "2MTX") == 0)
-			phys |= MGMT_PHY_LE_2M_TX;
-
-		if (strcasecmp(argv[i], "2MRX") == 0)
-			phys |= MGMT_PHY_LE_2M_RX;
-
-		if (strcasecmp(argv[i], "CODEDTX") == 0)
-			phys |= MGMT_PHY_LE_CODED_TX;
-
-		if (strcasecmp(argv[i], "CODEDRX") == 0)
-			phys |= MGMT_PHY_LE_CODED_RX;
+		for (j = 0; j < NELEM(phys_str); j++) {
+			if (strcasecmp(argv[i], phys_str[j]) == 0)
+				phys |= (1 << j);
+		}
 	}
 
-	cp.default_phys = cpu_to_le16(phys);
+	cp.selected_phys = cpu_to_le32(phys);
 
 	index = mgmt_index;
 	if (index == MGMT_INDEX_NONE)
@@ -4501,7 +4499,7 @@ static const struct bt_shell_menu main_menu = {
 		cmd_clr_adv,		"Clear advertising instances"	},
 	{ "appearance",		"<appearance>",
 		cmd_appearance,		"Set appearance"		},
-	{ "phy",		"[phys]",
+	{ "phy",		"[phys ...]",
 		cmd_phy,		"Get/Set PHY Configuration"	},
 	{} },
 };
-- 
2.7.4
