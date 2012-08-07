Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGjArBcwtaRoecSivEaN9FiCbGfC3JhFRwXUVqq58SmQhN07sQ@mail.gmail.com>
References: <CAGjArBcwtaRoecSivEaN9FiCbGfC3JhFRwXUVqq58SmQhN07sQ@mail.gmail.com>
Date: Tue, 7 Aug 2012 16:01:18 -0500
Message-ID: <CAB7rCTietRP3RHu3MN-6OmVkah4EN8EPi_A319q5AEOUp+JcMA@mail.gmail.com>
Subject: Re: l2ping Recv failed: Connection reset by peer
From: Mike <puffy.taco@gmail.com>
To: Charles Gordon <digigordo@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Charles,

> I'm porting bluez 4.98 to an embedded system.  I have it up and running, but
> I notice that when I run l2ping, I get the message "Recv failed: Connection
> reset by peer" after l2ping runs for 5 seconds.  This is very consistent.
> It doesn't matter whether I ping once a second, or do a flood ping.  After 5
> seconds the l2ping program closes with the message saying the connection was
> reset by the peer.
>
> This looks like some sort of timeout.  Perhaps the timeout is there for
> security reasons.  I'd like to understand how to adjust the timeout, or at
> least confirm that the system is working correctly.
>
> I'm running Linux 2.6.35 and Bluez 4.98 on my embedded system, and Ubuntu
> 10.04 with Linux 2.6.32 and Bluez 4.60 on my PC.
>
> I've looked through the Bluez configuration files and I don't see anything
> that sets up security for L2CAP or sets timeouts that are relevant.  I tried
> increasing the PageTimeout in /etc/bluetooth/main.conf to 81920 (50 seconds)
> on both systems, but that didn't make any difference.  I also looked in the
> configuration program hciconfig for an option to set a timeout, but I didn't
> find anything.
>
> Can anyone tell me what the relevant timeout for l2ping is and how to adjust
> it, or at least why it is set for 5 seconds?

I have a feeling you're actually hitting a timeout inside the kernel.
This timer prevents devices from connecting and draining the battery
of your device.  So, unless the device connects to something "useful",
it gets disconnected.  It's been too long since I've looked at it, but
the timeouts are specified in "include/net/bluetooth/hci.h".  I have
seen the same l2ping issues you see, so I think your setup is working
as designed.

Mike
