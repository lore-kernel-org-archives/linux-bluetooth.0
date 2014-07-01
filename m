Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <16AC594D-6B3C-4CB6-B951-0763F3E4E27A@holtmann.org>
References: <1404218878-14218-1-git-send-email-drake@endlessm.com>
	<16AC594D-6B3C-4CB6-B951-0763F3E4E27A@holtmann.org>
Date: Tue, 1 Jul 2014 15:18:13 +0100
Message-ID: <CAD8Lp45HbA03MycDVu6akTfEET_ZzxrwGpH1TbiQrw5Z178aeA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add Realtek 8723/8761 support
From: Daniel Drake <drake@endlessm.com>
To: Marcel Holtmann <marcel@holtmann.org>, Larry.Finger@lwfinger.net
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 1, 2014 at 2:41 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>         .driver_info = BTUSB_RTK | BTUSB_RTL...
>
> The think with RTL vs RTK is now confusing me even more. So what are the official model numbers from Realtek anyway. Maybe we should start using them now and not bother carrying around some legacy from the Ethernet or WiFi drivers.

The product codes are RTLxxxx so perhaps I will update it to use 'rtl'
instead of 'rtk' everywhere. That 'rtk' just came from the vendor
driver. Maybe Larry has some knowledge of the conventions here.

> There is also no generic vendor command that we can run first to get the model information? Do we really need to use USB vendor and product ids to pick the right one. I personally hate using vendor and product ids.

I'm no expert on this hardware, just happened to receive one instance,
and then found the vendor driver on Larry's github. The vendor driver
uses USB IDs for this purpose, and I don't have any extra insight (nor
access to other devices).

However, I just noticed that we only have 2 of the 7 main firmware
files available. Larry, do you have all of the ones mentioned in the
driver? e.g. ones like rtl8761aw8192eu_fw are missing from your repo.

Googling around, it looks like these other devices are really not
common, maybe we should just reduce it to RTL8723A and RTL8723B
support, especially if we don't have firmware for the others. There is
only 1 type of firmware for each variant there, the code would be
simpler, no need for VID/PID lookup. That would be enough to make me
happy, plus all the people filing issues on Larry's github.

Only caveat there is that someone might push us to return to the
RTL8761 mess (different firmware for different VID/PID) some day.

Daniel
