Return-Path: <mfrey@pepper.com>
In-Reply-To: <1082575965.23959.63.camel@pegasus>
References: <8F95FDA9-93BB-11D8-88A9-00039390D626@pepper.com> <1082575239.23959.56.camel@pegasus> <CAE1625E-93C9-11D8-88A9-00039390D626@pepper.com> <1082575965.23959.63.camel@pegasus>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9E655450-93D4-11D8-88A9-00039390D626@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Michael Frey <mfrey@pepper.com>
Subject: Re: [Bluez-devel] BTHID setup...
Date: Wed, 21 Apr 2004 16:44:00 -0400
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

ok -- My keyboard does reconnect once connected.  I am talking about 
the very first time.  So I need to implement a way to search for all 
devices in the area present the list to the user and let them choose 
the device to connect to.

Michael

On Apr 21, 2004, at 3:32 PM, Marcel Holtmann wrote:

> Hi Michael,
>
>> I understand, and I now have my keyboard working using bthid.  However
>> search and list does not work for me.  It never prints anything out. I
>> had to find out the btaddr of my keyboard and use bthid -c after
>> launching bthid -d.  That works.  I would now love to have bthid find
>> and connect automatically.
>
> the search and list are not implemented and maybe never will be. 
> However
> most HID device are designed to reconnect. This means that starting
> bthid -d at boot is enough and after you press a key, your keyboard 
> will
> connect to the latest used host device.
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
