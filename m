Return-Path: <charles@bueche.ch>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Charles Bueche <charles@bueche.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Olivier Bornet <Olivier.Bornet@smartdata.ch>,
   BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1071411737.4356.56.camel@pegasus>
References: <1070218289.8534.30.camel@bluez.bueche.ch>
	 <20031201093804.A1281@schnell.us.cray.com> <1070380522.19169.52.camel@saag>
	 <1070380907.19169.55.camel@saag> <1070482683.18058.6.camel@bluez.bueche.ch>
	 <1070483755.24159.114.camel@pegasus> <20031204085314.GA1780@smartdata.ch>
	 <1071001915.13464.33.camel@bluez.bueche.ch>
	 <20031209224217.GE26896@smartdata.ch>
	 <1071043970.8979.5.camel@bluez.bueche.ch>
	 <20031210083002.GG26896@smartdata.ch>
	 <1071330995.4307.27.camel@bluez.bueche.ch>
	 <1071333541.27252.177.camel@pegasus>
	 <1071341513.4307.36.camel@bluez.bueche.ch>
	 <1071342247.1548.6.camel@pegasus> <1071410118.5988.8.camel@bluez.bueche.ch>
	 <1071411737.4356.56.camel@pegasus>
Content-Type: text/plain
Message-Id: <1071432083.6305.24.camel@bluez.bueche.ch>
Mime-Version: 1.0
Date: Sun, 14 Dec 2003 21:01:24 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,

On Sun, 2003-12-14 at 15:22, Marcel Holtmann wrote:
> Hi Charles,
> 
> > Now, my mouse isn't jumpy at all anymore. The only glitch left is that I
> > have to press its "connect" button just after starting bthid if I want a
> > link. Is there a way to get this automated ?
> 
> this shouldn't be needed, because the mouse reconnects if you start
> moving it. The only thing you need is a HID server process on your host.

I have to test more. What is your command line for this ? I use
/data/util/bthid-0.8-2.6/bthid -m -d -p 600 00:07:61:08:7E:2E

> > I don't like to criticize about missing docs, because I have the same
> > problem at my main contract as Solaris admin (too many things to do to
> > write proper docs). However, bluez suffer a bit from that problem. They
> > are loads of small HOWTOs, but I miss a sort of white paper to explain
> > bluetooth in general. Any pointer is welcome.
> 
> If you understand german you are in the lucky position that I have
> written some articles for german magazines and most of them are also
> available online.

I can read it, I will look at your articles, thx for the hint. I have
already seen a nice presentation which helped to understand the
bluetooth layers. A long time ago, I developped low-level code in Z80
assembler and C for embedded systems, so I'm not completely lost :-)

> The missing of a general white paper is a good point. I have thought so
> many times about writing the one and only introduction into Linux and
> Bluetooth, but always the same things stopped me from doing this. The
> first is that no company pays me for working on BlueZ and so we come to
> the second, that my time is very limited.

You do a very good job in that limited time, given all these beginners
like me asking basic stuff on mailing lists :-)

Charles

-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer
