Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Nishant Sarmukadam <nishants@marvell.com>, <wnhuang@chromium.com>,
	<devicetree@vger.kernel.org>, Cathy Luo <cluo@marvell.com>,
	<linux-kernel@vger.kernel.org>, Xinming Hu <huxm@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH v4 2/3] mwifiex: parse chip specific gpio from device tree
Date: Tue, 16 Feb 2016 01:14:38 -0800
Message-ID: <1455614079-4263-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1455614079-4263-1-git-send-email-akarwar@marvell.com>
References: <1455614079-4263-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Xinming Hu <huxm@marvell.com>

This patch parse chip specific gpio parameter from device
tree. Corresponding binding file is also updated.

Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
v4: Renamed "mwifiex,chip-gpio" to "marvell,wakeup-gpios"(Rob Herring/
    Arnd Bergmann)
---
 .../devicetree/bindings/net/wireless/marvell-sd8xxx.txt          | 6 ++++--
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c                   | 9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt b/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
index f7671ae..c337fab 100644
--- a/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
+++ b/Documentation/devicetree/bindings/net/wireless/marvell-sd8xxx.txt
@@ -11,7 +11,9 @@ Optional properties:
   - marvell,caldata* : A series of properties with marvell,caldata prefix,
   		      represent Calibration data downloaded to the device during
 		      initialization. This is an array of unsigned values.
-
+  - marvell,wakeup-gpios : Chip's wakeup gpio pin number. This needs to be downloaded
+			to to firmware. Chip notifies wifi wakeup signal to SOC
+			through this pin.
 
 Example:
 
@@ -24,6 +26,6 @@ wlan {
 
 	marvell,caldata_00_txpwrlimit_2g_cfg_set = /bits/ 8 <
 0x01 0x00 0x06 0x00 0x08 0x02 0x89 0x01 ...>;
-
+	marvell,wakeup-gpios = <3>;
 };
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index 238fe4f..fce3f98 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -2134,6 +2134,7 @@ int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool init)
 	enum state_11d_t state_11d;
 	struct mwifiex_ds_11n_tx_cfg tx_cfg;
 	u8 sdio_sp_rx_aggr_enable;
+	u32 data;
 
 	if (first_sta) {
 		if (priv->adapter->iface_type == MWIFIEX_PCIE) {
@@ -2157,6 +2158,14 @@ int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool init)
 		adapter->dt_node = mwifiex_plt_dev ?
 				mwifiex_plt_dev->dev.of_node : NULL;
 		if (adapter->dt_node) {
+			if (of_property_read_u32(adapter->dt_node,
+						 "marvell,wakeup-gpios",
+						 &data) == 0) {
+				mwifiex_dbg(adapter, INFO,
+					    "Wakeup gpio = 0x%x\n", data);
+				adapter->hs_cfg.gpio = data;
+			}
+
 			ret = mwifiex_dnld_dt_cfgdata(priv, adapter->dt_node,
 						      "marvell,caldata");
 			if (ret)
-- 
1.8.1.4
