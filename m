Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>, Philip Blundell <pb@nexus.co.uk>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030717170310.0703eec8@unixmail.qualcomm.com>
References: <1057107686.15797.101.camel@pegasus>
	<5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<1057107686.15797.101.camel@pegasus>
	<5.1.0.14.2.20030717170310.0703eec8@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1058488421.25379.116.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: Version 3 libs/utils
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 18 Jul 2003 02:33:34 +0200

Hi Max,

> >> What about a Bluetooth daemon (for exmaple btmgr) which integrates the
> >> security manager and the sdpd. It can also store an userspace Bluetooth
> >> inquiry cache, name database and remote SDP cache. The local
> >> configuration (like local device name) for example can also modified
> >> through this daemon and restored on next boot, which is good for
> >> handheld devices. The access can be done through a defined protocol over
> >> unix sockets.
> >
> >I quite like this idea, except the SDP server functionality won't be
> >needed for some devices (e.g., handhelds).
> Agreed.

not agreed.

Try to connect with a Windows machine to a Linux based handheld to
transfer files over OBEX. You need a SDP server on your Linux handheld.
Only the real client only devices need no SDP server and these are
special cases or applications.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
