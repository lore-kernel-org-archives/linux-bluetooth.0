Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4235C92D.80107@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [Patch] Some btsco modifications
References: <1110683934.5056.43.camel@pc7.dolda2000.com>	 <4233C663.80109@xmission.com> <1110762698.5056.73.camel@pc7.dolda2000.com>	 <423589B1.6000403@xmission.com> <1110809103.5056.102.camel@pc7.dolda2000.com>
In-Reply-To: <1110809103.5056.102.camel@pc7.dolda2000.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 14 Mar 2005 10:26:05 -0700

Fredrik

>>Can you comment on what the implications are for supporting multiple 
>>headsets simultaneously with a single btsco daemon? Would the kernel 
>>interaction need to be changed again or could it be limited to the daemon?
> 
> 
> Well, if you ask me, that's just unnecessary.  It would add a lot of
> complexity to the btsco daemon, for no obvious purpose. I believe that
> if one wants multiple headsets, one should simply run multiple instances
> of the btsco daemon.

Maybe what we're looking for is something to start/stop/restart 
one-per-headset btsco deamons appropriately. Maybe a daemon itself.

I will tag and merge the latest changes tonight. We will need to update 
the README (I can do this myself at some point) and Thomas or someone 
who uses it should fix btsco2.

I believe everything (with the possible glaring exception of userspace 
btsco.c) was indented to "kernel style" using some magical args to 
indent. If things work ok, I will do an indent pass again to make the 
look consistent.

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
