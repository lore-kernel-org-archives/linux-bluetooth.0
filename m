Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Infineon ROK104001 Bluetooth Problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Edward Wei <Edward.Wei@Dartmouth.edu>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <415D6B27.5080805@Dartmouth.edu>
References: <415C6D46.1020309@Dartmouth.edu>
	 <1096618056.5403.14.camel@notepaq>  <415D6B27.5080805@Dartmouth.edu>
Content-Type: text/plain
Message-Id: <1096641741.4265.11.camel@notepaq>
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
Date: Fri, 01 Oct 2004 16:42:22 +0200

Hi Edward,

> Oh sorry.  I put the commands right next to the hcidump of my first 
> message.  I'll make it more specific this time.
> 
> There are no problems with sending to the Infineon + PXA.
> 
> Laptop with Kensington USB Dongle (sender)
> # ./rctest.exec -s -P 10 xx:xx:xx:xx:xx:xx
> 
> Infineon ROK + PXA (receiver)
> # ./rctest.exec
> 
> 
> There are problems sending with the Infineon + PXA.
> 
> Laptop with Kensington USB Dongle (receiver)
> # ./rctest.exec
> 
> Infineon ROK + PXA (sender)
> # hcidump -x &
> # ./rctest.exec -s -P 10 xx:xx:xx:xx:xx:xx
> 
> This is the hcidump that follows... a few packets get through, then it 
> stalls and says "hci_cmd_task: hci0 command tx timeout".

this means that the ROK has a problem in its implementation of the HCI
flow control. Or maybe it is on our side, but I don't think so. We
actually don't use flow control on the receiving side, so this will of
course work. Do you have a firmware update for the ROK?

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
