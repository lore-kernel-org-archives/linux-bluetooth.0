Return-Path: <bulkpaul@mjr.org>
Date: Wed, 15 Sep 2004 13:04:13 +0100
From: Paul Hedderly <bulkpaul@mjr.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Unidentified Bluetooth CF card
Message-ID: <20040915120413.GN26469@wacka.mjr.org>
References: <20040915090305.GL26469@wacka.mjr.org> <1095248205.5263.57.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1095248205.5263.57.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

On Wed, Sep 15, 2004 at 01:36:46PM +0200, Marcel Holtmann wrote:
> Hi Paul,
> 
> > I think it's a 'Mavin' - there are pictures of the front and back at:
> > 	http://mjr.org/bt/front.jpg
> > 	http://mjr.org/bt/back.jpg
> > 	http://mjr.org/bt/inside.jpg
> > 	http://mjr.org/bt/closeup.jpg
> > 
> > The main chips inside (to save you needing to to the pics :O) are:
> > 	OXCF950
> > 	BC212
> > 	29LV800BA-90
> > 
> > And the markings are:
> > 	Model No.:MCF-M2.1
> > 	60m
> > 	S/N:MCF 0001773
> > 	Made in Taiwan
> > 
> 
> try to use serial_cs and then use hciattach with the correct parameters.
> 

Thanks for the prompt replies guys - much appreciated!

I'm sorry - I forgot to mention that I had tried serial_cs and
hciattach.

I've just tried again - tried any,ericsson,digi,csr,bboxes,xircom,swave,bcsp...

No luck. I tried any with various speeds - no luck.

Does it matter that this card definately has the Oxford Semi OXCF950
UART? hciattach does not seem to have any special init code for it,
unlike the various other uarts.

Any more ideas?

--
Paul
