Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v4 0/3] Enable Bluetooth functionality for WCN3990. 
Date: Fri,  4 May 2018 21:05:03 +0530
Message-Id: <1525448106-18616-1-git-send-email-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

These patches enable Bluetooth functionality for WCN3990 by 
- adding support for voting of voltage regulators for WCN3990 attached to MSM
- Bluetooth firmware download support for WCN3990
- description of device tree bindings

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


Balakrishna Godavarthi (3):
  dt-bindings: net: bluetooth: Add device tree bindings for QTI chip
    wcn3990
  Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990.
  Bluetooth: btqca: Add wcn3990 firmware download support.

 .../devicetree/bindings/net/qualcomm-bluetooth.txt |  31 +-
 drivers/bluetooth/btqca.c                          |  45 +-
 drivers/bluetooth/btqca.h                          |  19 +
 drivers/bluetooth/hci_qca.c                        | 555 ++++++++++++++++++---
 4 files changed, 575 insertions(+), 75 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
