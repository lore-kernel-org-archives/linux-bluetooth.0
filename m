Return-Path: <bjorn@mork.no>
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, Hon Weng Chong <honwchong@gmail.com>
Subject: Re: [PATCH] bluetooth: btusb: Add device ID for RTL8822BE
References: <20171111174326.9243-1-Larry.Finger@lwfinger.net>
	<82ACB0CF-DD2F-4A44-A2F0-75D1C1B3DA9C@holtmann.org>
Date: Sun, 12 Nov 2017 14:45:50 +0100
In-Reply-To: <82ACB0CF-DD2F-4A44-A2F0-75D1C1B3DA9C@holtmann.org> (Marcel
	Holtmann's message of "Sat, 11 Nov 2017 19:51:36 +0100")
Message-ID: <87k1yvip9t.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann <marcel@holtmann.org> writes:

>> +	{ USB_DEVICE(0x0b05, 0x1185c), .driver_info =3D BTUSB_REALTEK },
>> +
>
> I prefer to have /sys/kernel/debug/usb/devices for the device included in=
 the commit message.

...and 0x1185c is a typp


Bj=C3=B8rn
