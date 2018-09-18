Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: linux-firmware@kernel.org
Cc: linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 0/1] Firmware Fix for BT vulnerability CVE-2018-5383
Date: Tue, 18 Sep 2018 13:28:46 +0530
Message-Id: <20180918075847.30255-1-bgodavar@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch will fix the BT vulnerability (CVE-2018-5383) reported on
Bluetooth QCA ROME v3.2 USB based devices.

Balakrishna Godavarthi (1):
  qca: update BT firmware files for QCA ROME chip.

 qca/nvm_usb_00000302.bin      | Bin 1953 -> 1996 bytes
 qca/rampatch_usb_00000302.bin | Bin 32940 -> 64168 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
