Return-Path: <cyrus@holtmann.org>
Message-ID: <49D45501.8030606@binarywings.net>
Date: Thu, 02 Apr 2009 08:02:41 +0200
From: Florian Philipp <lists@binarywings.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: PAN with bluez-utils-3
References: <49D1FE96.1090200@binarywings.net> <2d5a2c100903310644od9cbf69ma2c28c83b7e51@mail.gmail.com> <49D30FD8.9020506@binarywings.net>
In-Reply-To: <49D30FD8.9020506@binarywings.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Florian Philipp schrieb:
> Luiz Augusto von Dentz schrieb:
>> Hi Florian,
>>
>> On Tue, Mar 31, 2009 at 8:29 AM, Florian Philipp <lists@binarywings.net> wrote:
>>> So my question is: Does anyone have a working set of configuration files
>>> for newer bluez-utils? Preferably something related to the roles GN or  NAP.
> [...]
>> To act like a server you don't need to do anything for panu, for gn we
>> normally create a bridge called pan0 where all client are added, nap
>> is especial because of the routing stuff so you/your system need to
>> configure a bridge properly and make network.conf to use it (by
>> default this should be pan1).
>>
>> Now if you got any problem you could please provide a more detailed
>> info of it, if it is a bug we will be happy to fix it.
>>
>> Thanks,
>>
> 
> Thanks for your answer! I don't think it's bug but merely lack of
> understanding on my part. Therefore I'll go into detail now:
> 
> Here I have a Gentoo system which shall act as the GN. Its hcid.conf
> looks like this:"
> options {
> 	autoinit yes;
> 	security auto;
> 	pairing multi;
> 	passkey "123456";
> }
> device {
>  	name "BlueZ (%d) at %h";
> 	class 0x020100;
> 	iscan enable; pscan enable;
> 	lm master;
> 	lp rswitch,hold,sniff,park;
> }
> "
> 
> Its network.conf would then look like this (?):"
> [General]
> 
> [PANU Role]
> Autostart=false
> 
> [GN Role]
> Interface=blue0
> Autostart=true
> 
> [NAP Role]
> Autostart=false
> "
> 
> The init-script executes the following command:
> /usr/sbin/hcid -s -f /etc/bluetooth/hcid.conf
> 
> What's wrong with this? When I test it with Windows clients, they fiind
> the device but it doesn't appear to have PAN functionality.
> 

I'd also be happy about a response like 'It should work'. Then I could
start searching for unlogical explanations.
