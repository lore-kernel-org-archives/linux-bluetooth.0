Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid on ppc
From: Marcel Holtmann <marcel@holtmann.org>
To: Ben Wilson <bwilson@yooser.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040307221349.GA1930@stag.mark-and-erika.com>
References: <20040307221349.GA1930@stag.mark-and-erika.com>
Content-Type: text/plain
Message-Id: <1078704798.15279.3.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 08 Mar 2004 01:13:19 +0100

Hi Ben,

>   I am trying to get the MS bluetooth mouse working with a
> PowerBook with 2.6.3_rc2-benh kernel.
> 
>   I can get pan and bnep working, letting me access the internet
> wireless! Awesome, even if it is only about 20k/sec, is that
> normal?
> 
>   I also got rfcomm working, and can establish ppp connection
> with my cellphone provider.
> 
>   The only thing that isn't working is bthid. It seems to die
> silently when ever I establish the connection, or move the the
> mouse. I still see events generated with hciconfig, but bthid
> keeps exiting for no reason I can see.
> 
> Any advice? Anyone get this unholy trinity (Apple Laptop, MS
> mouse, running Linux) working?
> 
> The mouse works fine with the MS dongle on x86.

actually I think the new SDP code and the HID program has some endian
bugs which causes your problem.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
