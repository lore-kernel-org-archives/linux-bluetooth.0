Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090928091416.278260@gmx.net>
References: <20090928091416.278260@gmx.net>
Date: Mon, 28 Sep 2009 11:06:47 -0300
Message-ID: <2d5a2c100909280706w19304a0u212bd5340cfb967a@mail.gmail.com>
Subject: Re: Video Streaming over Bluetooth with bluez
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Anna Richter <anna.richter1@gmx.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Sep 28, 2009 at 6:14 AM, Anna Richter <anna.richter1@gmx.net> wrote:
> Hi everyone!
>
> I am writing my master thesis now and a part of it deals with video streaming over bluetooth in linux and I have some questions about how to implement it with bluez. I am new with bluetooth programming and I tried to find answers to my questions in the internet, but all what I found is very general information. It would be great, if you could help me.
> My application consits of three units: server, gateway and client. The server sends the video packets (RTP/RTCP) to the gateway via Ethernet. Gateway receives them and should send them to the client over bluetooth.
>
> 1) As far as I could find in the internet, the Video Distribution Profile is not yet supported in the current version of bluez. Is that right? On the bluez wiki page I found, that VDP was a proposal for the Google Summer of Code this year. Did anybody take this project so that VDP could be supported in the near future?

Nope, nobody took the opportunity to implement it :(

> 2) Since the VDP is apparently not yet supported, I thought of several possible ways of realising video streaming over blueotooth: SPP/L2CAP, BNEP/L2CAP and HCI.

I would say only bnep is really convenient for you, because that would
make bluetooth transport transparent for you. But that will take all
of fun of implementation :D and perhaps you don't have enough material
to your thesis. In the other hand vdp wouldn't be that difficult to
fully support on BlueZ, we already implemented avdtp protocol for a2dp
profile, so you don't have to worry about inventing your own codec
negotiation protocol, also vdp uses better the bandwidth of bluetooth,
since there is only l2cap involved where on bnep there is l2cap+bnep.

> So for my application it seems to be the easiest and best way to use the SPP/L2CAP way with the send(...) and recv(...) commands to realise video streaming over bluetooth. Of course I know that the speed and the video quality may not be the best and until now it is better to use WLAN for video streaming instead of bluetooth. But my task is to do both and then compare them.

Not really, as I said either you go with bnep where you can handle
both Bluetooth and WLAN in the same way, in other words rtp over
tcp/udp, or you implement VDP which is basically rtp over l2cap.

Regards,

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
