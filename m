Return-Path: <antonio.terreno@gmail.com>
Message-ID: <100466c40605301120n4c5bbcd4gb5f94d6b5b47e57b@mail.gmail.com>
Date: Tue, 30 May 2006 20:20:17 +0200
From: "Antonio Terreno" <antonio.terreno@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [Bluez-devel] concurrent service searches
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1148909660.31689.62.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
References: <100466c40605161025y72f1d718j1e4868a2ebbd3db6@mail.gmail.com>
	 <1148909660.31689.62.camel@localhost>
List-ID: <bluez-devel.lists.sourceforge.net>

Thanks a lot Marcel,

your help was preciuos, cos then I've better undestand the limits of
the bluetooth.

Actually I'm using 3 antennas :-) One to discover devices and two to
find services and push objects... And it works fine... Isn't cool?

The server will be presented at the next java conference in italy 8-)

thanks again & best regards

Antonio Terreno

2006/5/29, Marcel Holtmann <marcel@holtmann.org>:
> Hi Antonio,
> you can have only an inquiry or a page at the same time. That is
> different. Once the connection has been established then you can run
> another inquiry or create a second connection (with almost every modern
> chips).
>
> So if you have a connection (ACL link) you can run as many upper layer
> protocols (SDP, RFCOMM, OBEX etc.) as you like on it. They are all
> multiplexed and this is done by the Bluetooth subsystem of the Linux
> kernel.
>
> However we don't buffer inquiry or page requests. If the fail, they fail
> and we don't try again.
>
> Regards
>
> Marcel
>
>
>

-- 
Antonio Terreno
http://antonioterreno.java2me.org/
