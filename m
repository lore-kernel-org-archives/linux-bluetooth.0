Return-Path: <zhangjianqiu13@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171024174245.34605-1-marcel@holtmann.org>
References: <20171024174245.34605-1-marcel@holtmann.org>
From: VOID 001 <zhangjianqiu13@gmail.com>
Date: Wed, 25 Oct 2017 10:06:29 +0800
Message-ID: <CABYdM+3deBn7B3Vz-Asv=SS62yFHAGJP4yfQWTjrE58Sb1sjaw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fix isochronous interface assignments
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 25, 2017 at 1:42 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> The recent MacBook's with multi-function USB interfaces for HID and
> Bluetooth operation have the isochronous interface on number 3 instead
> of number 1. Store the interface number and use it.
>
> P:  Vendor=05ac ProdID=8290 Rev= 1.40
> S:  Manufacturer=Broadcom Corp.
> S:  Product=Bluetooth USB Host Controller
> C:* #Ifs= 6 Cfg#= 1 Atr=e0 MxPwr=  0mA
> A:  FirstIf#= 2 IfCount= 4 Cls=ff(vend.) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
> E:  Ad=85(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
> I:* If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
> E:  Ad=86(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 3 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 3 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 3 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 3 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 3 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
> E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index c054d7bce490..c85022efce92 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -396,6 +396,7 @@ struct btusb_data {
>         struct usb_interface *intf;
>         struct usb_interface *isoc;
>         struct usb_interface *diag;
> +       unsigned isoc_ifnum;
>
>         unsigned long flags;
>
> @@ -1359,7 +1360,7 @@ static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
>         if (!data->isoc)
>                 return -ENODEV;
>
> -       err = usb_set_interface(data->udev, 1, altsetting);
> +       err = usb_set_interface(data->udev, data->isoc_ifnum, altsetting);
>         if (err < 0) {
>                 BT_ERR("%s setting interface failed (%d)", hdev->name, -err);
>                 return err;
> @@ -3106,6 +3107,7 @@ static int btusb_probe(struct usb_interface *intf,
>         } else {
>                 /* Interface orders are hardcoded in the specification */
>                 data->isoc = usb_ifnum_to_if(data->udev, ifnum_base + 1);
> +               data->isoc_ifnum = ifnum_base + 1;
>         }
>
>         if (!reset)
> --
> 2.13.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi Holtmann(sorry for the previous impolite call and a mistake in
emailing the mail to your personal mailbox),

Glad to see my advice helps
I am interested in kernel develop, Willing to send patches for kernel
(In fact, this one is my first attempt, but I found the patch format
and email recipient is incorrect)
Are there any tasks I can work on in Bluetooth / USB module? Could you
please give me some advise / task to work on?
I am totally new to Bluetooth / USB driver develop, but I can learn by
doing. I want to kickstart here.

Thanks in advance.
