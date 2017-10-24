Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: Macbook Pro 2015, Bluetooth USB Host Controller bugfix (Looking
 for advice)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABYdM+0mQj_kLC0NHAjb=RFrX4Hnhz-qKL1s92gu0MSN6V4v7A@mail.gmail.com>
Date: Tue, 24 Oct 2017 16:06:08 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3AC23F0A-5562-4759-A957-DCF0B97E886B@holtmann.org>
References: <CABYdM+0mQj_kLC0NHAjb=RFrX4Hnhz-qKL1s92gu0MSN6V4v7A@mail.gmail.com>
To: VOID 001 <zhangjianqiu13@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I submitted a bug on Bugzilla before, about Macbook pro  2015 Bluetooth issue
> 
> Device
> ID 05ac:8290 Apple, Inc. Bluetooth Host Controller
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=197295
> 
> I tried to fix it myself first. And it seems that my fix works. Now no
> error message reported, and my Bluetooth speaker can produce sound
> 
> I am new to both kernel develop and Bluetooth / USB driver develop, so
> I spend some time investigating and finally I end up with a patch like
> this (necessary debugging code truncated)
> 
> 
> 
> @@ -1360,11 +1367,14 @@ static inline int __set_isoc_interface(struct
> hci_dev *hdev, int altsetting)
>       struct usb_interface *intf = data->isoc;
>       struct usb_endpoint_descriptor *ep_desc;
>       int i, err;
> +    /* Here isoc_tx_ep is not initialized */
> +    BT_INFO("[VOID]-__set_isoc_interface(3) called, altsetting = %d
> isoc_tx_ep = %p", altsetting, data->isoc_tx_ep);
> 
>       if (!data->isoc)
>               return -ENODEV;
> 
> -       err = usb_set_interface(data->udev, 1, altsetting);
> +    /* Here is what I changed */
> +       err = usb_set_interface(data->udev, 3, altsetting);
> 
> Then it works now. But obviously, it's a workaround not a bugfix. And
> I do not have other test cases (I only have one Bluetooth speaker)
> Could you please give me some advice on the following questions?
> 
> 1. Is this bug a Macbook Bluetooth USB Driver (btusb) bug? Or it's a
> Bluetooth device bug (Xiaomi Bluetooth speaker) I think it's a btusb
> bug, am I right?
> 2. Does this fix make sense?
> 3. Where can I get the specification of the certain device(i.e: ID =
> 05ac:8290) To see it's interface and altsetting definition

can you include the corresponding part for your device from /sys/kernel/debug/usb/devices. If you run this on a MacBook, then there should be some MacBook adapter specific printouts in dmesg. Can you include these as well.

Regards

Marcel

