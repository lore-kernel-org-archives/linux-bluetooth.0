Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <4a44b86eb47892c67126d3d66159add3be168e02.camel@hadess.net>
Subject: Re: bt "server" how to configure requiring passkey from connecting
 clients
From: Bastien Nocera <hadess@hadess.net>
To: Libor Peltan <lpeltan@insys-tec.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 14 Aug 2018 14:25:44 +0200
In-Reply-To: <VI1PR0601MB212835A9675785A5ED2258629A380@VI1PR0601MB2128.eurprd06.prod.outlook.com>
References: <VI1PR0601MB21287F56810A923C8881893C9A270@VI1PR0601MB2128.eurprd06.prod.outlook.com>
         <ba6964a183f45af588e7c93bd2cf834cc0c1c5a4.camel@hadess.net>
         <VI1PR0601MB2128F10733B846A0ACCBA78C9A260@VI1PR0601MB2128.eurprd06.prod.outlook.com>
         <5d03b0011c48dccc4e835a03b9c9fd3de467f719.camel@hadess.net>
         <VI1PR0601MB212835A9675785A5ED2258629A380@VI1PR0601MB2128.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2018-08-14 at 12:14 +0000, Libor Peltan wrote:
> Thanks Bastien for your brief, but leading answer.
> 
> Still, I feel like I'm missing something :(
> 
> I've read the links carefully. The "CHIP-bluetooth-speaker" uses
> bluez-tools' bt-agent with parameters set so that it's using
> NoInputNoOutput capabilitiy, but requiring Passkey at the same time.
> This is exactly what I want!
> 
> No having bluez-tools in my setup, I tried to make my own programmed
> agent behave similarly, i.e. according to your hint, implement the
> RequestPasskey method in my agent. However, this method is never
> called! When pairing a phone, BlueZ only calls the AuthorizeService
> method of my agent.
> 
> How can I force BlueZ  to call the RequestPasskey method of my agent?
> 
> I tried to analyze how bluez-tools do it, but I haven't find anything
> in their code. They seem to simply work...

You will also need to register the agent, and make sure it's the
default one (you'll probably want to disable whatever other one you
have running).

You would probably only ever get AuthorizeService if the device is
already paired. You would need to unpair it, and once paired, mark it
as trusted so that AuthorizeService is not called and the service is
authorised without any further prompts (or check that the device is
paired in your AuthorizeService implementation).

HTH
