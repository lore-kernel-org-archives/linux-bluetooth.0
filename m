Return-Path: <sean.wang@mediatek.com>
From: <sean.wang@mediatek.com>
To: <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v4 0/2] Bluetooth: mediatek: Add protocol support for MediaTek USB devices
Date: Mon, 3 Sep 2018 22:08:22 +0800
Message-ID: <cover.1535983416.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

v4:
* use new BTUSB_TX_WAIT_VND_EVT instead of BTMTKUSB_TX_WAIT_VND_EVT
  to avoid definition conflict and to fix bulk data transfer fails.
* use the bluetooth-next as the base

v3:
add fixes and enhancements based on [1]
* reuse flags and evt_skb btusb already had
* add ctrl_anchor and the corresponding handling
* apply mtk specific recv function
* add more comments explaining wmt ctrl urbs behavior.

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014724.html

v2:

add fixes and enhancements based on [1]
* include /sys/kernel/debug/usb/devices portion in the commit message.
* turn default into n for config BT_HCIBTUSB_MTK in Kconfig
* only add MediaTek support to btusb.c
* drop cmd_sync callback usage
* use __hci_cmd_send to send WMT commands
* add wait event handling similar to what is being done in btmtkuart.c
* submit a control IN URB similar to interrupt IN URB on demand for the WMT
  commands during setup 
* add cosmetic changes

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014650.html
http://lists.infradead.org/pipermail/linux-mediatek/2018-August/014656.html

v1:

This adds the support of enabling MT7668U and MT7663U Bluetooth
function running on the top of btusb driver. The patch also adds
a newly created file mtkbt.c able to be reused independently from
the transport type such as UART, USB and SDIO.

Sean Wang (2):
  Bluetooth: mediatek: Add protocol support for MediaTek MT7668U USB
    devices
  Bluetooth: mediatek: Add protocol support for MediaTek MT7663U USB
    devices

 drivers/bluetooth/Kconfig |  11 +
 drivers/bluetooth/btusb.c | 552 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 563 insertions(+)

-- 
2.7.4
