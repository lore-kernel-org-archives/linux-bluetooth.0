Return-Path: <linux@feline-soul.com>
Message-ID: <36756.216.47.59.131.1156793990.squirrel@webmail.feline-soul.net>
In-Reply-To: <1156799718.5613.48.camel@aeonflux.holtmann.net>
References: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com>
    <e4f1f0110608270518v15039332v87d3f90a9fd8d823@mail.gmail.com>
    <e1effdeb0608280517l13c117fg4f958870027c4595@mail.gmail.com>
    <e4f1f0110608280930l3475b147ob2f7f3e5e6bf5efe@mail.gmail.com>
    <e1effdeb0608281114l3b6a29barfb8c6b29b7197638@mail.gmail.com>
    <1270.216.47.59.131.1156790715.squirrel@webmail.feline-soul.net>
    <1156799718.5613.48.camel@aeonflux.holtmann.net>
Date: Mon, 28 Aug 2006 13:39:50 -0600 (MDT)
Subject: Re: [Bluez-users] How do I reset a pairing?
From: "Bearcat M. Sandor" <linux@feline-soul.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ users" <bluez-users@lists.sourceforge.net>
Reply-To: linux@feline-soul.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <bluez-users.lists.sourceforge.net>

Marcel,

Thank you!! I've been stressing over this for a month now.  Does the
configuration file changed in order to accomodate this?

Bearcat M. Sandor

 > Hi Bearcat,
>
>> I get that message too. However, i have "pin_helper
>> /usr/lib/kdebluetooth/kbluepin;" in my config file. I can run this
>> kbluepin from the cli and it starts fine and returns "PIN:000" if i
>> enter
>> 0000. Why isn't this firing up for me when i try to connect?
>>
>> I'll try the bluez-gnome agent, but i try to avoid gnome stuff so i
>> don't
>> have all those libs installed.
>
> the PIN helper stuff have been removed from the 3.x releases. You need
> to use a passkey agent. However the KDE-Bluetooth guys might simply
> extend their kbluepin with a passkey agent and then it will work without
> any GNOME program. However that is up to the KDE guys and not to me.
>
> Regards
>
> Marcel
>
>
>
