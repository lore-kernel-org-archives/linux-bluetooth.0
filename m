Return-Path: <cyrus@holtmann.org>
Message-ID: <4AAFBFA6.70007@binarywings.net>
Date: Tue, 15 Sep 2009 18:24:06 +0200
From: Florian Philipp <lists@binarywings.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: PIN Helper
References: <6887eb5d0909142301r52343cd3sbe64c106da2d7434@mail.gmail.com> <20090915061104.GA20323@jh-x301>
In-Reply-To: <20090915061104.GA20323@jh-x301>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan Hedberg schrieb:
> Hi,
> 
> On Tue, Sep 15, 2009, Kartikey Parmar wrote:
>> I have installed bluez-4.52 with linux-2.6.30 on my arm board. I m
>> trying to connect to headset but because of unavailability of linkkey
>> I can't obtain connection.
>>
>> Is there any provision for linkkey generation for pairing in
>> bluez-4.52? Any tool available that can be run on arm-linux board? I
>> can't go for bluez-gnome else I need to install all its dependencies
>> which will add more load in terms of memory.
> 
> You could try one of the sample agents that come with BlueZ, i.e.
> test/simple-agent or test/agent.c. Or then just write your own agent to
> suite your needs.
> 

Just out of curiosity: Why does Bluez no longer provide any kind of
deamon as a pin helper any more?

I mean, it's not like Bluetooth itself is limited to interactive systems
which rightly demand graphical interfaces nowadays. Stuff like NAP is a
classic client-server situation in which you don't want to use Gnome or
KDE apps on the server side and maybe not even on the client side.

The lack of such functionality is one of the reasons which still keep me
on bluez-2.25. (lack of user documentation and howtos for >=3.x is the
other reason, by the way).

Just my two cents,
Florian Philipp
