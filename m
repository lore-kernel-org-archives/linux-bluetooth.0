Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BTHID setup...
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Frey <mfrey@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <CAE1625E-93C9-11D8-88A9-00039390D626@pepper.com>
References: <8F95FDA9-93BB-11D8-88A9-00039390D626@pepper.com>
	 <1082575239.23959.56.camel@pegasus>
	 <CAE1625E-93C9-11D8-88A9-00039390D626@pepper.com>
Content-Type: text/plain
Message-Id: <1082575965.23959.63.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 21 Apr 2004 21:32:45 +0200

Hi Michael,

> I understand, and I now have my keyboard working using bthid.  However 
> search and list does not work for me.  It never prints anything out. I 
> had to find out the btaddr of my keyboard and use bthid -c after 
> launching bthid -d.  That works.  I would now love to have bthid find 
> and connect automatically.

the search and list are not implemented and maybe never will be. However
most HID device are designed to reconnect. This means that starting
bthid -d at boot is enough and after you press a key, your keyboard will
connect to the latest used host device.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
