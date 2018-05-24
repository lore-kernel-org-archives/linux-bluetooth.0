Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	mka@chromium.org
Cc: linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v6 0/5] Enable Bluetooth functionality for WCN3990
Date: Thu, 24 May 2018 21:30:46 +0530
Message-Id: <20180524160051.29966-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

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

Balakrishna Godavarthi (5):
  dt-bindings: net: bluetooth: Add device tree bindings for QTI chip
    wcn3990
  Bluetooth: btqca: Rename ROME related functions to Generic functions
  Bluetooth: hci_qca: Enable 3.2 Mbps operating speed.
  Bluetooth: btqca: Add wcn3990 firmware download support.
  Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990.

 .../bindings/net/qualcomm-bluetooth.txt       |  31 +-
 drivers/bluetooth/btqca.c                     |  59 ++-
 drivers/bluetooth/btqca.h                     |  20 +
 drivers/bluetooth/hci_qca.c                   | 423 ++++++++++++++++--
 4 files changed, 479 insertions(+), 54 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
