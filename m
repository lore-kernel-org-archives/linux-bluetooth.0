Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hciattach killed
From: Marcel Holtmann <marcel@holtmann.org>
To: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <AFE91B59A185A5439840B43AB79190470938E7@mchp997a.mch.sbs.de>
References: <AFE91B59A185A5439840B43AB79190470938E7@mchp997a.mch.sbs.de>
Content-Type: text/plain
Message-Id: <1078323020.2787.92.camel@pegasus>
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
Date: Wed, 03 Mar 2004 15:10:20 +0100

Hi Matthias,

> sorry I mixed it with another problem we had: hciconfig shows 
> NOTHING, not even 00:00:00:00:00:00.
> so I think, hciattach IS killed.
> 
> How can I check what is going on there? 

I would start with a binary hcidump of the connection that causes the
problem and then add some debugging printk's to the hci_uart driver. And
add debug code to hciattach, so you can be sure that the ldisc is closed
by the kernel module and that there is not segfault in the hciattach
itself. If you think this is a module versus built-in problem check it
with an identical setup, but only different kernel's.

And btw what hciattach command line and what module do you use?

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
