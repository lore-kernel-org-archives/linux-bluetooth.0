Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/3] arm64: hi6220-hikey: Fix Bluetooth support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1496826502-1339-1-git-send-email-ulf.hansson@linaro.org>
Date: Fri, 9 Jun 2017 07:49:13 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Satish Patel <satish.patel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Message-Id: <85B2CA30-73CC-41A9-8CE5-937825D85952@holtmann.org>
References: <1496826502-1339-1-git-send-email-ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulf,

> The commit ea452678734e ("arm64: dts: hikey: Fix WiFi support") indeed managed
> to fix the WiFi support for the Hikey board. However, it also caused the
> Bluetooth to break.
> 
> The reason to the problem is because part of the fixes for WiFi, involved
> explicitly to start manage the external clock for the TI WiLink chip, as it's
> needed to properly power on/off WiFi. Then, because the Bluetooth driver,
> hci_ll, don't manage the clock, it fails to initialize Bluetooth.
> 
> This small series add support and DT bindings for the external clock, now
> properly managed by the hci_ll driver during power on/off. On top of that, the
> external clock is added to the Bluetooth DT node in the Hikey DTS file.
> 
> The regression has been reported by John Stultz, running a Hikey board with
> UEFI based boot. I have confirmed that there is no regressions with u-boot as
> we still don't have bluetooth working on that set up. I intend to fix that as
> well, although in second step and not being part of a fixup series.
> 
> John, can you please confirm/test this on your Hikey board using UEFI!?
> 
> Perhaps this can go in via the bluetooth git, when respective patches has got
> an ack. Or whatever you think is best.
> 
> Ulf Hansson (3):
>  dt-bindings: net: Add binding for the external clock for TI WiLink
>  Bluetooth: hci_ll: Add support for the external clock
>  arm64: dts: hikey: Add external clock to the Bluetooth node
> 
> Documentation/devicetree/bindings/net/ti,wilink-st.txt |  6 ++++++
> arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts         |  2 ++
> drivers/bluetooth/hci_ll.c                             | 14 +++++++++++++-
> 3 files changed, 21 insertions(+), 1 deletion(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

