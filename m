Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 31 Jul 2012 17:12:48 -0400
Message-ID: <CAGjArBcwtaRoecSivEaN9FiCbGfC3JhFRwXUVqq58SmQhN07sQ@mail.gmail.com>
Subject: l2ping Recv failed: Connection reset by peer
From: Charles Gordon <digigordo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm porting bluez 4.98 to an embedded system.  I have it up and running, but
I notice that when I run l2ping, I get the message "Recv failed: Connection
reset by peer" after l2ping runs for 5 seconds.  This is very consistent.
It doesn't matter whether I ping once a second, or do a flood ping.  After 5
seconds the l2ping program closes with the message saying the connection was
reset by the peer.

This looks like some sort of timeout.  Perhaps the timeout is there for
security reasons.  I'd like to understand how to adjust the timeout, or at
least confirm that the system is working correctly.

I'm running Linux 2.6.35 and Bluez 4.98 on my embedded system, and Ubuntu
10.04 with Linux 2.6.32 and Bluez 4.60 on my PC.

I've looked through the Bluez configuration files and I don't see anything
that sets up security for L2CAP or sets timeouts that are relevant.  I tried
increasing the PageTimeout in /etc/bluetooth/main.conf to 81920 (50 seconds)
on both systems, but that didn't make any difference.  I also looked in the
configuration program hciconfig for an option to set a timeout, but I didn't
find anything.

Can anyone tell me what the relevant timeout for l2ping is and how to adjust
it, or at least why it is set for 5 seconds?

Thanks.
