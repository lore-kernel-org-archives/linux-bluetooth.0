Return-Path: <pavouk@pavouk.org>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Unidentified Bluetooth CF card
Date: Wed, 15 Sep 2004 14:20:52 +0200
Cc: Paul Hedderly <bulkpaul@mjr.org>, Marcel Holtmann <marcel@holtmann.org>
References: <20040915090305.GL26469@wacka.mjr.org> <1095248205.5263.57.camel@pegasus> <20040915120413.GN26469@wacka.mjr.org>
In-Reply-To: <20040915120413.GN26469@wacka.mjr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409151420.52324.pavouk@pavouk.org>
List-ID: <bluez-users.lists.sourceforge.net>

Hello,

> I've just tried again - tried
> any,ericsson,digi,csr,bboxes,xircom,swave,bcsp...
>
> No luck. I tried any with various speeds - no luck.
>
> Does it matter that this card definately has the Oxford Semi OXCF950
> UART? hciattach does not seem to have any special init code for it,
> unlike the various other uarts.
>
> Any more ideas?

What kernel do you use. Before few weeks Marcel writes, that there are problem 
in linux serial driver in 2.6 kernel tree. Some cards with UART doesn't work.
I don't know, if problem is still here, but you can try 2.4 kernel with 
hciattach...

Best regards,

Pavel Ruzicka
