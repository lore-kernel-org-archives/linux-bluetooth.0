Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <49D45501.8030606@binarywings.net>
References: <49D1FE96.1090200@binarywings.net>
	 <2d5a2c100903310644od9cbf69ma2c28c83b7e51@mail.gmail.com>
	 <49D30FD8.9020506@binarywings.net> <49D45501.8030606@binarywings.net>
Date: Thu, 2 Apr 2009 14:28:29 -0300
Message-ID: <2d5a2c100904021028g78376debke885916eba13cf93@mail.gmail.com>
Subject: Re: PAN with bluez-utils-3
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Florian Philipp <lists@binarywings.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian

On Thu, Apr 2, 2009 at 3:02 AM, Florian Philipp <lists@binarywings.net> wrote:
> Florian Philipp schrieb:
>> Thanks for your answer! I don't think it's bug but merely lack of
>> understanding on my part. Therefore I'll go into detail now:
>>
>> Here I have a Gentoo system which shall act as the GN. Its hcid.conf
>> looks like this:"
>> options {
>> а а а autoinit yes;
>> а а а security auto;
>> а а а pairing multi;
>> а а а passkey "123456";
>> }
>> device {
>> а а а name "BlueZ (%d) at %h";
>> а а а class 0x020100;
>> а а а iscan enable; pscan enable;
>> а а а lm master;
>> а а а lp rswitch,hold,sniff,park;
>> }
>> "
>>
>> Its network.conf would then look like this (?):"
>> [General]
>>
>> [PANU Role]
>> Autostart=false
>>
>> [GN Role]
>> Interface=blue0
>> Autostart=true
>>
>> [NAP Role]
>> Autostart=false
>> "
>>
>> The init-script executes the following command:
>> /usr/sbin/hcid -s -f /etc/bluetooth/hcid.conf
>>
>> What's wrong with this? When I test it with Windows clients, they fiind
>> the device but it doesn't appear to have PAN functionality.
>>
>
> I'd also be happy about a response like 'It should work'. Then I could
> start searching for unlogical explanations.

It looks like you have been using BlueZ 3.x series which is way too
old for me to take a look. Check with 4.x if it helps.


-- 
Luiz Augusto von Dentz
Engenheiro de Computaчуo
