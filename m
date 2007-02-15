Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45D3F804.5030601@mojo-working.com>
References: <45D3F804.5030601@mojo-working.com>
Date: Thu, 15 Feb 2007 09:18:06 +0100
Message-Id: <1171527486.28302.14.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Role switch: Detecting, predicting, preventing
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Art,

> I am running two BTPROTO_RFCOMM applications on a PC with Ubuntu 2.6.17-11-386, 
> each bound to its own USB dongle.  One is a client, the other a server.  Both 
> use the existing link mode settings of SLAVE ACCEPT.  Yet an Accept Connection 
> Request (traced with hcidump) shows Role Master, and the client receives a Role 
> Change.
> 
> If I put the same application, with the same USB dongles, on a PC running 
> Xubuntu 2.6.17-10-generic, the server's Accept Connection Request shows Role 
> Slave, and the Role Change packet does not flow.
> 
> My questions:
> 
> (1) What causes the role switch?

no idea for your case. I need to see your code and hcidump first.

> (2) Can I detect the role switch programmatically after it has occurred?  Both 
> hci_devinfo and getsockopt( s, SOL_RFCOMM, RFCOMM_LM, ...  ) claim the server is 
> still a slave.

You need to check hci_conn_info.

> (3) Can I predict the role switch before it occurs?  Again, hci_devinfo and 
> getsockopt provide no clues.

No.

> (4) Can I programmatically instruct the 2.6.17-11-386 server not to perform the 
> role switch?  If hci_devinfo is already set to SLAVE, calling 
> ioctl(HCISETLINKMODE) sounds unpromising.

Not that I know of. The slave mode is passive and an active MASTER wins.
However you can disable the role switch link policy, but be aware of
that this might cause other problems.

> What makes the role switch interesting, and undesirable, is that several 
> Bluetooth devices (all devices with link manager 1.x?) are limited to two slave 
> connections.  A third Create Connection fails with Command Disallowed, reflected 
> to the Linux client application as "File descriptor in bad state".
> 
> As for motivation, I plan to use one Linux PC with lots of dongles to model the 
> behavior of a large piconet.  A configuration that includes PCs running 
> Microsoft's stack, or Macs running Apple's stack, is stuck with the role switch, 
> but there are lots of configurations that use only peer-friendly devices.

Large piconets have never been easy and even if BlueZ supports multiple
dongles on one host, there might be some drawbacks because of this.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
