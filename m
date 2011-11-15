Return-Path: <cyrus@holtmann.org>
Subject: Re: Building master on Debian systems fails at linking "check".
From: Marcel Holtmann <marcel@holtmann.org>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Brian Gix <bgix@codeaurora.org>, linux-bluetooth@vger.kernel.org
Date: Tue, 15 Nov 2011 11:25:15 +0900
In-Reply-To: <20111114225100.c75e709827f4b22fa83e0327@studenti.unina.it>
References: <20111114155620.4fc2987fad25c9ccd724f68a@studenti.unina.it>
	 <4EC15A27.90305@codeaurora.org>
	 <20111114225100.c75e709827f4b22fa83e0327@studenti.unina.it>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321323919.15441.475.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antonio,

> > > The workaround I use for now is:
> > >    - run "make" and let the build system fail
> > >    - show the  failing command with "make V=1"
> > >    - change -lcheck to -lcheck_pic and rerun the command
> > >    - "make" will now proceed with the build
> > 
> > 
> > This same solution works for me:  After running ./bootstrap-configure, I 
> > change the unit_test_eir_LDADD line in the Makefile to:
> > 
> > unit_test_eir_LDADD = lib/libbluetooth-private.la -lglib-2.0   -lcheck_pic
> >
> 
> Eh Brian, this is surely a little prettier than what I am doing :)
> 
> > There is probably a way to make this happen automatically, but I don't 
> > know enough about the configure mechanism to know how to do this.
> >
> 
> I think using a “libcheck_pic aware” m4 macro is the way to go, ideally
> this should be provided in the check package itself, I'll try asking the
> Debian maintainers if there is no interest for a solution in BlueZ.

why on earth does Debian has to do everything different than any other
distribution. I am getting pretty sick of that :(

The easiest way is to just disable any kind of unit testing when the
check support is not found. Simple as that. I am not bothering to make
this work on Debian.

Regards

Marcel


