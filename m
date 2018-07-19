Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v5 06/16] Bluetooth: Set Scan PHYs based on selected PHYs by user
Date: Thu, 19 Jul 2018 17:09:37 +0530
Message-Id: <1532000387-3649-7-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1532000387-3649-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Use the PHYs selected in Set Phy Configuration management command
while scanning.

< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/hci.h      |  4 +++-
 include/net/bluetooth/hci_core.h |  9 +++++++++
 net/bluetooth/hci_request.c      | 37 ++++++++++++++++++++++++++++---------
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 89bf800..0421145 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1540,7 +1540,9 @@ struct hci_cp_le_set_ext_scan_params {
 	__u8    data[0];
 } __packed;
 
-#define LE_SCAN_PHY_1M 0x01
+#define LE_SCAN_PHY_1M		0x01
+#define LE_SCAN_PHY_2M		0x02
+#define LE_SCAN_PHY_CODED	0x04
 
 struct hci_cp_le_scan_phy_params {
 	__u8    type;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ab5d494..113c9bb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1165,6 +1165,15 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define bredr_sc_enabled(dev)  (lmp_sc_capable(dev) && \
 				hci_dev_test_flag(dev, HCI_SC_ENABLED))
 
+#define scan_1m(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_1M) || \
+		      ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_1M))
+
+#define scan_2m(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_2M) || \
+		      ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_2M))
+
+#define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_CODED) || \
+			 ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
+
 /* Use ext scanning if set ext scan param and ext scan enable is supported */
 #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
 			   ((dev)->commands[37] & 0x40))
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index faf7c71..215059a 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -790,8 +790,8 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 		struct hci_cp_le_set_ext_scan_params *ext_param_cp;
 		struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
 		struct hci_cp_le_scan_phy_params *phy_params;
-		/* Ony single PHY (1M) is supported as of now */
-		u8 data[sizeof(*ext_param_cp) + sizeof(*phy_params) * 1];
+		u8 data[sizeof(*ext_param_cp) + sizeof(*phy_params) * 2];
+		u32 plen;
 
 		ext_param_cp = (void *)data;
 		phy_params = (void *)ext_param_cp->data;
@@ -799,16 +799,35 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 		memset(ext_param_cp, 0, sizeof(*ext_param_cp));
 		ext_param_cp->own_addr_type = own_addr_type;
 		ext_param_cp->filter_policy = filter_policy;
-		ext_param_cp->scanning_phys = LE_SCAN_PHY_1M;
 
-		memset(phy_params, 0, sizeof(*phy_params));
-		phy_params->type = type;
-		phy_params->interval = cpu_to_le16(interval);
-		phy_params->window = cpu_to_le16(window);
+		plen = sizeof(*ext_param_cp);
+
+		if (scan_1m(hdev) || scan_2m(hdev)) {
+			ext_param_cp->scanning_phys |= LE_SCAN_PHY_1M;
+
+			memset(phy_params, 0, sizeof(*phy_params));
+			phy_params->type = type;
+			phy_params->interval = cpu_to_le16(interval);
+			phy_params->window = cpu_to_le16(window);
+
+			plen += sizeof(*phy_params);
+			phy_params++;
+		}
+
+		if (scan_coded(hdev)) {
+			ext_param_cp->scanning_phys |= LE_SCAN_PHY_CODED;
+
+			memset(phy_params, 0, sizeof(*phy_params));
+			phy_params->type = type;
+			phy_params->interval = cpu_to_le16(interval);
+			phy_params->window = cpu_to_le16(window);
+
+			plen += sizeof(*phy_params);
+			phy_params++;
+		}
 
 		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_PARAMS,
-			    sizeof(*ext_param_cp) + sizeof(*phy_params),
-			    ext_param_cp);
+			    plen, ext_param_cp);
 
 		memset(&ext_enable_cp, 0, sizeof(ext_enable_cp));
 		ext_enable_cp.enable = LE_SCAN_ENABLE;
-- 
2.7.4
