Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth on a MIPS-System
From: Marcel Holtmann <marcel@holtmann.org>
To: leidenfrost@corscience.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41655C4D.1070206@corscience.de>
References: <41651D72.7040806@corscience.de>
	 <1097147273.7325.26.camel@pegasus>  <41652A40.4080209@corscience.de>
	 <1097152912.7325.30.camel@pegasus>  <41654062.5050009@corscience.de>
	 <1097154841.7325.36.camel@pegasus>  <41654D83.1090306@corscience.de>
	 <1097158664.7325.38.camel@pegasus>  <41655C4D.1070206@corscience.de>
Content-Type: text/plain
Message-Id: <1097161856.7325.43.camel@pegasus>
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
Date: Thu, 07 Oct 2004 17:10:56 +0200

Hi Thomas,

> Now I have depmod installed and I know that my Linux is Debian-based.
> And my System is non-PCI-based, but USB is already working 
> (Input-devides). Running depmod -a results:
> 
> ...
> depmod: /lib/modules/2.4.21/sdptool.o: Unhandled relocation of type 12 
> for .text
> depmod: /lib/modules/2.4.21/sdptool.o: Unhandled relocation of type 12 
> for .text
> depmod: depmod obj_relocate failed
> ...
> depmod: *** Unresolved symbols in /lib/modules/2.4.21/l2ping.o
> depmod: *** Unresolved symbols in /lib/modules/2.4.21/ppporc.o
> depmod: *** Unresolved symbols in /lib/modules/2.4.21/rfcomm.o
> depmod: *** Unresolved symbols in /lib/modules/2.4.21/sdptool.o
> 
> I guess that there is someting totally wrong, but how to solve this?
> 
> > this rfcomm.o is not a kernel module. It is a compiled object file from
> > the bluez-hcidump package.
> 
> What does this mean?

yes, there is something wrong. You don't understand the difference
between a kernel module and a user space program and an object file that
is produced when building the previous two.

You need the BlueZ kernel modules and you need a cross-compiled version
of bluez-libs and bluez-utils. Try to achieve these two goals first and
don't try to mix them.

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
