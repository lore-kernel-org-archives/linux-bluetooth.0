Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <5d03b0011c48dccc4e835a03b9c9fd3de467f719.camel@hadess.net>
Subject: Re: bt "server" how to configure requiring passkey from connecting
 clients
From: Bastien Nocera <hadess@hadess.net>
To: Libor Peltan <lpeltan@insys-tec.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 08 Aug 2018 17:14:52 +0200
In-Reply-To: <VI1PR0601MB2128F10733B846A0ACCBA78C9A260@VI1PR0601MB2128.eurprd06.prod.outlook.com>
References: <VI1PR0601MB21287F56810A923C8881893C9A270@VI1PR0601MB2128.eurprd06.prod.outlook.com>
         <ba6964a183f45af588e7c93bd2cf834cc0c1c5a4.camel@hadess.net>
         <VI1PR0601MB2128F10733B846A0ACCBA78C9A260@VI1PR0601MB2128.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2018-08-08 at 14:31 +0000, Libor Peltan wrote:
> Hi Bastien,
> Thanks much for your answer.
> 
> Even if programmed my own pairing agent, I can't see how I could
> achieve having fixed PIN for incomming requests.
> 
> When I register my agent, I can choose one of following capability
> options [accorging to BlueZ Agent API]:
>  - NoInputNoOutput, DisplayYesNo, KeyboardOnly: I can just
> programatically decide based on the client's BD address if I accept
> the pairing or not
>  - DisplayOnly, KeyboardDisplay: at the time of pairing, the agent
> receives already the PIN, and can just decide if it's accepted. But
> this PIN is not entered by the mobile phone (client) user, it's just
> fabriqued (randomly?) somewhere inside the pairing process. Actually,
> the mobile phone user is queried with the same PIN and can only
> accept it too.
> 
> All in all, my agent is never asked to return the PIN.
> 
> The agents built-in in bluetoothctl or the bluez-tools you pointed
> to, behave rouhly the same.
> 
> Am I missing something, some other usecase of pairing agent?
> 
> It seems weird to me that for old version of BlueZ (4?), I have found
> something like 'bluetooth-agent 1234' command instantly doing what I
> need... But I don't know exactly.

This, up to line 100:
https://github.com/hadess/CHIP-bluetooth-speaker/blob/master/setup.sh#L73
is the example of a script that creates a fixed PIN, for all clients,
with bluez-tools' bt-agent running as a service. Ideally, you would
start this after some sort of physical interaction with your device, or
have an "uncommon" pincode (a password of sorts, eg. not 0000 or 1111),
otherwise your neighbours will be able to pair with your device.

If you want to use a fixed pin code in your agent, you'd need to use
the NoInputNoOutput capability, and implement the RequestPasskey
function so that you can provide the passkey to be used.

Cheers
