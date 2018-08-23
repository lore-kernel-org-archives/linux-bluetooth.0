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
Subject: [PATCH v1 0/1] Cold on & off support for Qualcomm BT chip wcn3990. 
Date: Thu, 23 Aug 2018 16:59:34 +0530
Message-Id: <20180823112935.17342-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch will power off regulators while hci0 down and turn on them 
back on hci0 up. Every time we power off we call proto specific close
function, so that we will free the memory of Qualcomm BT specific buffers.
Will call proto open to assign the memory and turn on the regulators, before
calling qualcomm setup.

Balakrishna Godavarthi (1):
  Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990

 drivers/bluetooth/hci_qca.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
