Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] ISSC USB dongle can't ping with size 1000
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <E64BAD5A8AD46740828069A678D9DD73011B1A@netbe01.net.unimis>
References: <E64BAD5A8AD46740828069A678D9DD73011B1A@netbe01.net.unimis>
Content-Type: text/plain
Message-Id: <1141912147.4605.5.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 09 Mar 2006 14:49:07 +0100

Hi Al,

>      I think the problem may not be the buffer size (678) that ISSC device
> has. When I ping with size 1400 bytes, hcidump shows host breaks 1400 bytes
> into serveal 678 byte packets and sends them to device. Both ping request and ping reply from the other side can be captured in air.
> 
>      Most likely the problem is occured when ISSC device trys to send
> packets with large size to host. From the hcidump, I observe that if devices
> like CSR receiving packets with size 1400, it breaks 1400 into serveral 300 (something) packets and sends to host. On the other hand, when ISSC device receives packet with size 900, it sends 900 byte packet to host without breaking. But when the size is more than 1000, hcidump shows ISSC device does not send any packet to host.

there exists the HCI_MAX_ACL_SIZE constant which is 1024 and the
HCI_MAX_FRAME_SIZE which is 4 times HCI_MAX_ACL_SIZE.

What is the default frame size and max packets number an ISSC chips
sends to the host if no HCI_Host_Buffer_Size has been called?

>          After sending HCI_Host_Buffer_Size command, hcidump shows ISSC
> device sends max size of 256 byte to host. Ping with 1500 bytes and Internet
> access work  so far. I only try this with PAN to implement NAP.

The kernel has the HCI_Host_Buffer_Size command in its code, but it is
commented out. I forget the reason why this has been done, but I assume
there was a reason for it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
