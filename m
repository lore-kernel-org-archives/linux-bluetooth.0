Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PAN profile of bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Till Harbaum <harbaum@beecon.de>
Cc: "Williams, Richard" <Richard.Williams@VITRONICS.com>,
   blookk - <blookk@hotmail.com>, bluez-devel@lists.sf.net
In-Reply-To: <200408301756.14723.harbaum@beecon.de>
References: <A1F0D47583A2D711919F00600819B3A45BDCF7@goofy.vitronics.com>
	 <200408301756.14723.harbaum@beecon.de>
Content-Type: text/plain
Message-Id: <1093882109.5620.89.camel@pegasus>
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
Date: Mon, 30 Aug 2004 18:08:30 +0200

Hi Till,

> > Did you make sure the /etc/bluetooth/pan/dev-up file is correct and present
> > on both your devices, master and slave ? If this file isn't there, you
> > won't get the bnep process started.
> Are you sure? I never heard of that file, but have successfully been using 
> bnep without even having a /etc/bluetooth/pan directory on my pc.

this depends on your system. Actually on every new system that uses
hotplug, there is no need for using dev-up. The bnep0 is like every
other network card in your machine and hotplug takes care of it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
