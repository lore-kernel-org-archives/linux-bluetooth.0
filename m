Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH 0/3] Enable Bluetooth functionality for WCN3990
Date: Fri,  6 Apr 2018 17:22:23 +0530
Message-Id: <1523015546-994-1-git-send-email-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

These patches enable Bluetooth functionality for WCN3990 by 
- adding support for voting of voltage regulators for WCN3990 attached to MSM
- Bluetooth firmware download support for WCN3990
- description of device tree bindings

Balakrishna Godavarthi (1):
  Bluetooth: Added support for wcn3990 soc.

Rupesh Tatiya (2):
  Bluetooth: Add device tree bindings for Atheros chips
  Add support to power Bluetooth QCA chips attached to MSM

 .../devicetree/bindings/bluetooth/btqca_power.txt  |  30 ++
 drivers/bluetooth/Makefile                         |   5 +-
 drivers/bluetooth/btqca.c                          | 393 ++++++++++++++++-----
 drivers/bluetooth/btqca.h                          |  46 ++-
 drivers/bluetooth/btqca_power.c                    | 177 ++++++++++
 drivers/bluetooth/btqca_power.h                    |  71 ++++
 drivers/bluetooth/hci_qca.c                        | 324 ++++++++++++++---
 include/net/bluetooth/hci_core.h                   |   3 +-
 net/bluetooth/hci_core.c                           |   2 +-
 net/bluetooth/hci_request.c                        |  23 ++
 net/bluetooth/hci_request.h                        |   2 +
 11 files changed, 942 insertions(+), 134 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bluetooth/btqca_power.txt
 create mode 100644 drivers/bluetooth/btqca_power.c
 create mode 100644 drivers/bluetooth/btqca_power.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
