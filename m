Return-Path: <cyrus@holtmann.org>
Message-ID: <1322221156.29909.11.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Remove magic bluetooth version numbers
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 25 Nov 2011 12:39:16 +0100
In-Reply-To: <20111123151914.GC4066@aemeltch-MOBL1>
References: <1322040215-640-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322040215-640-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322059738.29909.6.camel@aeonflux> <20111123151914.GC4066@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > > +/* Bluetooth versions */
> > > +#define BLUETOOTH_VER_1_1	1
> > > +#define BLUETOOTH_VER_1_2	2
> > > +#define BLUETOOTH_VER_2_0_EDR	3
> > > +
> > 
> > I am fine with the patch, but you need to use BLUETOOTH_VER_2_0 here
> > since you have have 2.0 without EDR. Have a fun night reading with the
> > Bluetooth SIG branding guidelines.
> 
> OK, I will remove EDR at the end. BTW: on a bluetooth web site there seems
> to be different interpretation of those numbers:
> 
> Parameter Name 	Assigned Values
> HCI_Version 	
>         0 	Bluetooth Core Specification 1.0b
>   	1 	Bluetooth Core Specification 1.1
>   	2 	Bluetooth Core Specification 1.2
>   	3 	Bluetooth Core Specification 2.0 + EDR
>   	4 	Bluetooth Core Specification 2.1 + EDR
>   	5 	Bluetooth Core Specification 3.0 + HS
>   	6 	Bluetooth Core Specification 4.0
>   	7 - 255 	Reserved

they are actually wrong. The + XXX suffix is described in the Bluetooth
branding guidelines.

For example you can only call your product 3.0 + HS if you have a 2.1 or
3.0 controller (yes 2.1 is fine as well) with an AMP controller and
support for High Speed.

So the + XXX is pure product branding and has nothing to do with HCI or
LMP versions.

Regards

Marcel


