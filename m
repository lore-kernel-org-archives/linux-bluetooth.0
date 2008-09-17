Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300809171409o45e6c3cbva4ac6e075bc6b184@mail.gmail.com>
Date: Wed, 17 Sep 2008 15:09:07 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "Bobby Beckmann" <bobby@optaros.com>
Subject: Re: Getting the driver to recognize my bluetooth device
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <48D16DA5.4070207@optaros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <48D16DA5.4070207@optaros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

you need to run hid2hci

here's another similar machine & notes.
http://www.avalpa.com/assets/andrea/studio15/debian_on_dell_studio15.html

On Wed, Sep 17, 2008 at 2:50 PM, Bobby Beckmann <bobby@optaros.com> wrote:
> Hi all,
>
> I'm trying to get my laptop's bluetooth chip to be recognized by the driver.
> I have a Dell Latitude E6500 running 2.6.27-rc6. From lsusb, I get this
> output:
>
> Bus 003 Device 002: ID 0a5c:4500 Broadcom Corp.
> Device Descriptor:
>  bLength                18
>  bDescriptorType         1
>  bcdUSB               2.00
>  bDeviceClass            9 Hub
>  bDeviceSubClass         0 Unused
>  bDeviceProtocol         0 Full speed (or root) hub
>  bMaxPacketSize0         8
>  idVendor           0x0a5c Broadcom Corp.
>  idProduct          0x4500
>  bcdDevice            1.00
>  iManufacturer           1 Broadcom
>  iProduct                2 BCM2046B1
>
>
>
> Now, the device is reporting that it's a hub, but the product is most
> certainly a bluetooth chip from Broadcom. I tried adding the 0a5c:4500 to
> the btusb driver, but the driver didn't seem to try to initialize the
> device. Does anyone have any ideas on what I could do to debug this?
>
> Thanks for your help,
> Bobby
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Brad
