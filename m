Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: mka@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v2 0/1] Cold on & off support for Qualcomm BT chip wcn3990 
Date: Wed, 19 Sep 2018 20:51:12 +0530
Message-Id: <20180919152113.7611-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch will power off regulators while hci0 down and turn on them 
back on hci0 up. Every time we power off we call proto specific close
function, so that we will free the memory of Qualcomm BT specific buffers.
Will call proto open to assign the memory and turn on the regulators, before
calling qualcomm setup.

v2:
   * Removed vendor specific hdev->open and close functions.
   * Added hdev->shutdown function to turn off the regs.	
	
v1:
   * initial patch.

Balakrishna Godavarthi (1):
  Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990

 drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
