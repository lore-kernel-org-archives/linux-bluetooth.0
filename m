Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1240169747-15998-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1240169747-15998-1-git-send-email-gustavo@las.ic.unicamp.br>
Date: Thu, 23 Apr 2009 12:57:48 -0300
Message-ID: <6b53b1990904230857p22c97be7oa8bd6fb66d4a6c72@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: add support for Integrated System Solution
	devices
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Apr 19, 2009 at 4:35 PM, Gustavo F. Padovan
<gustavo@las.ic.unicamp.br> wrote:
> Just add the device id to btusb. I tested with obexd and hcitool info
> <baddr> and it works. But there is an issue yet, l2ping disconnects after
> 10 seconds.
>
> Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
> ---
>  drivers/bluetooth/btusb.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index e70c57e..9df83a7 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -131,6 +131,9 @@ static struct usb_device_id blacklist_table[] = {
>        { USB_DEVICE(0x08fd, 0x0001), .driver_info = BTUSB_DIGIANSWER },
>        { USB_DEVICE(0x08fd, 0x0002), .driver_info = BTUSB_IGNORE },
>
> +       /* Integrated System Solution devices */
> +       { USB_DEVICE(0x1131, 0x1004), .driver_info = BTUSB_WRONG_SCO_MTU },
> +
>        /* CSR BlueCore Bluetooth Sniffer */
>        { USB_DEVICE(0x0a12, 0x0002), .driver_info = BTUSB_SNIFFER },
>
> --
> 1.6.0.6


Proving that we need this:

before patch:
 - /proc/bus/usb/devices: http://pastebin.com/m18d4d0a1
 - hciconfig -a: http://pastebin.com/m44e553cb

after patch:
 - /proc/bus/usb/devices:http://pastebin.com/m5d7add7d
 - hciconfig -a: http://pastebin.com/m58522f0c

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Gustavo F. Padovan

Computer Engineering Student
Institute of Computing - IC
University of Campinas - UNICAMP

email: gustavo@las.ic.unicamp.br
irc: padovan at freenode.net
mobile: +55 19 81030803
