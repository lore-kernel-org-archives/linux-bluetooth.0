Return-Path: <mfrey@pepper.com>
In-Reply-To: <1082575239.23959.56.camel@pegasus>
References: <8F95FDA9-93BB-11D8-88A9-00039390D626@pepper.com> <1082575239.23959.56.camel@pegasus>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CAE1625E-93C9-11D8-88A9-00039390D626@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Michael Frey <mfrey@pepper.com>
Subject: Re: [Bluez-devel] BTHID setup...
Date: Wed, 21 Apr 2004 15:26:30 -0400
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

I understand, and I now have my keyboard working using bthid.  However 
search and list does not work for me.  It never prints anything out. I 
had to find out the btaddr of my keyboard and use bthid -c after 
launching bthid -d.  That works.  I would now love to have bthid find 
and connect automatically.

Is this supported?

Michael

On Apr 21, 2004, at 3:20 PM, Marcel Holtmann wrote:

> Hi Michael,
>
>> I now have my kernel running bluez and now want to set up the new 
>> bthid
>> from CVS.
>
> and you compiled the uinput driver?
>
>> I built libs2 and utils2 and am trying to run the bthidd and get the
>> following errors.
>>
>> root@(none):/opt/bluetooth/bluez/sbin# ./bthidd
>> Can't open HIDP control socket: Invalid argument
>>
>> Did I not compile something into the kernel that I need to support 
>> this?
>
> This userspace code is for the HIDP kernel module which is experimental
> stuff. What you are looking for is the bthid program.
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
