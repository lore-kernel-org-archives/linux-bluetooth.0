Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v7 3/3] Bluetooth: btusb: Configure Marvell to use one of
 the pins for oob wakeup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170201222410.145612-3-rajatja@google.com>
Date: Thu, 16 Feb 2017 17:22:42 +0100
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Xinming Hu <huxm@marvell.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Brian Norris <briannorris@google.com>,
        linux-kernel@vger.kernel.org, rajatxjain@gmail.com
Message-Id: <B13DDD1D-479B-4B13-BB6B-ED103A59158A@holtmann.org>
References: <20170201222410.145612-1-rajatja@google.com>
 <20170201222410.145612-3-rajatja@google.com>
To: Rajat Jain <rajatja@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> The Marvell devices may have many gpio pins, and hence for wakeup
> on these out-of-band pins, the chip needs to be told which pin is
> to be used for wakeup, using an hci command.
> 
> Thus, we read the pin number etc from the device tree node and send
> a command to the chip.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> v7: Same as v6
> v6: same as v5
> v5: same as v5
> v4: same as v3
> v3: * remove the Marvell specific id table and check
>    * Add reference to marvell-bt-8xxx.txt in btusb.txt
>    * Add "Reviewed-by" and "Acked-by"    
> v2: Fix the binding document to specify to use "wakeup" interrupt-name
> 
> Documentation/devicetree/bindings/net/btusb.txt    |  3 ++
> .../{marvell-bt-sd8xxx.txt => marvell-bt-8xxx.txt} | 46 +++++++++++++++----
> drivers/bluetooth/btusb.c                          | 51 ++++++++++++++++++++++
> 3 files changed, 92 insertions(+), 8 deletions(-)
> rename Documentation/devicetree/bindings/net/{marvell-bt-sd8xxx.txt => marvell-bt-8xxx.txt} (50%)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel
