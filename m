Return-Path: <mfrey@pepper.com>
In-Reply-To: <1082562647.23959.43.camel@pegasus>
References: <E09DAEFD-93A2-11D8-88A9-00039390D626@pepper.com> <1082559461.23959.37.camel@pegasus> <80000A27-93A5-11D8-88A9-00039390D626@pepper.com> <1082560168.23959.40.camel@pegasus> <C65C90C8-93AA-11D8-88A9-00039390D626@pepper.com> <1082562647.23959.43.camel@pegasus>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8C26BE55-93B3-11D8-88A9-00039390D626@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Michael Frey <mfrey@pepper.com>
Subject: Re: [Bluez-devel] Unable to get hciattach to work...
Date: Wed, 21 Apr 2004 12:47:16 -0400
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

nice!!!  That did it.

Up and running.

Thanks for your help

Michael
On Apr 21, 2004, at 11:50 AM, Marcel Holtmann wrote:

> Hi Michael,
>
>> Ok -- I was able to patch my kernel -- fixing up by hand any rejects
>> but I get the following when trying to build the bluez modules.
>> core.c: In function `bnep_session':
>> core.c:463: error: structure has no member named `nice'
>> core.c: In function `bnep_add_connection':
>
> then your kernel includes another backport, because this is a 2.6
> feature only. Replace the line with
>
> 	set_user_nice(current, -15);
>
> and see if that helps.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
