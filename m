Return-Path: <cyrus@holtmann.org>
From: Markos Chandras <markos.chandras@gmail.com>
To: Luca Santarelli <hrk@users.sourceforge.net>
Subject: Re: [PATCH] bluetooth usb hci: ISSC usb dongle with buggy SCO  support
Date: Tue, 9 Dec 2008 15:49:19 +0200
Cc: Andrew Morton <akpm@linux-foundation.org>, marcel@holtmann.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200812050002.13560.hrk@users.sourceforge.net> <20081207001953.c04b9357.akpm@linux-foundation.org> <F469DC97-2EE0-4CE5-BB1C-7419B8A31985@users.sourceforge.net>
In-Reply-To: <F469DC97-2EE0-4CE5-BB1C-7419B8A31985@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812091549.19779.markos.chandras@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 09 December 2008 01:07:35 Luca Santarelli wrote:
> Il giorno 07/dic/08, alle ore 09:19, Andrew Morton ha scritto:
> > linux-next has:
> >
> > commit 12421b40b81d101d7535e03f1af197365adc932b
> > Author: Marcel Holtmann <marcel@holtmann.org>
> > Date:   Sun Nov 30 12:17:21 2008 +0100
> >
> >    Bluetooth: Remove deprecated hci_usb driver
> >
> >    The old hci_usb driver has been fully replaced with the new btusb
> > driver
> >    and all major distributions switched to the new driver now. This
> > removes
> >    it since it should not be used at all anymore.
> >
> > so please confirm that btusb correctly supports that hardware?
>
> Thanks for the heads up! I'll compile the new sources and let you know
> if it's supported. However, since the hci_usb is being deprecated but
> not removed, shouldn't the patch be incorporated nonetheless?
>
> Luca
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Seems to work fine on gentoo-sources-2.6.27-r5. Thank you all  :)
-- 
Markos Chandras
