Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 0/4] TI Bluetooth serdev support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170413150353.7389-1-robh@kernel.org>
Date: Thu, 13 Apr 2017 19:24:30 +0200
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>, Eyal Reizer <eyalr@ti.com>,
        Satish Patel <satish.patel@linaro.org>,
        Network Development <netdev@vger.kernel.org>,
        devicetree@vger.kernel.org
Message-Id: <A73F0F81-63B4-4555-9865-F35469902338@holtmann.org>
References: <20170413150353.7389-1-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rob,

> This series adds serdev support to the HCI LL protocol used on TI BT
> modules and enables support on HiKey board with with the WL1835 module.
> With this the custom TI UIM daemon and btattach are no longer needed.
> 
> The series is available on this git branch[1]. This version is rebased on 
> bluetooth-next tree containing its dependencies.
> 
> Rob
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git ti-bluetooth
> 
> Rob Herring (4):
>  dt-bindings: net: Add TI WiLink shared transport binding
>  bluetooth: hci_uart: remove unused hci_uart_init_tty
>  bluetooth: hci_uart: add LL protocol serdev driver support
>  arm64: dts: hikey: add WL1835 Bluetooth device node
> 
> .../devicetree/bindings/net/ti,wilink-st.txt       |  35 +++
> arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   5 +
> drivers/bluetooth/hci_ldisc.c                      |  19 --
> drivers/bluetooth/hci_ll.c                         | 262 ++++++++++++++++++++-
> drivers/bluetooth/hci_uart.h                       |   1 -
> 5 files changed, 301 insertions(+), 21 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/net/ti,wilink-st.txt

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

