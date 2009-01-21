Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1232291616.5095.13.camel@californication>
References: <b3f4dcd00901161441n6e2d98e6l193bcc8372fd2bc8@mail.gmail.com>
	 <1232291616.5095.13.camel@californication>
Date: Wed, 21 Jan 2009 21:32:48 +1300
Message-ID: <b3f4dcd00901210032g2d0056afx2e03077272436046@mail.gmail.com>
Subject: Re: Dell Wireless 360 Bluetooth HID devices not being remembered over
	suspend/reboot
From: Matthew Grant <matthewgrant5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Been a few days as I have been busy.

On Mon, Jan 19, 2009 at 4:13 AM, Marcel Holtmann <marcel@holtmann.org> wrote:

> check with "hciconfig hci0 revision" and "bccmd buildname" (both as
> root) if they have a special Dell firmware running on it. If not then
> there can be still a Dell custom application running in the VM of the
> Bluetooth chip.

Here they go:

en-gedi: -root- [~]
# bccmd buildname
Build name: cyt_8unified_fl_bt2.0_kymodo_21d_0702212310_encr56 2007-02-21

en-gedi: -root- [~]
# hciconfig hci0 revision
hci0:	Type: USB
	BD Address: 00:21:86:D0:37:F0 ACL MTU: 310:10 SCO MTU: 64:8
	Build 4315
	Chip version: BlueCore4-External
	Max key size: 56 bit
	SCO mapping:  HCI

Does this show anything unusual? I don't think this thing is standard.
 Running Vista home, everything works across reboots.  I did this as a
lot of the information posted about Dell computers suggested doing
this.  I am also going to try running 3.36 bluez and see if that
helps.

> Best bet is to ask Mario from Dell if he can help us out here and maybe
> make HID/HCI switching persistent across reboots. If not then we might
> have to write a bluetoothd plugin that does the job for us.

Is Mario on this list?  It would be good  if he is party to this.

Thanks for getting back to me!

Regards,

Matthew Grant
