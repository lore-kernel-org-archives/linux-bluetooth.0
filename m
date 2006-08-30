Return-Path: <Linux@feline-soul.com>
From: "Bearcat M. Sandor" <Linux@feline-soul.com>
Reply-To: Linux@feline-soul.com
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] How do I reset a pairing?
Date: Tue, 29 Aug 2006 19:08:51 -0600
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
References: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com> <2461.216.47.59.131.1156887151.squirrel@webmail.feline-soul.net> <1156895173.4026.59.camel@aeonflux.holtmann.net>
In-Reply-To: <1156895173.4026.59.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200608291908.52176.Linux@feline-soul.com>
List-ID: <bluez-users.lists.sourceforge.net>

Marcel,

Ok, the passkey-agent runs. But i get errors. Here's what i'm doing:

1. Switch to root.
1. put headset into paring mode.
2. run "btsco 00:0D:44:4F:37:72"
3. run "passkey-agent 0000 00:0D:44:4F:37:72"

I get "Can't get on system bus" from passkey-agent.  Is dbus misconfigured?

I know dbus is running.  The "00:0D:44:4F:37:72" is the address of my 
headset.  "0:07:61:1C:9F:D3" is the address of my hub. I've tried that as 
well. I've also tried encapsulating the 0000 with quotes in case it is a 
string. I am running passkey-agent as root.

What am i doing wrong. Is there a way to create the file 
in /var/lib/bluetooth\00:07:61:1C:9F:D3 by hand?  What should the file be 
called and what should it contain.

I am very confused by the configuration of all this. I have seen documentation 
that states that i need:

1. passkey "0000" in my hcid.conf file
2. a /etc/bluetooth/passkeys/default file.
3. A script to be called in the config file
4. and now a passkey agent.

I know that the bluez site states that there is good documentation on the web, 
but that's simply *not* true. Most of it conflicts and is apparently outdated 
if only #4 is true now.

What am i doing wrong with this passkey-agent. If my headset device is 
00:0D:44:4F:37:72 and my hub is 00:07:61:1C:9F:D3 what should the command be?

Simply, if you were me, what steps would you take to get this working.

Thank you for your help so far.

My hcidump is as follows:
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: PIN Code Request (0x16) plen 6
< HCI Command: Inquiry (0x01|0x0001) plen 5
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Complete (0x01) plen 1
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: PIN Code Request (0x16) plen 6

The "btsco 00:0D:44:4F:37:72" command gives me:
Error: Failed to connect to SDP server: Function not implemented
Assuming channel 2

Can't connect RFCOMM channel: Resource temporarily unavailable


Bearcat




On Tuesday 29 August 2006 17:46 in an email titled "Re: [Bluez-users] How do I 
reset a pairing?" Marcel Holtmann wrote:
>Hi Bearcat,
>
>> I looked it over. I am only just starting to learn C so this is a little
>> daunting. I tried a "gcc -Wall -o passkey-agent -passkey-agent.c" and that
>> didn't work (i didn't really expect it to). I didn't see a configure
>> script that would create a make file for the agent.
>
>after ./configure you can run make and it will compile passkey-agent for
>you. It will always be compiled, but never be installed.
>
>> If my X system goes down, all of my paring  devices will go down with it,
>> since i would need gnome up to get them working. How can i get this agent
>> working?
>
>Once the devices are paired. You have a link key. The hcid handles this
>for you. You need the passkey agent only for entering the PIN code.
>
>> I'm just confused. Since the bluez-gnome is a new release, what did people
>> do before it arrived to get pairing devices working?
>
>Actually I expected that someone else will write the appropriate passkey
>agents for their desktop systems. So in the end I did for the one that I
>use. Only the Nokia 770 Maemo platform had its own passkey agent.
>
>Regards
>
>Marcel

-- 
Bearcat M. Sandor
Bearcat@feline-soul.com
Jabber: bearcat@jabber.feline-soul.net
ICQ: 6628727
MSN: bearcatsandor@hotmail.com
Yahoo: bearcatsandor
AIM: bearcatmsandor
