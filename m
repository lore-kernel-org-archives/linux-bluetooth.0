Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Zhikui Chen <zhikui.chen@po.uni-stuttgart.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40E40A44.60008@po.uni-stuttgart.de>
References: <40E40440.8070109@po.uni-stuttgart.de>
	 <1088685238.4540.190.camel@pegasus>  <40E40A44.60008@po.uni-stuttgart.de>
Content-Type: text/plain
Message-Id: <1088687188.4540.202.camel@pegasus>
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
Date: Thu, 01 Jul 2004 15:06:28 +0200

Hi Zhikui,

> Thanks. Whats bluez modules will be needed for 2.6.7?
> 
>  Bluetooth I will use is USB dongle ePox and the courrent kernel is 2.6.7.
> I configured 2.6.7 kernel and built it. and built bluez stuffs: hcidump, 
> hciemu, libs2.7, pan1.1, utils2.7
> And I modified /etc/modules.conf by adding lines:
> alias bt-proto-0 l2cap
> alias net-pf-31 bluez
> alias bt-proto-2 sco
> alias bt-proto-3 rfcomm
> alias bt-proto-4 bnep
> alais char-major-10-250 hci_uhci
> 
> BUT:
> For my redhat 8 (my notebook PCG 2600TEK only can be installed redhat 8, 
> redhat 9 and mandrake 9.2 could not be install), hciconfig could not be 
> found, and using locate hciconfig, there is output. Marcel could tell me 
> the reason and how should I do?
> For my redhat 9 (my PC), hciconfig reports that Can't open HCI socket, 
> Address family not surport by protocol, but for 2.4.25, it is ok. Would 
> you like to tell me, whta sould I do? I want to build a bluetooth 
> connection betweent my pc and my notebook. The both bluetooth drivers 
> are BT-DG03 (USB ePOX).

the EPoX dongles are CSR based and so not bluefw is needed. Load the
hci_usb driver and everything should work.

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
