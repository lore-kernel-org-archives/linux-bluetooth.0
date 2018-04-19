Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	thierry.escande@linaro.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v2 0/2] Enable Bluetooth functionality for WCN3990 
Date: Thu, 19 Apr 2018 19:04:56 +0530
Message-Id: <1524144898-4645-1-git-send-email-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for wcn3990:

	These changes are aligned as per serdev frame work.
 	We implemented these changes on top of https://patchwork.kernel.org/patch/10316093/
	As this patch enable serdev for one of the Qualcomm BT chip.

	The changes in the patch include.
	- Adding support to voting up/down regulators for WCN3990.
  	- Bluetooth firmware download for wcn3990.
 
Add device tree bindings for Atheros chips:

	These changes are on top of https://patchwork.kernel.org/patch/10316097/.
	- Description of device tree bindings. 

Balakrishna Godavarthi (2):
  Bluetooth: Add device tree bindings for Atheros chips
  Bluetooth: Add support for wcn3990 soc.

 .../devicetree/bindings/net/qualcomm-bluetooth.txt |  11 +
 drivers/bluetooth/btqca.c                          | 393 ++++++++++++----
 drivers/bluetooth/btqca.h                          |  49 +-
 drivers/bluetooth/hci_qca.c                        | 501 ++++++++++++++++++---
 include/net/bluetooth/hci_core.h                   |   3 +-
 net/bluetooth/hci_core.c                           |   2 +-
 net/bluetooth/hci_request.c                        |  23 +
 net/bluetooth/hci_request.h                        |   2 +
 8 files changed, 823 insertions(+), 161 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
