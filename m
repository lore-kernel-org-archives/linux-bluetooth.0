Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco link help needed
From: Marcel Holtmann <marcel@holtmann.org>
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
   Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
In-Reply-To: <200402251635.13917.mtortonesi@ing.unife.it>
References: <4034CA08.50500@soft.uni-linz.ac.at>
	 <200402251504.47809.mtortonesi@ing.unife.it>
	 <1077719012.2919.94.camel@pegasus>
	 <200402251635.13917.mtortonesi@ing.unife.it>
Content-Type: text/plain
Message-Id: <1077723452.2919.112.camel@pegasus>
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
Date: Wed, 25 Feb 2004 16:37:32 +0100

Hi Mauro,

> well, you knew just what to search. i have spent more than one hour searching 
> for "sco" and "sco csr" on the sf.net archives (which, as you surely know, 
> are not very fast, have thousands of messages and have a shameful uptime) 
> without finding anything useful. if you had kindly told me "look for 
> something like scotest" or "look for a message from steven singer" i could 
> have find the mail you were referring to in a minute.

I use the Gmane archives, because they are much faster ;)

> > Is the PCM mapping of both dongles set to HCI? 
> 
> how can i find this out? from the SCO MTU value?
> 
> [mauro@giskard mauro]$ /sbin/hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:0A:3A:51:13:1C ACL MTU: 192:8  SCO MTU: 64:8
>         HCI 16.4

No. Use "hciconfig hci0 revision" (as root). It must be set to HCI.

> > What kernel version do you use?
> 
> 2.4.25pre7 

This should work, but the 2.6 seems to have problems with USB ISOC
transfers.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
