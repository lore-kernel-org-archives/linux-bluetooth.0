Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Anupam Roy <anupam.r@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, Anupam Roy <anupam.r@samsung.com>
Subject: [PATCH] btmgmt: Extend PHY configuration for BREDR types
Date: Fri, 10 Aug 2018 15:54:45 +0530
Message-id: <1533896685-6351-1-git-send-email-anupam.r@samsung.com>
References: <CGME20180810102453epcas1p13dfb3fd5a5591862ae7ed13f999499da@epcas1p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds BREDR packet type defines in lib/mgmt.h and
corresponding PHY configuration support in btmgmt.

[hci0]# phy
Supported phys: [0x7ff] [BR1M1SLOT BR1M3SLOT BR1M5SLOT EDR2M1SLOT EDR2M3SLOT
	EDR2M5SLOT EDR3M1SLOT EDR3M3SLOT EDR3M5SLOT 1MTX 1MRX]
Configurable phys: [0x1fe] [BR1M3SLOT BR1M5SLOT EDR2M1SLOT EDR2M3SLOT
	EDR2M5SLOT EDR3M1SLOT EDR3M3SLOT EDR3M5SLOT]
Selected phys: [0x7ff] [BR1M1SLOT BR1M3SLOT BR1M5SLOT EDR2M1SLOT EDR2M3SLOT
	EDR2M5SLOT EDR3M1SLOT EDR3M3SLOT EDR3M5SLOT 1MTX 1MRX]

@ MGMT Command: Get PHY Configuration (0x0044) plen 0
[hci0] 581.783043
@ MGMT Event: Command Complete (0x0001) plen 15
[hci0] 581.783243
      Get PHY Configuration (0x0044) plen 12
        Status: Success (0x00)
        Supported PHYs: 0x07ff
          BR 1M 1SLOT
          BR 1M 3SLOT
          BR 1M 5SLOT
          EDR 2M 1SLOT
          EDR 2M 3SLOT
          EDR 2M 5SLOT
          EDR 3M 1SLOT
          EDR 3M 3SLOT
          EDR 3M 5SLOT
          LE 1M TX
          LE 1M RX
        Configurable PHYs: 0x01fe
          BR 1M 3SLOT
          BR 1M 5SLOT
          EDR 2M 1SLOT
          EDR 2M 3SLOT
          EDR 2M 5SLOT
          EDR 3M 1SLOT
          EDR 3M 3SLOT
          EDR 3M 5SLOT
        Selected PHYs: 0x07ff
          BR 1M 1SLOT
          BR 1M 3SLOT
          BR 1M 5SLOT
          EDR 2M 1SLOT
          EDR 2M 3SLOT
          EDR 2M 5SLOT
          EDR 3M 1SLOT
          EDR 3M 3SLOT
          EDR 3M 5SLOT
          LE 1M TX
          LE 1M RX

---
 lib/mgmt.h     | 46 ++++++++++++++++++++++++++++++----------------
 tools/btmgmt.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 76 insertions(+), 24 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index ec6a380..ae9371d 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -552,25 +552,39 @@ struct mgmt_cp_set_appearance {
 
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
-
-#define MGMT_PHY_LE_TX_MASK (MGMT_PHY_LE_1M_TX | MGMT_PHY_LE_2M_TX | \
-			     MGMT_PHY_LE_CODED_TX)
-#define MGMT_PHY_LE_RX_MASK (MGMT_PHY_LE_1M_RX | MGMT_PHY_LE_2M_RX | \
-			     MGMT_PHY_LE_CODED_RX)
+        uint32_t supported_phys;
+        uint32_t configurable_phys;
+        uint32_t selected_phys;
+} __packed;
+
+#define MGMT_PHY_BR_1M_1SLOT   0x00000001
+#define MGMT_PHY_BR_1M_3SLOT   0x00000002
+#define MGMT_PHY_BR_1M_5SLOT   0x00000004
+#define MGMT_PHY_EDR_2M_1SLOT  0x00000008
+#define MGMT_PHY_EDR_2M_3SLOT  0x00000010
+#define MGMT_PHY_EDR_2M_5SLOT  0x00000020
+#define MGMT_PHY_EDR_3M_1SLOT  0x00000040
+#define MGMT_PHY_EDR_3M_3SLOT  0x00000080
+#define MGMT_PHY_EDR_3M_5SLOT  0x00000100
+#define MGMT_PHY_LE_1M_TX      0x00000200
+#define MGMT_PHY_LE_1M_RX      0x00000400
+#define MGMT_PHY_LE_2M_TX      0x00000800
+#define MGMT_PHY_LE_2M_RX      0x00001000
+#define MGMT_PHY_LE_CODED_TX   0x00002000
+#define MGMT_PHY_LE_CODED_RX   0x00004000
+
+#define MGMT_PHY_BREDR_MASK (MGMT_PHY_BR_1M_1SLOT | MGMT_PHY_BR_1M_3SLOT | \
+                             MGMT_PHY_BR_1M_5SLOT | MGMT_PHY_EDR_2M_1SLOT | \
+                             MGMT_PHY_EDR_2M_3SLOT | MGMT_PHY_EDR_2M_5SLOT | \
+                             MGMT_PHY_EDR_3M_1SLOT | MGMT_PHY_EDR_3M_3SLOT | \
+                             MGMT_PHY_EDR_3M_5SLOT)
+#define MGMT_PHY_LE_MASK (MGMT_PHY_LE_1M_TX | MGMT_PHY_LE_1M_RX | \
+                          MGMT_PHY_LE_2M_TX | MGMT_PHY_LE_2M_RX | \
+                          MGMT_PHY_LE_CODED_TX | MGMT_PHY_LE_CODED_RX)
 
 #define MGMT_OP_SET_PHY_CONFIGURATION	0x0045
 struct mgmt_cp_set_phy_confguration {
-	uint16_t	default_phys;
+	uint32_t	default_phys;
 } __packed;
 
 
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index f5bef63..4f9b133 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4181,6 +4181,15 @@ static void cmd_appearance(int argc, char **argv)
 }
 
 static const char *phys_str[] = {
+	"BR1M1SLOT",
+	"BR1M3SLOT",
+	"BR1M5SLOT",
+	"EDR2M1SLOT",
+	"EDR2M3SLOT",
+	"EDR2M5SLOT",
+	"EDR3M1SLOT",
+	"EDR3M3SLOT",
+	"EDR3M5SLOT",
 	"1MTX",
 	"1MRX",
 	"2MTX",
@@ -4189,7 +4198,7 @@ static const char *phys_str[] = {
 	"CODEDRX",
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
+	uint32_t supported_flags, configurable_flags, selected_phys;
 
 	if (status != 0) {
 		error("Get PHY Configuration failed with status 0x%02x (%s)",
@@ -4224,11 +4233,13 @@ static void get_phy_rsp(uint8_t status, uint16_t len, const void *param,
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	supported_flags = get_le16(&rp->supported_phys);
-	selected_phys = get_le16(&rp->selected_phys);
+	supported_flags = get_le32(&rp->supported_phys);
+	configurable_flags = get_le32(&rp->configurable_phys);
+	selected_phys = get_le32(&rp->selected_phys);
 
-	print("Supported phys: %s", phys2str(supported_flags));
-	print("Selected phys: %s", phys2str(selected_phys));
+	print("Supported phys: [0x%x] [%s]", supported_flags, phys2str(supported_flags));
+	print("Configurable phys: [0x%x] [%s]", configurable_flags, phys2str(configurable_flags));
+	print("Selected phys: [0x%x] [%s]", selected_phys, phys2str(selected_phys));
 
 	bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -4266,13 +4277,40 @@ static void cmd_phy(int argc, char **argv)
 {
 	struct mgmt_cp_set_phy_confguration cp;
 	int i;
-	uint16_t phys = 0;
+	uint32_t phys = 0;
 	uint16_t index;
 
 	if (argc < 2)
 		return get_phy();
 
 	for (i = 1; i < argc; i++) {
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
+		if (strcasecmp(argv[i], "EDR2M3SLOT") == 0)
+			phys |= MGMT_PHY_EDR_3M_3SLOT;
+
+		if (strcasecmp(argv[i], "EDR3M5SLOT") == 0)
+			phys |= MGMT_PHY_EDR_3M_5SLOT;
+
 		if (strcasecmp(argv[i], "1MTX") == 0)
 			phys |= MGMT_PHY_LE_1M_TX;
 
@@ -4292,7 +4330,7 @@ static void cmd_phy(int argc, char **argv)
 			phys |= MGMT_PHY_LE_CODED_RX;
 	}
 
-	cp.default_phys = cpu_to_le16(phys);
+	cp.default_phys = cpu_to_le32(phys);
 
 	index = mgmt_index;
 	if (index == MGMT_INDEX_NONE)
-- 
1.9.1
