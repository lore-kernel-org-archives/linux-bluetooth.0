Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	hemantg@codeaurora.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v3 0/2] Enable Bluetooth functionality for WCN3990 
Date: Tue, 24 Apr 2018 19:41:11 +0530
Message-Id: <1524579073-21572-1-git-send-email-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

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


Balakrishna Godavarthi (2):
  dt-bindings: net: bluetooth: Add device tree bindings for QTI chip
    wcn3990
  Bluetooth: Add support for wcn3990 soc.

 .../devicetree/bindings/net/qualcomm-bluetooth.txt |  39 +-
 drivers/bluetooth/btqca.c                          | 393 ++++++++++++----
 drivers/bluetooth/btqca.h                          |  49 +-
 drivers/bluetooth/hci_qca.c                        | 496 ++++++++++++++++++---
 include/net/bluetooth/hci_core.h                   |   3 +-
 net/bluetooth/hci_core.c                           |   2 +-
 net/bluetooth/hci_request.c                        |  23 +
 net/bluetooth/hci_request.h                        |   2 +
 8 files changed, 839 insertions(+), 168 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
