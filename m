Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4115b3ef.johana@johana.com>
From: "Tom Watson" <tsw@johana.com>
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] IOGear GBU301 and Kernel 2.4.20
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
Date: Sat, 07 Aug 2004 22:02:38 -0800

Well...
I have attempted to get all the modules functional, but appear to have
a problem.  Somehow the driver hci_usb doesn't get connected to the
USB device.  I print out the USB driver info (/proc/bus/usb/devices) and
get ...Cls=e0(Unk.  )... where is should get 'hci_usb' as I see it.

Any other reference to 'hci0' (as in 'hciconfig hco0 up') fails since
it can't find the device.

Is there something in the hotplug configuration that I'm missing, or
something even more obvious (but not to me!).

Any help is nice.  Ask a question, and I should be able to answer
what I've done.

Thanks....
-- 
Tom Watson         Generic short signature
tsw@johana.com     (I'm at home now)


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
