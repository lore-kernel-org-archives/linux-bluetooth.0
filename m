Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <ba6964a183f45af588e7c93bd2cf834cc0c1c5a4.camel@hadess.net>
Subject: Re: bt "server" how to configure requiring passkey from connecting
 clients
From: Bastien Nocera <hadess@hadess.net>
To: Libor Peltan <lpeltan@insys-tec.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 08 Aug 2018 14:19:25 +0200
In-Reply-To: <VI1PR0601MB21287F56810A923C8881893C9A270@VI1PR0601MB2128.eurprd06.prod.outlook.com>
References: <VI1PR0601MB21287F56810A923C8881893C9A270@VI1PR0601MB2128.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2018-08-07 at 09:43 +0000, Libor Peltan wrote:
> Hello,
> I'm preparing a bluetooth "access point" using BlueZ 5.47, so that
> for example mobile phones can connect to it, and further use PAN
> profile (which is not part of this question). So far it works well,
> just using the JustWorks pairing method.
> 
> I'd like to secure this a little bit, not allowing anyone to pair,
> rather to request passkey (let's say hardcoded string) before
> accepting pairing requested by a client mobile phone.
> 
> After searching through documentation and much googling, I don't see
> any hints how to achieve this.
> 
> I found some information about pairing agents in BlueZ5, both in
> bluetoothctl and custom (programming them seems complicated but
> viable and I cannot use simple-agent since I don't have python on my
> machine), but all the usecases seem to target on BlueZ being the
> client, who initiates pairing, and the agent takes care of inputting
> passkey required by the other side - which is the opposite of what I
> need.
> 
> How to configure BlueZ5 to require passkey from any incomming pairing
> requests?
> 
> Thanks very much for your answers!

You need a pairing agent to do this sort of thing, and bluez itself
doesn't ship any such tools for headless use. Your best bet is using
the "bluez-tools" repo:
https://github.com/khvzak/bluez-tools

I've used them successfully on headless devices. In your case, you
could have the pairing agent (bt-agent) be started for X seconds after
a button press for example.

If you want something more complicated, you'll need to implement your
own agent, the test/simple-agent Python script in the bluez sources is
probably a good start.

Cheers
