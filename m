Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] another hibernate warning
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200409171223.18547.cijoml@volny.cz>
References: <200409171209.47267.cijoml@volny.cz>
	 <1095416145.3280.41.camel@pegasus>  <200409171223.18547.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1095417162.3280.46.camel@pegasus>
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
Date: Fri, 17 Sep 2004 12:32:42 +0200

Hi Michal,

> > > when hibernate compiled into kernel, this is written into dmesg:
> > > hci_usb: Unknown symbol hci_free_dev
> > > hci_usb: Unknown symbol hci_alloc_dev
> > > hci_usb: Unknown symbol hci_unregister_dev
> > > hci_usb: Unknown symbol hci_register_dev
> > >
> > > dongle works fine
> >
> > this is not hibernate specific. I have seen this many times, but the
> > module still gets loaded at some point. Maybe this has something to do
> > with the MODULE_VERSION macro we use, but I am not sure. If you load the
> > bluetooth.ko from a boot script you won't see this anymore.
> 
> hotplug loads it for me when booting and still see this...

this must be timing problem of the kernel module loader or something
like that. The reason why this works is because hci_usb will be loaded
two or three times by hotplug. Once for every interface. Do you wanna
track this problem down? I am happy if someone do.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
