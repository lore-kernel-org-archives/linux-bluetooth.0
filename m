Return-Path: <bulkpaul@mjr.org>
Date: Wed, 15 Sep 2004 13:26:12 +0100
From: Paul Hedderly <bulkpaul@mjr.org>
To: Pavel Ruzicka <pavouk@pavouk.org>
Cc: bluez-users@lists.sourceforge.net, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Unidentified Bluetooth CF card
Message-ID: <20040915122612.GO26469@wacka.mjr.org>
References: <20040915090305.GL26469@wacka.mjr.org> <1095248205.5263.57.camel@pegasus> <20040915120413.GN26469@wacka.mjr.org> <200409151420.52324.pavouk@pavouk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409151420.52324.pavouk@pavouk.org>
List-ID: <bluez-users.lists.sourceforge.net>

I am using kernel 2.4.27-mh1

Note - a few of the hciattach attempts cause an error but most 'work'
but hciconfig shows a card with no 'mac' address, and which does not
work.

--
Paul

On Wed, Sep 15, 2004 at 02:20:52PM +0200, Pavel Ruzicka wrote:
> Hello,
> 
> > I've just tried again - tried
> > any,ericsson,digi,csr,bboxes,xircom,swave,bcsp...
> >
> > No luck. I tried any with various speeds - no luck.
> >
> > Does it matter that this card definately has the Oxford Semi OXCF950
> > UART? hciattach does not seem to have any special init code for it,
> > unlike the various other uarts.
> >
> > Any more ideas?
> 
> What kernel do you use. Before few weeks Marcel writes, that there are problem 
> in linux serial driver in 2.6 kernel tree. Some cards with UART doesn't work.
> I don't know, if problem is still here, but you can try 2.4 kernel with 
> hciattach...
> 
> Best regards,
> 
> Pavel Ruzicka
