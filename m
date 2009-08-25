Return-Path: <cyrus@holtmann.org>
Message-ID: <4A93F2C6.4030708@ouvi.com.br>
Date: Tue, 25 Aug 2009 11:18:46 -0300
From: Mateus Interciso <mateus@ouvi.com.br>
MIME-Version: 1.0
To: Iain Hibbert <plunky@rya-online.net>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Question on simple RFCOMM server
References: <4A93D887.8060007@ouvi.com.br> <1251207686.259635.1938.nullmailer@galant.ukfsn.org>
In-Reply-To: <1251207686.259635.1938.nullmailer@galant.ukfsn.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thank you, however the Peter solution (setting via ioctl) worked 
perfectly, and it fit's with what I need, since all the clients are 
already implemented via RFCOMM, I'll leave it like this for now, the 
only issue is having to run it as root for setting the link mode, but I 
can bypass this by using hciconfig before running the main server.
Or is there any configuration that can make a normal user change the 
default link mode?

Thanks all once again.

Iain Hibbert wrote:
> On Tue, 25 Aug 2009, Mateus Interciso wrote:
> 
>> Hello, I have a very simple RFCOMM server that I adapted from an extremely
>> simple TCP echo server I've made for learning TCP, it's a simple fork()
>> server, and while the TCP server works perfeclty, the RFCOMM works only with 2
>> connected clients at the same time, and I'm failling to see the problem, can
>> someone help me?
> 
> You didn't post what the 'failure' was but for RFCOMM you can only have
> one connection on a server channel (each RFCOMM channel corresponds to
> an emulated serial port).
> 
> since a TCP connection is defined by the address and port at each end, the
> Bluetooth equivalent is more likely to be a a L2CAP connection to a given
> PSM which can support up to ~64k channels (though as the Peter Wippich
> notes, the number of devices the radio can maintain connections with is
> limited)
> 
> iain
> 
> 
> 
