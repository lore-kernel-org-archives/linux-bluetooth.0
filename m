Return-Path: <mplanque@laas.fr>
From: Michel Planques <mplanque@laas.fr>
Message-ID: <3902.82.255.26.193.1076967794.squirrel@www.laas.fr>
Date: Mon, 16 Feb 2004 22:43:14 +0100 (CET)
Subject: Re: [Bluez-users] L2CAP connectionless
To: <marcel@holtmann.org>
In-Reply-To: <1076922085.2840.46.camel@pegasus>
References: <38F76B90B82C0A4A822651EACE4FF8E9C23322@s31xs2>
        <1076922085.2840.46.camel@pegasus>
Cc: <kdesai@mail.smu.edu>, <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

As I know, a L2CAP link is connection oriented, so I don't understand how
the connectionless mode is working.
I already searched informations about SOCK_DGRAM implementation in Bluez
and never found anything : even in this mailing list (maybe I'm blind !)
If anybody could point me on some informations ...

Thank you.

Michel.

> Hi Desai,
>
>> I am  just wondering how L2CAP connectionless mode works
>>
>> when i do a ./l2test -s -D BD_ADDR it has to use the connect method.
>>
>> Also when the -D option causes the socket to be set to SOCK_DGRAM  I
>> cannot understand what the  handler (s) function does
>>
>> I tried to single step using xxgdb but it would always skip the
>> handler(s) function.
>
> no comments from me, because I never worked with L2CAP connectionless
> sockets. There was some discussion about it on the mailing list, so I
> think you should go through the archive.
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
