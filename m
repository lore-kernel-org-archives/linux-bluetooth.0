Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jun 2008 09:42:31 +0200
From: "Martin Kupf" <mulata@gmx.de>
In-Reply-To: <20080609163110.282100@gmx.net>
Message-ID: <20080610074231.39470@gmx.net>
MIME-Version: 1.0
References: <20080609163110.282100@gmx.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] pairing problems
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I did some more research and I figured out that I will have to use the Inpu=
tService of bluez.
So with the dbus Interface of bluez I think have to do the following steps,=
 right?:
ActiveService (input)
CreateDevice (bdaddr of keyboard)
Connect()
CreateDevice looks for a link key and if it finds one, an authorized connec=
tion can be established with Connect() I guess.

>>From the point that an auhorized connection is established (this can be rec=
ognized if hcitool con returns a connection with AUTH at the end of the lin=
e) I can start bthid and use the keyboard.


Thanks for any hints
-mulata

PS: Sorry that I have published a similar thread (email) with my google acc=
ount, but I have at the moment huge roubel with my google mail account..




-------- Original-Nachricht --------
> Datum: Mon, 09 Jun 2008 18:31:10 +0200
> Von: mulata@gmx.de
> An: bluez-users@lists.sourceforge.net
> Betreff: [Bluez-users] pairing problems

> Hi!
> After an initial I always have to go through the complete pairing process,
> there is no reconnect.
> =

> I want to use a Bluetooth keyboard and it works fine so far, but there are
> some problems after the initial pairing.
> =

> To get the keyboard wokring I do the following steps:
> =

> hcid and passkey-agent are running.
> =

> hcitool scan
> hcitool cc <bdaddr>
> After this step hcitool con lists a established connection to the keyboard
> auth <bdaddr>
> Enter PIN on keyboard
> =

> Now the entry in hcitool con changes to AUTH
> So the connection is authorized and established and the keyboard works (I
> use bthid, anyway the process of authorization and pairing is done by hci=
d,
> and hcitools)
> =

> Usually from now this initial pairing process shouldnt be necessary for
> further sessions, but unfortunately it is.
> In oder to use the keyboard again (after disabling it) I have to go
> through the whole process again, but befor I have to /var/lib/bluetooth/*
> =

> So how can I establish further connections without the whole pairing
> process?
> =

> thanks
> -- =

> Martin Kupf
> =

> Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt?
> Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
> =

> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-- =

Martin Kupf

Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! =

Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
