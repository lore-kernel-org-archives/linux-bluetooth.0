Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with Bridging and PAN Profile
From: Fredrik Noring <noring@nocrew.org>
To: Christoph Scholz <scholz@cs.uni-bonn.de>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <1073900688.1792.7.camel@willie.informatik.uni-bonn.de>
References: <1073656142.3037.32.camel@willie.informatik.uni-bonn.de>
	 <1073853082.22680.58.camel@akka.yeti.nocrew.org>
	 <1073900688.1792.7.camel@willie.informatik.uni-bonn.de>
Content-Type: text/plain
Message-Id: <1074374358.19522.39.camel@akka.yeti.nocrew.org>
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
Date: Sat, 17 Jan 2004 22:19:35 +0100

Hi Christoph,

Thank you for your reply.

> Which kind of USB-driver do you use? I also had problems with "uhci".
> These were gone after switching to "usb-uhci".

It's "usb-uhci" on the Fedora box and "usb-ohci" on the other.

As suggested by Laszlo in another post, I've recompiled the Bluetooth
related kernel modules and disabled the "sco" module as well as "BNEP
multicast filter support", "BNEP protocol filter support" and "USB zero
packet support" and other unneeded Bluetooth features. It still appears
unstable, but perhaps differently.

The following "hci_acl_tx_to" messages popped up in /var/log/messages
about the time the connection was lost during a recent test:

    divert: not allocating divert_blk for non-ethernet device bnep0
    ip_tables: (C) 2000-2002 Netfilter core team
    divert: no divert_blk to free, bnep0 not ethernet
    divert: not allocating divert_blk for non-ethernet device bnep0
    ip_tables: (C) 2000-2002 Netfilter core team
 ?  hci_acl_tx_to: hci0 ACL tx timeout
 ?  hci_acl_tx_to: hci0 killing stalled ACL connection A8:C4:2A:C9:03:00
    divert: no divert_blk to free, bnep0 not ethernet

Unplugging and replugging the Bluetooth USB device and reinitialising
with "pand --connect xxx" etc. gave a much more stable connection.

Are your PAN connections always stable? Do they survive temporarily
moving out of range too? (I haven't tested this yet...)

Thanks,
Fredrik




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
