Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHkwNTnSb4nuJ1dY371Zi007wH3_wGUQfKqevZaGkk9xRZUeNg@mail.gmail.com>
References: <CAHkwNT=sQQz11YWsxivxb20mW7rh1U=CXTN7uyBqTzkXvNbXgA@mail.gmail.com>
	<37D1ED5D-6FF5-4ABA-BD2A-222261BE1EAA@holtmann.org>
	<CAHkwNT=3m4nU5M_Kk5htfDonqPrKZO5vRR0q_8Mn2O=umGMK5Q@mail.gmail.com>
	<B4AA2825-8C58-46FB-A529-7CC910920500@holtmann.org>
	<CAHkwNT=Hoc4xibrtg2zk7K1vwcutcWgUHAN58XpWH0jnqfLXbg@mail.gmail.com>
	<CAHkwNTnSb4nuJ1dY371Zi007wH3_wGUQfKqevZaGkk9xRZUeNg@mail.gmail.com>
Date: Sun, 4 Oct 2015 00:10:00 +0530
Message-ID: <CAHkwNTmnE-WT-mn2FfAiNuujpwyFUbS+KGYoLE4kYUhB7spuQg@mail.gmail.com>
Subject: Re: Issues With USB Bluetooth Dongle
From: Anil Nair <anilcoll90@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I was exploring the linux source 4.2.2, I came accross the following
in the btusb.c,

static const struct usb_device_id blacklist_table[] = {
    /* CSR BlueCore devices */
    { USB_DEVICE(0x0a12, 0x0001), .driver_info = BTUSB_CSR },

That is the VID and PID of my device,

Bus 003 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bluetooth Dongle (HCI mode)

Its listed in blacklist is this the reason why the usb bluetooth
dongle is not working?

--
Regards,
Anil Nair
