Return-Path: <summetj@cc.gatech.edu>
Date: Thu, 14 Oct 2004 11:30:18 -0400 (EDT)
From: "Jay W. Summet" <summetj@cc.gatech.edu>
To: Marcel Holtmann <marcel@holtmann.org>
cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Socket CF adaptor, limited to 2-3KB/sec RFCOMM
 PPP connection?
In-Reply-To: <1097752969.4640.40.camel@notepaq>
Message-ID: <Pine.GSO.4.58.0410141051300.8280@gaia3.cc.gatech.edu>
References: <Pine.GSO.4.58.0410121425040.24690@gaia3.cc.gatech.edu>
 <1097752969.4640.40.camel@notepaq>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

>>New Information: In response to requests for hcidump -t log files and
testing with a USB bluetooth adaptor and obex push.<<

I have a Socket Compact Flash bluetooth adaptor, which uses the dtl1_cs
kernel module. I have it configured, and everything works, but
I am getting very slow GPRS speeds with my Sony Ericsson T610 telephone.

I first noticed it with my GPRS data transfer when I only got 1.9 to 2.2 KB
per second of throughput on downloads. When I use IrDA to connect to
my phone instead of bluetooth, I get the expected 5.0 to 5.6 KB per second
of throughput.

I borrowed a friend's USB bluetooth adaptor (DBT-120 D-Link) and am able
to get the 5.0 to 5.6 KB/sec GPRS transfer while the Socket Compact Flash
(CF) adaptor got 2.0KB/sec. (Tested in the same location, with excellent
cellular signal strength, at the same time of day.)

I also tested both devices using the obextool to "push" an 84 KB jpeg
image to my telephone. I believe that this transfer was speed limited by
the phone's internal (flash?) memory, as with both the Socket CF and
D-Link USB adaptor I got about the same speeds, in the 24-30 second range
(best case, in a few cases I got much worth throughput). [That's about
3.4KB/Sec, slower than the GPRS throughput (below) I was getting with the
USB adaptor or IrDA, even when I was using the USB adaptor for the obex
push.]


I've captured an "hcidump -t" log file of the two different GPRS phone
connections. In both cases, I used the same software and scripts,
initializing a PPP connection to the internet and using wget to download
the first part of an AVI file for a minute until the transfer speed evened
out. With the Socket CF card, I got around 2.0KB/sec, while with the USB
Bluetooth adaptor I got around the expected GPRS max speed at 5.3KB/sec.

files:
Slow, Socket CF card:
http://www.cc.gatech.edu/~summetj/drafts/socket_cf_gprs_2.0K.dump

Fast enough D-Link USB dongle:
http://www.cc.gatech.edu/~summetj/drafts/usb_gprs_5.3K.dump


I paid extra for the CF form factor, as I have an internal CF slot, and
don't want to have a usb dongle sticking out of my computer if I can at
all avoid it, so I'm motivated to get this sucker working correctly.
Radio strength isn't an issue, as the phone was about 2 feet from the
laptop in both tests, and the CF card has worked at 2.0K (gprs) from at
least 20 feet away. (and at 3.4KB/sec for OBEX push)

I have compiled the 2.6.7 (kernel.org stock) kernel for my laptop, and am
willing to apply patches and re-compile to test if somebody has an idea of
something that may fix this...

Thanks,
Jay
