Return-Path: <nosve@libero.it>
From: "Nosve" <nosve@libero.it>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
Subject: R: [Bluez-users] Pairing to devices with bluez and widcommwithsame adapter
Date: Fri, 23 Jan 2004 16:58:17 +0100
Message-ID: <AGELIJDLJNOPFNMOHHIFAECLCAAA.nosve@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1074865136.3071.125.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel

I don't want to be pedantic, but the question is how to store the link key
in the chip, I must use hcitool to send some form of commands? Or maybe
there are some documented possibilities which I have not found?
Even from the other thread I don't understand if maybe we must hope there is
a possibility to save the link key with widcomm stack.

Thanks for your patience

> -----Messaggio originale-----
> Da: Marcel Holtmann [mailto:marcel@holtmann.org]
> Inviato: venerdì 23 gennaio 2004 14.39
> A: Nosve
> Cc: BlueZ Mailing List
> Oggetto: Re: [Bluez-users] Pairing to devices with bluez and
> widcommwithsame adapter
>
>
> Hi Nosve,
>
>
> You only have to store the link key once on the chip and you never have
> to care about the authentication procedure again. Decide by yourself
> what place is safer. The dongle or your harddisk.
>
> Regards
>
> Marcel
