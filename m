Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	mka@chromium.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	thierry.escande@linaro.org,
	rtatiya@codeaurora.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v15 0/7] Enable Bluetooth functionality for WCN3990 
Date: Fri,  3 Aug 2018 17:46:25 +0530
Message-Id: <20180803121632.30689-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

These patches enables Bluetooth functinalties for new Qualcomm
Bluetooth chip wnc3990. As this is latest chip with new features, 
along with some common features to old chip "qcom,qca6174-bt".
we have updated names of functions that are used for both the chips 
to keep this generic and would help in future when we would have new 
BT SoC.

The below are difference between new and old chips.

*Power:
 *New chip: we use voltage regulators to turn on/off the chip and we 
  must send a command on Tx line to turn on/off the chip completely.
 *Old chip: We turn on/off by setting a GPIO.

 *Note: Turning on sequence differs between two chips.

*Firmware download:
  Only firmware file name differ from New and Old chip.
  
  So we reused some functions/structure/variables which are used for old 
  chip to New chip by generic naming (may be future chips may use same functions).

 * As we have multiple changes for functions names,we have tested these patches 
   on both chips.

v15:
 * fixed nit issue in hci_qca.

v13:
 * Segregated optional and required properties for wcn3990.

v12:
 * removed iteration loop in qca_init_wcn3990 
 * updated review comments.

v11:
 * removed regulator current from dtbindings
 * addressed review comments.

v10:
 * update current load with actual values of WCN3990.
 * added support  for itterative connect with BT chip if it fails to respond to the HOST.
 * Added regulator current dtbindings.
 * addressed review comments.

v9:
 * removed smps regs.
 * hidded flow control in respective functions.
 * moved qca_soc_ver to qca_setup
 * addressed review comments.
 
v8:
  * Squashed [v7 2/8] and [v7 3/8] to one patch.
  * updated functions to set and get the UART speeds.
  * addressed review comments.

v7:
  * Renamed all the possible function of ROME to generic.
  * updated with review comments for hci_qca and btqca
  * fixed kbuild errors.
  * created wrapper functions for re-usable blocks.
 
v6:
  * Hooked up qca_power to qca_serdev.
  * renamed all the naming inconsistency functions with qca_*
  * leveraged common code of ROME for wcn3990.
  * created wrapper functions for re-usable blocks.
  * updated function of _*regulator_enable and _*regualtor_disable.  
  * removed redundant comments and functions.
  * add code to derive the firmware files based on ROM Version.
  * created new patch for common function of ROME and wcn3990.
  * enables Qualcomm chip to operate at 3.2Mbps.
  * updated names of functions that are used for both the chips to keep this generic. 

v5:
  * updated with review comments for hci_qca and btqca
 
v4:
  * rebased all changes on top of bluetooth-next.
  * addressed review comments.
  * New patch created for firmware download.

v3:
  * Rebased all changes on top of bluetooth-next.
  * dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3990
    - added dt-binding snippet for bluetooth chip wcn3990.
  * Bluetooth: Add support for wcn3990 soc.
    - updated BT_INFO with bt_dev_info, where ever necessary.

v2:
   * Add support for wcn3990:
    These changes are aligned as per serdev frame work.
          We implemented these changes on top of https://patchwork.kernel.org/patch/10316093/
        As this patch enable serdev for one of the Qualcomm BT chip.

        The changes in the patch include.
        - Adding support to voting up/down regulators for WCN3990.
           - Bluetooth firmware download for wcn3990.

  * Add device tree bindings for Atheros chips:
          These changes are on top of https://patchwork.kernel.org/patch/10316097/.
          - Description of device tree bindings.

Balakrishna Godavarthi (7):
  dt-bindings: net: bluetooth: Add device tree bindings for QTI chip
    wcn3990
  Bluetooth: btqca: Rename ROME specific functions to generic functions
  Bluetooth: btqca: Redefine qca_uart_setup() to generic function.
  Bluetooth: hci_qca: Add wrapper functions for setting UART speed
  Bluetooth: hci_qca: Enable 3.2 Mbps operating speed.
  Bluetooth: btqca: Add wcn3990 firmware download support.
  Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990

 .../bindings/net/qualcomm-bluetooth.txt       |  29 +-
 drivers/bluetooth/btqca.c                     | 117 +++--
 drivers/bluetooth/btqca.h                     |  22 +-
 drivers/bluetooth/hci_qca.c                   | 486 +++++++++++++++---
 4 files changed, 539 insertions(+), 115 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
