Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez and D-Link DBT-120
From: Marcel Holtmann <marcel@holtmann.org>
To: Max <spamhole@gmx.at>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040404181317.GA962@venus>
References: <20040403190647.GA16596@venus>
	 <1081073362.2839.29.camel@pegasus>  <20040404181317.GA962@venus>
Content-Type: text/plain
Message-Id: <1081102784.5533.1.camel@pegasus>
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
Date: Sun, 04 Apr 2004 20:19:45 +0200

Hi Max,

> > disable CONFIG_BT_HCIUSB_SCO in your kernel config.
> 
> I have checked in my current .config, and it is disabled:
> 
> max@venus:~$ zcat /proc/config.gz | grep BT_HCIUSB  
> CONFIG_BT_HCIUSB=m
> # CONFIG_BT_HCIUSB_SCO is not set

my fault. I mixed again intr with isoc ;)

Update to 2.6.5 and show us your lspci output.

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
