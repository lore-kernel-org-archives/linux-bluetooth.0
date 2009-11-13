Return-Path: <cyrus@holtmann.org>
Message-ID: <4AFD52BD.6030104@gmx.de>
Date: Fri, 13 Nov 2009 13:36:13 +0100
From: Susanne Goldammer <susanne.goldammer@gmx.de>
Reply-To: Susanne Goldammer <susanne.goldammer@gmx.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: Make bluetoothd start w/o SDP Server
References: <4AF9721B.3010405@gmx.de>	 <1257861916.10888.1372.camel@localhost.localdomain>	 <4AF97659.2050807@gmx.de> <4AFBD3B6.6020706@gmx.de>	 <20091112131357.1106213e@strolchi.home.s3e.de> <4AFC05BD.40508@gmx.de>	 <20091112140840.1efa7475@strolchi.home.s3e.de> <4AFC1803.2080703@gmx.de>	 <1258037845.2158.0.camel@localhost.localdomain> <4AFC26C3.50006@gmx.de>	 <20091113113335.GA18325@jh-x301> <1258113521.3299.12.camel@violet>
In-Reply-To: <1258113521.3299.12.camel@violet>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>


> hold your horses.
>
> Don't we create the SDP server with BDADDR_ANY. So if you wanna start
> your own one on top of it, you just can bind() it to the local adapter
> address and the kernel will use that one for that interface.
>
> Regards
>
> Marcel
>
>   
Hi Marcel,

i tried it and it works fine. Cool. :) That behaviour was new to me.
So that's the solution i guess. No further patches needed.

I hope that this behaviour is not changed in the future.
As i know this behaviour is not the same for tcp/ip sockets, right? Or
is that a new and common kernel feature since 2.6.xxx ?

Thanks to all .....
