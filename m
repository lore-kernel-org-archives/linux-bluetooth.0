Return-Path: <linux@feline-soul.com>
Message-ID: <2461.216.47.59.131.1156887151.squirrel@webmail.feline-soul.net>
In-Reply-To: <1156892459.4026.56.camel@aeonflux.holtmann.net>
References: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com>
    <e4f1f0110608270518v15039332v87d3f90a9fd8d823@mail.gmail.com>
    <e1effdeb0608280517l13c117fg4f958870027c4595@mail.gmail.com>
    <e4f1f0110608280930l3475b147ob2f7f3e5e6bf5efe@mail.gmail.com>
    <e1effdeb0608281114l3b6a29barfb8c6b29b7197638@mail.gmail.com>
    <1270.216.47.59.131.1156790715.squirrel@webmail.feline-soul.net>
    <1156799718.5613.48.camel@aeonflux.holtmann.net>
    <36756.216.47.59.131.1156793990.squirrel@webmail.feline-soul.net>
    <1156809299.5613.56.camel@aeonflux.holtmann.net>
    <2056.216.47.59.131.1156803892.squirrel@webmail.feline-soul.net>
    <1156848432.5613.67.camel@aeonflux.holtmann.net>
    <1345.216.47.59.131.1156883686.squirrel@webmail.feline-soul.net>
    <1156890900.4026.49.camel@aeonflux.holtmann.net>
    <4253.216.47.59.131.1156884752.squirrel@webmail.feline-soul.net>
    <1156892459.4026.56.camel@aeonflux.holtmann.net>
Date: Tue, 29 Aug 2006 15:32:31 -0600 (MDT)
Subject: Re: [Bluez-users] How do I reset a pairing?
From: "Bearcat M. Sandor" <linux@feline-soul.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ users" <bluez-users@lists.sourceforge.net>
Reply-To: linux@feline-soul.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <bluez-users.lists.sourceforge.net>

Marcel,

I looked it over. I am only just starting to learn C so this is a little
daunting. I tried a "gcc -Wall -o passkey-agent -passkey-agent.c" and that
didn't work (i didn't really expect it to). I didn't see a configure
script that would create a make file for the agent.

If my X system goes down, all of my paring  devices will go down with it,
since i would need gnome up to get them working. How can i get this agent
working?

I'm just confused. Since the bluez-gnome is a new release, what did people
do before it arrived to get pairing devices working?

Thank you for the help so far. I appreciate your time.

Bearcat

> Hi Bearcat,
>
>> I've looked through the blues-utils 3.2 source code directories and not
>> seen such a script. Can you point it out to me, or is it code that need
>> to
>> be compiled, or a pice of code that needs to be extracted/followed.
>
> it is hcid/passkey-agent.c and it is a C program. You can of course do
> the same in Python or any other language with D-Bus bindings.
>
> Regards
>
> Marcel
>
>
>
