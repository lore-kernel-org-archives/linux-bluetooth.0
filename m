Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Handling a Hardware Error event on iPAQ h5550
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20050324T123636-904@post.gmane.org>
References: 
	 <Pine.LNX.4.33.0503171141200.22782-100000@redbean.intranet.gw-instruments.de>
	 <1111057586.11792.58.camel@pegasus>
	 <loom.20050324T123636-904@post.gmane.org>
Content-Type: text/plain
Message-Id: <1111664767.1916.54.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 24 Mar 2005 12:46:07 +0100

Hi Catalin,

> > > I'm not that familiar with the architecture of BlueZ but with the
> > > experiences for our own stack I can tell you this is not trivial. The main
> > > problem here is that the Bluetooth Stack is not stateless. One possible
> > > solution is to feed the reset done event to the higher layers (l2cap). But
> > > than L2cap must be modified to correctly shut down all connections. It
> > > would be easier if the HCI layer tracks the state of all ACL and SCO
> > > connections (Marcel ??). Than a reset done event can be handled like a
> > > unexpected link loss on all active connections and the higher layers do
> > > not need any modifications (hopefully).
> > 
> > we can do this and actually calling "hcitool cc" does this already, but
> > it waits indeed for a timeout of the HCI_Disconnect.
> 
> Could you give a few more details on this one, please? What I want to do is what
> Pieter suggested: have the Hardware Error event trigger an unexpected link loss
> on all active connections. 

if you wanna do this, then this should be done directly in the Bluetooth
core module in the kernel. Look at hci_event.c and add the handling for
the hardware error event to trigger the appropriate actions.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
