Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] RE: Qualification testing - rfcomm
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002401c34d5f$d576f240$5796fea9@baked>
References: <002401c34d5f$d576f240$5796fea9@baked>
Content-Type: text/plain
Message-Id: <1058555551.31052.261.camel@pegasus>
Mime-Version: 1.0
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
Date: 18 Jul 2003 21:12:24 +0200

Hi Daryl,

> > and that's the problem I don't find the part where it gets wrong :(
> 
> Do you mean you tried the aclsession script and didn't see the same send 5
> frames, wait 20 sec, send 5 more etc problem?

the aclsession scripts produces this effect, but it also left the ACL
link in some kind of buggy state. It must be some really stupid that I
always overlook. The code looks correct to me and my Bluetooth 1.0b
devices are working fine.

> > Did the other patch helped?
> 
> We haven't tested it yet...  I was hoping for a resolution to the above
> problem before I sent updates for evaluation.

It would be nice to know if the patch is enough for qualification,
because I don't plan to integrate a session wide flow control.

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
