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
Subject: [PATCH v1 0/2] Bug fixes for qualcomm BT chip wcn3990. 
Date: Wed, 22 Aug 2018 17:50:03 +0530
Message-Id: <20180822122005.11218-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

When we set an KASAN flags, we are seeing an crash while removing module hci_uart.
This is due to dereference of hdev. As in module deinit we are calling function
hci_free_dev() to free hdev.
 
Changes in v1:
 
  * removed dereference of hdev in qca_power_shutdown i.e. qca_close.
  * moved serdev open & close call from qca_open & qca_close.


Balakrishna Godavarthi (2):
  Bluetooth: hci_qca: Remove serdev_device_open/close function calls
  Bluetooth: hci_qca: Remove hdev dereference in qca_close().

 drivers/bluetooth/hci_qca.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
