Return-Path: <cyrus@holtmann.org>
From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Andy Gross
	<agross@codeaurora.org>
CC: <linux-arm-msm@vger.kernel.org>, Fengwei Yin <fengwei.yin@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	<linux-kernel@vger.kernel.org>, <linux-soc@vger.kernel.org>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH v2 0/7] Qualcomm WCNSS HCI support
Date: Fri, 9 Oct 2015 13:47:58 -0700
Message-ID: <1444423685-14717-1-git-send-email-bjorn.andersson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

After trying to avoid implementing multi-channel support in SMD in v1 of
the HCI driver for Qualcomm WCNSS BT, this new version includes the
necessary SMD refactoring and additon of an API that allows SMD devices
to call back into the SMD core to acquire additonal channels.

The additional channels are tied to the existing SMD device and the life
cycle of the new channel will be tied to, and affect, the original
channel.

With this in place the btqcomsmd driver is refactored into being a
single driver, without global state.

Bjorn Andersson (7):
  soc: qcom: smd: Introduce callback setter
  soc: qcom: smd: Split discovery and state change work
  soc: qcom: smd: Refactor channel open and close handling
  soc: qcom: smd: Support multiple channels per sdev
  soc: qcom: smd: Support opening additional channels
  Bluetooth: Add HCI device identifier for Qualcomm SMD
  Bluetooth: hci_smd: Qualcomm WCNSS HCI driver

 drivers/bluetooth/Kconfig     |  11 ++
 drivers/bluetooth/Makefile    |   1 +
 drivers/bluetooth/btqcomsmd.c | 198 ++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/smd.c        | 228 +++++++++++++++++++++++++++++++-----------
 include/linux/soc/qcom/smd.h  |   8 +-
 include/net/bluetooth/hci.h   |   1 +
 6 files changed, 387 insertions(+), 60 deletions(-)
 create mode 100644 drivers/bluetooth/btqcomsmd.c

-- 
2.4.2
