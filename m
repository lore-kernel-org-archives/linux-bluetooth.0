Return-Path: <johan.hedberg@gmail.com>
Date: Thu, 17 Aug 2017 22:53:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_bcm: Handle empty packet after firmware
 loading
Message-ID: <20170817195347.GA30072@x1c.home>
References: <20170817194109.80439-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170817194109.80439-1-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Aug 17, 2017, Marcel Holtmann wrote:
> The Broadcom controller on the Raspberry Pi3 sends an empty packet with
> packet type 0x00 after launching the firmware. This will cause logging
> of errors.
> 
>   Bluetooth: hci0: Frame reassembly failed (-84)
> 
> Since this seems to be an intented behaviour of the controller, handle
> it gracefully by parsing that empty packet with packet type 0x00 and
> then just simply report it as diagnostic packet.
> 
> With that change no errors are logging and the packet itself is actually
> recorded in the Bluetooth monitor traces.
> 
>   < HCI Command: Broadcom Launch RAM (0x3f|0x004e) plen 4
>          Address: 0xffffffff
>   > HCI Event: Command Complete (0x0e) plen 4
>        Broadcom Launch RAM (0x3f|0x004e) ncmd 1
>          Status: Success (0x00)
>   = Vendor Diagnostic (len 0)
>   < HCI Command: Broadcom Update UART Baud Rate (0x3f|0x0018) plen 6
>          00 00 00 10 0e 00                                ......
>   > HCI Event: Command Complete (0x0e) plen 4
>        Broadcom Update UART Baud Rate (0x3f|0x0018) ncmd 1
>          Status: Success (0x00)
>   < HCI Command: Reset (0x03|0x0003) plen 0
>   > HCI Event: Command Complete (0x0e) plen 4
>        Reset (0x03|0x0003) ncmd 1
>          Status: Success (0x00)
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_bcm.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
