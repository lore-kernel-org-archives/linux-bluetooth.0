Return-Path: <johan.hedberg@gmail.com>
Date: Wed, 16 Aug 2017 18:02:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_bcm: Use operation speed of 4Mbps only
 for ACPI devices
Message-ID: <20170816150238.GA1577@x1c.home>
References: <20170816075330.45923-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170816075330.45923-1-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Aug 16, 2017, Marcel Holtmann wrote:
> Not all Broadcom controller support the 4Mbps operational speed on UART
> devices. This is because the UART clock setting changes might not be
> supported.
> 
>   < HCI Command: Broadcom Write UART Clock Setting (0x3f|0x0045) plen 1
>          01                                               .
>   > HCI Event: Command Complete (0x0e) plen 4
>        Broadcom Write UART Clock Setting (0x3f|0x0045) ncmd 1
>          Status: Unknown HCI Command (0x01)
> 
> To support any operational speed higher than 3Mbps, support for this
> command is required. With that respect it is better to not enforce any
> operational speed by default. Only when its support is known, then allow
> for higher operational speed.
> 
> This patch assigns the 4Mbps opertional speed only for devices
> discovered through ACPI and leave all others at the default 115200.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_bcm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
