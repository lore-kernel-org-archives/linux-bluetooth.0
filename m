Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth on a MIPS-System
From: Marcel Holtmann <marcel@holtmann.org>
To: leidenfrost@corscience.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41654062.5050009@corscience.de>
References: <41651D72.7040806@corscience.de>
	 <1097147273.7325.26.camel@pegasus>  <41652A40.4080209@corscience.de>
	 <1097152912.7325.30.camel@pegasus>  <41654062.5050009@corscience.de>
Content-Type: text/plain
Message-Id: <1097154841.7325.36.camel@pegasus>
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
Date: Thu, 07 Oct 2004 15:14:01 +0200

Hi Thomas,

> > the kernel modules are part of the Linux kernel you use on your MIPS
> > system. So you need a Linux kernel compiled for MIPS with activated
> > Bluetooth subsystem.
> 
> I already had this kernel, but without doing "make modules" I can look 
> for them a long long time... ;-)
> 
> Now I created the following modules and loaded them on target via modprobe:
> -bluez
> -l2cap
> -hci_vhci
> -hci_uart
> -hci_usb
> 
> Doing hcitool scan now results: Device is not available: Success
> So I guess that not all neccessary modules are loaded, right?

you may also need a USB host controller driver. I don't know which to
use for your system. Is it PCI based? If yes, post the output of lspci.

> > So what does "find /lib/modules/ | grep bluetooth" say?
> 
> This results nothing, just the # again.

This is wrong unless you copied the BlueZ modules somewhere else by
hand.

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
