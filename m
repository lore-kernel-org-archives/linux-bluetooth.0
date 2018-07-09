Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	mka@chromium.org
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	hemantg@codeaurora.org,
	c-hbandi@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 0/1] Enable subsystem restart for Qualcomm bluetooth chip wcn3990.
Date: Mon,  9 Jul 2018 21:46:56 +0530
Message-Id: <20180709161657.26609-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

In many platforms Bluetooth chip wcn3990 is a discrete chip connected 
via UART lines to app processor. if the chip goes into bad state 
i.e. into hard fault exception routine, which will not further respond 
to any commands from HOST via UART. In that case wcn3390 will intimate 
HOST by generating hardware error. Host stack will initiate a close 
and reopen of the hci driver. Prior to sending hard ware error, wcn3990 
has a capability of sending the RAM dump i.e. memory dump of the BT chip. 
this will help us to fix stability issues of the SoC. We at QCA driver 
read the dump packets and store via devcoredump(). 
We perform restart after collecting the ram dump of the SoC.


Harish Bandi (1):
  Bluetooth: hci_qca: Sub system restart support for WCN3990

 drivers/bluetooth/btqca.h   |   8 ++
 drivers/bluetooth/hci_qca.c | 261 ++++++++++++++++++++++++++++++++++++
 2 files changed, 269 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
