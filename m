Return-Path: <cyrus@holtmann.org>
Message-ID: <4AA9FE3D.7060200@gmail.com>
Date: Fri, 11 Sep 2009 09:37:33 +0200
From: sancane <sancane@gmail.com>
MIME-Version: 1.0
To: ngh@isomerica.net
CC: linux-bluetooth@vger.kernel.org,
	Chris Robinson <cckrobinson@gmail.com>
Subject: Re: Fwd: HDP profile support
References: <5c11eae40909101215n438f77c5sbcd289d0b1f77c5f@mail.gmail.com>	 <5c11eae40909101231w18b66f7p13832fc60819c856@mail.gmail.com> <1252612666.30957.42.camel@localhost.localdomain>
In-Reply-To: <1252612666.30957.42.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,
My name is Santiago and i'm interested in to provide a full free/open
eHealth framework to linux and android platform. I'm working in MCAP
implementation in my free time, and i have implemented a partial
iso/ieee 11073-20601 manager for android too. I started my MCAP
implementation for BlueZ few weeks ago, of course it is in a early state
yet but there are some people that work with me to integrate MCAP with
HDP and DI in BlueZ.
You can get more info in http://openhealth.morfeo-project.org/
Note that this work is free but advices and collaborations are welcome.

Best regards!

Nathan Holstein escribió:
> On Thu, 2009-09-10 at 14:31 -0500, Chris Robinson wrote:
>   
>> Hello,
>> Is there currently a timetable in place for adding the HDP profile to
>> Bluez?  I'm doing some concept work for an Android device and one of
>> the Bluetooth requirements is to support the HDP profile.
>>     
>
> Full HDP support (especially on the Android platform) requires a few
> supporting features that haven't quite made the mainline of development
> yet.  It is possible--I did so earlier this summer--and the situation
> has improved drastically due the efforts of various people.
>
> The first step is to get L2CAP enhanced retransmission and streaming
> mode support in your kernel.  Gustavo Padovan worked on this over the
> summer for a Google Summer of Code project.  He has done an excellent
> job taking my initial patches, extending the functionality and cleanly
> integrating them into the bluetooth-testing kernel.
>
> >From there, HDP depends upon the Bluetooth Multi-Channel Adaptation
> Protocol.  This provides an additional control channel layered on top of
> L2CAP sockets.  Additionally, some simple SDP work is required (which
> can use BlueZ's existing SDP services).
>
> As for implementation upon Android, there's a bit more work.  The
> Android kernel (on the Cupcake/Donut branches at least) already includes
> basic L2CAP statically linked into the kernel.  This causes conflicts
> when attempting to load a module with Enhanced L2CAP support built in.
> In order to do so, I've had to build my own kernel and system images,
> and then flash them to a development phone.  If you go this way, you'll
> have to backport the applicable patches onto the 2.6.29 kernel used in
> Donut.  I've never even tried to backport to the 2.6.27 kernel in
> Cupcake.
>
>
>
>
>     --nathan holstein
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

