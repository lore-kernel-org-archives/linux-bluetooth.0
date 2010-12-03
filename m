Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimiyxiKzT=9pKXLFACkc6C=nTD2dtBR7PcgjhOL@mail.gmail.com>
References: <AANLkTi=XTUau_GbASJEUBgsZ_FYYmRAX6W43YtRdv2wS@mail.gmail.com>
	<20101022135130.617f0ce8@lxorguk.ukuu.org.uk>
	<AANLkTinj93zAXJAipB3HjE62Xa1Z=9k9gPBxaT=+MLtg@mail.gmail.com>
	<20101029172443.61f7b067@pyx>
	<AANLkTimiyxiKzT=9pKXLFACkc6C=nTD2dtBR7PcgjhOL@mail.gmail.com>
Date: Fri, 3 Dec 2010 12:42:49 +0100
Message-ID: <AANLkTim7brB0JecKXDNddt0am=Um457Kfbm6bRG_yzFM@mail.gmail.com>
Subject: Re: [PATCH 5/9] mfd: Add UART support for the ST-Ericsson CG2900.
From: Vitaly Wool <vitalywool@gmail.com>
To: Par-Gunnar Hjalmdahl <pghatwork@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linus.walleij@stericsson.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Par,

On Fri, Dec 3, 2010 at 10:16 AM, Par-Gunnar Hjalmdahl
<pghatwork@gmail.com> wrote:
> 2010/10/29 Alan Cox <alan@lxorguk.ukuu.org.uk>:

> By the way, I will soon release a new patch set for CG2900 (hopefully
> next week), which contains major rework. It's hard to explain
> everything here and now but changes include:
> =A0- Reuse of existing HCI line discipline under /drivers/bluetooth/.
> Line discipline has been modified so it is selectable from protocol if
> line discipline should register to Bluetooth stack or not.

So is it true that if there's the other chip with similar
functionality I have to implement support for, I'll have to pretty
much duplicate your line discipline driver?

Isn't it better to have a new line discipline that the standard
drivers (H4, LL, ...) will be applicable to?

~Vitaly
