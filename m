Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1471531954.4976.13.camel@toniob.net>
Subject: Re: Can't connect a Xbox one controller
From: Anthony Bourguignon <contact@toniob.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 18 Aug 2016 16:52:34 +0200
In-Reply-To: <CABBYNZKvqrbF7XzW4yShJyM2wXWckJX7X5PD6gU=mT7Pg6HUGw@mail.gmail.com>
References: <1471515072.4976.10.camel@toniob.net>
         <CABBYNZKvqrbF7XzW4yShJyM2wXWckJX7X5PD6gU=mT7Pg6HUGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Le jeudi 18 août 2016 à 16:56 +0300, Luiz Augusto von Dentz a écrit :
> Hi Anthony,
> 
> On Thu, Aug 18, 2016 at 1:11 PM, Anthony Bourguignon <contact@toniob.
> net> wrote:
> > 
> > Hi,
> > 
> > I've recently bought a new xbox one controller as the 2016 version
> > has
> > bluetooth connectivity.
> > 
> > The controller is pairing and connecting well on a windows 10
> > computer
> > and an android 4.4 tablet. But I can"t make it connect under linux
> > (Debian unstable, kernel 4.6 and 4.7-rc7, bluez 5.40 from
> > experimental). The pairing is ok but when I try to connect to
> > controller, it stays connected for less than one second, then
> > disconnects, then connects again and so one until the controller
> > goes
> > to sleep, because of the lack of a remote connection.
> > 
> > Any idea ?
> 
> It seems there is some problem configuring the L2CAP connection
> (probably for SDP):
> 
> > 
> > ACL data: handle 256 flags 0x02 dlen 15
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 3 clen 1
>       Failure - unknown options
>       RFC
> < ACL data: handle 256 flags 0x00 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040

So, is it a bug of bluez or of the controller firmware ? Why is it
possible to make a connection with an android tablet ?

Is there something more I can do to help ?
