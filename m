Return-Path: <cyrus@holtmann.org>
Message-ID: <49E5F2BE.1040808@binarywings.net>
Date: Wed, 15 Apr 2009 16:44:14 +0200
From: Florian Philipp <lists@binarywings.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: PAN with bluez-utils-3
References: <49D1FE96.1090200@binarywings.net>	 <2d5a2c100903310644od9cbf69ma2c28c83b7e51@mail.gmail.com>	 <49D30FD8.9020506@binarywings.net> <49D45501.8030606@binarywings.net> <2d5a2c100904021028g78376debke885916eba13cf93@mail.gmail.com>
In-Reply-To: <2d5a2c100904021028g78376debke885916eba13cf93@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Luiz Augusto von Dentz schrieb:
> Hi Florian
> 
> On Thu, Apr 2, 2009 at 3:02 AM, Florian Philipp <lists@binarywings.net> wrote:
>> Florian Philipp schrieb:
>>> Thanks for your answer! I don't think it's bug but merely lack of
>>> understanding on my part. Therefore I'll go into detail now:
>>>
>>> Here I have a Gentoo system which shall act as the GN. Its hcid.conf
>>> looks like this:"
>>> options {
>>>       autoinit yes;
>>>       security auto;
>>>       pairing multi;
>>>       passkey "123456";
>>> }
>>> device {
>>>       name "BlueZ (%d) at %h";
>>>       class 0x020100;
>>>       iscan enable; pscan enable;
>>>       lm master;
>>>       lp rswitch,hold,sniff,park;
>>> }
>>> "
>>>
>>> Its network.conf would then look like this (?):"
>>> [General]
>>>
>>> [PANU Role]
>>> Autostart=false
>>>
>>> [GN Role]
>>> Interface=blue0
>>> Autostart=true
>>>
>>> [NAP Role]
>>> Autostart=false
>>> "
>>>
>>> The init-script executes the following command:
>>> /usr/sbin/hcid -s -f /etc/bluetooth/hcid.conf
>>>
>>> What's wrong with this? When I test it with Windows clients, they fiind
>>> the device but it doesn't appear to have PAN functionality.
>>>
>> I'd also be happy about a response like 'It should work'. Then I could
>> start searching for unlogical explanations.
> 
> It looks like you have been using BlueZ 3.x series which is way too
> old for me to take a look. Check with 4.x if it helps.
> 
> 

This thread is a bit old, I know. I just wanted to say: Nevermind.

It seems that the new versions don't support my use case as good as the
2.x-series did (no default pin without a graphical interface or a
self-made helper program, for one thing). Besides, there is - at least
for me - a big lack of documentation on how things should be configured.

In any case, upgrading to 3.x and to an even higher degree 4.x caused
too much work for a thing that used to just work.

Therefore I decided to go back to 2.25 and they there for the near future.
