Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [RFC v1 7/8] Bluetooth: hci_serdev: remove the
 HCI_UART_INIT_PENDING check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171117223543.32429-8-martin.blumenstingl@googlemail.com>
Date: Sun, 19 Nov 2017 09:21:19 +0100
Cc: Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-serial@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        linux-sunxi@googlegroups.com, linux-amlogic@lists.infradead.org,
        Larry.Finger@lwfinger.net
Message-Id: <56889A64-AFB2-454C-9889-FAA4C051168A@holtmann.org>
References: <20171117223543.32429-1-martin.blumenstingl@googlemail.com>
 <20171117223543.32429-8-martin.blumenstingl@googlemail.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

> The three-wire (H5) protocol is the only protocol which uses
> HCI_UART_INIT_PENDING.
> Unfortunately the protocol implementation never receives data with this
> check still in place. For the H5 protocol this means that the
> initialization never completes and thus the firmware download never
> starts. Even if the initialization would succeed later on the drivers
> would call hci_uart_init_ready() which schedules the registration which
> is currently not implemented by hci_serdev.c.
> 
> Removing the HCI_UART_INIT_PENDING check makes the code easier to read
> and also fixes the initalization of devices (implemented with the serdev
> library) which use the H5 protocol.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> drivers/bluetooth/hci_serdev.c | 3 ---
> 1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
> index e0e6461b9200..fe67eb6d4278 100644
> --- a/drivers/bluetooth/hci_serdev.c
> +++ b/drivers/bluetooth/hci_serdev.c
> @@ -333,9 +333,6 @@ int hci_uart_register_device(struct hci_uart *hu,
> 	else
> 		hdev->dev_type = HCI_PRIMARY;
> 
> -	if (test_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
> -		return 0;
> -

then lets also remove the flag definition itself. Or if that is still needed for some legacy operation, then describe this. For example I also see it used in hci_serdev.c and main question would be if it is used there as well or some legacy cruft.

Regards

Marcel

