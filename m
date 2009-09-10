Return-Path: <cyrus@holtmann.org>
Subject: Re: Fwd: HDP profile support
From: Nathan Holstein <ngh@isomerica.net>
Reply-To: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: Chris Robinson <cckrobinson@gmail.com>
In-Reply-To: <5c11eae40909101231w18b66f7p13832fc60819c856@mail.gmail.com>
References: <5c11eae40909101215n438f77c5sbcd289d0b1f77c5f@mail.gmail.com>
	 <5c11eae40909101231w18b66f7p13832fc60819c856@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Sep 2009 15:57:46 -0400
Message-Id: <1252612666.30957.42.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2009-09-10 at 14:31 -0500, Chris Robinson wrote:
> Hello,
> Is there currently a timetable in place for adding the HDP profile to
> Bluez?  I'm doing some concept work for an Android device and one of
> the Bluetooth requirements is to support the HDP profile.

Full HDP support (especially on the Android platform) requires a few
supporting features that haven't quite made the mainline of development
yet.  It is possible--I did so earlier this summer--and the situation
has improved drastically due the efforts of various people.

The first step is to get L2CAP enhanced retransmission and streaming
mode support in your kernel.  Gustavo Padovan worked on this over the
summer for a Google Summer of Code project.  He has done an excellent
job taking my initial patches, extending the functionality and cleanly
integrating them into the bluetooth-testing kernel.

>>From there, HDP depends upon the Bluetooth Multi-Channel Adaptation
Protocol.  This provides an additional control channel layered on top of
L2CAP sockets.  Additionally, some simple SDP work is required (which
can use BlueZ's existing SDP services).

As for implementation upon Android, there's a bit more work.  The
Android kernel (on the Cupcake/Donut branches at least) already includes
basic L2CAP statically linked into the kernel.  This causes conflicts
when attempting to load a module with Enhanced L2CAP support built in.
In order to do so, I've had to build my own kernel and system images,
and then flash them to a development phone.  If you go this way, you'll
have to backport the applicable patches onto the 2.6.29 kernel used in
Donut.  I've never even tried to backport to the 2.6.27 kernel in
Cupcake.




    --nathan holstein

