Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth on a MIPS-System
From: Marcel Holtmann <marcel@holtmann.org>
To: leidenfrost@corscience.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41652A40.4080209@corscience.de>
References: <41651D72.7040806@corscience.de>
	 <1097147273.7325.26.camel@pegasus>  <41652A40.4080209@corscience.de>
Content-Type: text/plain
Message-Id: <1097152912.7325.30.camel@pegasus>
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
Date: Thu, 07 Oct 2004 14:41:52 +0200

Hi Thomas,

> But I think the Problem is not MIPS-specific, the question is where to 
> get the missing modules like l2cap, hci_usb, bluez...
> Should they be created automaticly after compiling the BlueZ-Libs & 
> -Utils? Support for them is activated in the kernel (as module).

the kernel modules are part of the Linux kernel you use on your MIPS
system. So you need a Linux kernel compiled for MIPS with activated
Bluetooth subsystem.

If you find the modules on your filesystem, check what modinfo or file
says about them.

> > Do a "modprobe hci_usb" and then check with "dmesg" what happens.
> 
> # modprobe hci_usb (on target says:)
> insmod: hci_usb.o: no module by that name found
> modprobe: failed to load module hci_usb
> 
> because there is no module on target, searching for it resulted nothing. 
> And I think I just can't take them from the host (x86). Are there any 
> precompiled modules for MIPS?

So what does "find /lib/modules/ | grep bluetooth" say?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
