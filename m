Return-Path: <Bearcat@feline-soul.com>
From: "Bearcat M. Sandor" <Bearcat@feline-soul.com>
Reply-To: Bearcat@feline-soul.com
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] can't connect EPOX Keyboard BT-KB01B
Date: Thu, 27 Jul 2006 21:26:47 -0600
Cc: BlueZ users <bluez-users@lists.sourceforge.net>,
        Nils Faerber <nils.faerber@kernelconcepts.de>
References: <44C8FB2F.9070403@kernelconcepts.de> <1171.216.47.50.125.1154031396.squirrel@webmail.feline-soul.net> <1154049725.7650.8.camel@localhost>
In-Reply-To: <1154049725.7650.8.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200607272126.48317.Bearcat@feline-soul.com>
List-ID: <bluez-users.lists.sourceforge.net>

I installed the hcidump program (and made/distributed a package for my 
distro).

When i press buttons on my keyboards hcidump reports nothing. There is nothing 
about a pin or security when i turn auth on and try to reestablish 
connections with the mouse. After auth is off the mouse works fine.

When trying to connect the keyboard i get a lot of:
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    0000: 00 29 00 00                                       .)..
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 41
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 41 rssi 0
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 41

Does that mean anything?

Bearcat




On Thursday 27 July 2006 19:22 in an email titled "Re: [Bluez-users] can't 
connect EPOX Keyboard BT-KB01B" Marcel Holtmann wrote:
>Hi Bearcat,
>
>> No such luck for me yet. Strangly the hcitool does not allow the auth
>> option for me. I had to do a hciconfig /dev/usb/hci0 auth to turn the auth
>> on the hub. Auth is now on but the keyboard still doesn't connect. As
>> usuall nothing is reported in the syslogs.
>>
>> Do i need to turn on the auth for the keyboard too (is that even an
>> option)?
>>
>> I am never prompted for a pin and even if i was, i don't know what it
>> would be. Is the pin connected to the keyboard, the hub (should i find out
>> from logitech what their default is) or is it a pin kept by bluez?
>>
>> Also, i don't have a program called hcidump. Is that part of the bluez
>> package?
>
>it is in bluez-hcidump and you should start using it. Otherwise you are
>starting to speculate and this doesn't help.
>
>Regards
>
>Marcel

-- 
Bearcat M. Sandor
Bearcat@feline-soul.com
ICQ: 6628727
MSN: bearcatsandor@hotmail.com
Yahoo: bearcatsandor
AIM: bearcatmsandor
Jabber: bearcatsandor@jabber.org
