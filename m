Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm problems
From: Marcel Holtmann <marcel@holtmann.org>
To: Gene Imes <ebi7@ozob.net>
Cc: list-bluez <bluez-users@lists.sourceforge.net>
In-Reply-To: <1080515964.11299.4.camel@go2>
References: <1080515964.11299.4.camel@go2>
Content-Type: text/plain
Message-Id: <1080556492.2281.211.camel@pegasus>
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
Date: Mon, 29 Mar 2004 12:34:53 +0200

Hi Gene,

> I have a D-Link dbt-120 dongle. This has been working fine with a
> bluetooth GPS. However today I tried to use it and I could not connect
> to the GPS.
> 
> When I plug the dbt-120 in the /dev/rfcomm0-255 are created. If I try a
> 'cat /dev/rfcomm0' I get cat: rfcomm0 No such device. Previously a 'cat
> /dev/rfcomm0' would return everything the GPS was sending.
> 
> Anyone know what is going on here?

you should check that "rfcomm -a" reports your bindung with the GPS
device. Check if hcid is runninng and run "hcidump -x" to see what is
going on. And of course find out what you have changed.

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
