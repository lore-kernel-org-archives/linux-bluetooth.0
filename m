Return-Path: <cijoml@volny.cz>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] info about encryption in proc?
Date: Mon, 1 Nov 2004 15:45:30 +0100
References: <200411011341.30769.cijoml@volny.cz> <200411011442.37852.cijoml@volny.cz> <1099317714.16247.100.camel@pegasus>
In-Reply-To: <1099317714.16247.100.camel@pegasus>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200411011545.30255.cijoml@volny.cz>
List-ID: <bluez-users.lists.sourceforge.net>

OK,

I thought, that is possible to see how many bits device use

M.

Dne po 1. listopadu 2004 15:01 jste napsal(a):
> Hi Michal,
>
> > > > is it possible to show in proc info about encryption which is used to
> > > > intercommunicate between linux box and other devices?
> > >
> > > what do you expect to see? This is a boolean value and "hcitool con"
> > > shows you the current state.
> >
> > for example in /proc/bluetooth/encryption
> >
> > MS Keyboard 128bit
> > MS Mouse none
> > ...
>
> as I said, this is only a boolean value and "hcitool con" already shows
> the current state of the encryption. How many bits are used for it, is
> not retrievable with standard HCI commands.
>
> Regards
>
> Marcel
