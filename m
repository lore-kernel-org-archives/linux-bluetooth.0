Return-Path: <cyrus@holtmann.org>
Message-ID: <051401c8d314$821ca0a0$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <038c01c8d152$2d0fc1f0$6701a8c0@freqonedev> <1213801443.19872.6.camel@violet.holtmann.net> <04fa01c8d2f6$65597b50$6701a8c0@freqonedev> <1213981677.25820.57.camel@violet>
Subject: Secure Simple Pairing (SSP)
Date: Fri, 20 Jun 2008 15:30:38 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

WRT SSP: Fair enough...thanks.

In the meantime I will try to restrict the remote side to pairing using passkey/PIN.

DS

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "David Stockwell" <dstockwell@frequency-one.com>
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Sent: Friday, June 20, 2008 12:07 PM
Subject: Re: [Bluez-devel] Next Release, and Device.DiscoverServices


Hi David,

> Thanks for the feedback.  Upgrading to 3.33 resolved the immediate problem with accessing UUIDs, and I do get the correct UUID 
> from
> the remote (hurray!).
>
> FWIW, with SSP I intend to use only the "Just Works" model at this point, keeping the handshake as simple as possible (not a 
> highly
> secure application).  So, the capability parameter will be "NoInputOutput", if I am reading the code correctly (adapter.c).
> Hopefully, that will "JustWork", and I can proceed with the effort I originally undertook.  At any rate, I will be watching CVS
> closely...

you will need some kernel patches to make SSP work. I am going to
publish them soon. Just finished the last testing of unlikely error and
corner cases.

Regards

Marcel
