Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT950_CS
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Jimenez <djimenez@pobox.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40720DAF.5040606@pobox.com>
References: <407195F7.4020907@pobox.com>
	 <200404052141.38457.cijoml@volny.cz>  <40720DAF.5040606@pobox.com>
Content-Type: text/plain
Message-Id: <1081348613.8755.5.camel@pegasus>
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
Date: Wed, 07 Apr 2004 16:36:53 +0200

Hi Daniel,

> > I think that this driver is not ported to 2.6 nor finished. It has many errors 
> > in 2.4 too, but is compilable.
> 
> Can anyone confirm this? I picked up this card off ebay thinking it 
> would work.
> 
> Perhaps we should contact the bluez hardware list maintainer and have 
> him/her denote which Kernels the modules are compatible with.

I stopped working on the bt950_cs, because it should be driven by the
serial_cs driver and after that you can use hci_uart for it.

However at the moment I only maintain drivers that are inside the kernel
and compiling a driver written for 2.4 with a 2.6 kernel almost fails.

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
