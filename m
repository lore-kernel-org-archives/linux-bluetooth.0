Return-Path: <mplanque@laas.fr>
From: Michel Planques <mplanque@laas.fr>
Message-ID: <2338.82.255.26.193.1076970003.squirrel@www.laas.fr>
Date: Mon, 16 Feb 2004 23:20:03 +0100 (CET)
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
To: <marcel@holtmann.org>
In-Reply-To: <1076855596.14758.52.camel@pegasus>
References: <20040215000300.0C48932D37@mail.rvs.uni-bielefeld.de>
        <1076855596.14758.52.camel@pegasus>
Cc: <grpmind+bluez.users@boromir.vpop.net>,
   <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

l2test is a good tool to generate Bluetooth traffic between 2 linux
stations. You can also use the PAN profile with bnep protocol and a
TCP/UDP traffic generator : I suggest iperf (it works on Linux and
Windows). I followed these two methods and the results were similar.

I had some bad experiences with the packet type choosen by my dongle's
link manager. I had to force the packet type to DH5 reach the maximum bit
rate.



Michel.

> Hi,
>
>> I'd like to configure a linux box using a USB bt dongle to talk to an
>> ipaq     at 723kbps for streaming video. So two questions:
>
> what iPAQ is this?
>
>> 1. How can I tell at what rate the two bluetooth devices are talking?
>> I could    use l2test if I could run linux on the ipaq, but I can't
>> (yet).
>
> Buy a protocol analyser ;)
>
>> 2. How can I configure the two to talk at the assymetric 723kbps rate?
>>
>
> In general this is not needed, because the link manager should choose
> the best package types for you.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
