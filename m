Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Zhikui Chen <zhikui.chen@po.uni-stuttgart.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40E412AA.4070908@po.uni-stuttgart.de>
References: <40E40440.8070109@po.uni-stuttgart.de>
	 <1088685238.4540.190.camel@pegasus>  <40E40A44.60008@po.uni-stuttgart.de>
	 <1088687188.4540.202.camel@pegasus>  <40E412AA.4070908@po.uni-stuttgart.de>
Content-Type: text/plain
Message-Id: <1088689181.4540.216.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: Help for bluez-bluefw-1.0.
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
Date: Thu, 01 Jul 2004 15:39:42 +0200

Hi Zhikui,

> Thanks for your kindness.
> 
> I installed the hci_usb modules, hciconfig still has no output:
> 
> My PC reports:
> 
> bnep                   16000  0
> crc32                   4608  1 bnep
> l2cap                  23680  1 bnep
> hci_usb                13312  0
> bluetooth              47332  3 bnep,l2cap,hci_usb
> autofs                 15616  0
> ds                     20100  2
> yenta_socket           21248  0
> pcmcia_core            67076  2 ds,yenta_socket
> 3c59x                  39720  0
> ohci1394               34560  0
> ieee1394              318352  1 ohci1394
> parport_pc             25120  0
> parport                40128  1 parport_pc
> usbcore               109780  2 hci_usb
> [root@localhost root]# hciconfig
> [root@localhost root]#
> 
>  Could you tell me what mistake I made?

you must a least load one USB host controller driver.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
