Return-Path: <strikewing16th@hotmail.com>
From: "Anthony Yulo" <strikewing16th@hotmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <LAW11-F70hbG9UwhcYb0001b888@hotmail.com> <1077730129.2919.123.camel@pegasus> <Law11-OE444hG9vJaSx000173ba@hotmail.com> <1077790469.2754.23.camel@pegasus>
Subject: Re: [Bluez-devel] multiple devices clarification?
Date: Thu, 26 Feb 2004 19:35:06 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <Law11-OE67gTCxceqdr00018303@hotmail.com>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel!!

OK!! i understand now!!:) hehe.. that was a relief.. What  I thought with
the text was that its only possible to have 2 dongles which are master...
well anyway, now i understand...

tnx very much!!! :)

----- Original Message -----
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Anthony Yulo" <strikewing16th@hotmail.com>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sent: Thursday, February 26, 2004 6:14 PM
Subject: Re: [Bluez-devel] multiple devices clarification?


> Hi Anthony,
>
> > So i can't use 5 CSR- based dongles on one pc?
> > What do you mean per device limitations? :)
>
> what you don't understand is that there is a difference between number
> of devices and number of connections per device.
>
> BlueZ supports up to 16 device per host. If all of them are CSR based
> with the HCI 16.x firmware or greater, each of them can be master of
> seven slaves or slave of two masters.
>
> Regards
>
> Marcel
>
>
>
