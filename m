Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Catalin Drula <catalin.drula@imag.fr>
Message-ID: <loom.20050324T123636-904@post.gmane.org>
References: <Pine.LNX.4.33.0503171141200.22782-100000@redbean.intranet.gw-instruments.de> <1111057586.11792.58.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: Handling a Hardware Error event on iPAQ h5550
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
Date: Thu, 24 Mar 2005 11:39:37 +0000 (UTC)

Hi Marcel,

Marcel Holtmann <marcel <at> holtmann.org> writes:
 
> Hi Peter,
> 
> > I'm not that familiar with the architecture of BlueZ but with the
> > experiences for our own stack I can tell you this is not trivial. The main
> > problem here is that the Bluetooth Stack is not stateless. One possible
> > solution is to feed the reset done event to the higher layers (l2cap). But
> > than L2cap must be modified to correctly shut down all connections. It
> > would be easier if the HCI layer tracks the state of all ACL and SCO
> > connections (Marcel ??). Than a reset done event can be handled like a
> > unexpected link loss on all active connections and the higher layers do
> > not need any modifications (hopefully).
> 
> we can do this and actually calling "hcitool cc" does this already, but
> it waits indeed for a timeout of the HCI_Disconnect.

Could you give a few more details on this one, please? What I want to do is what
Pieter suggested: have the Hardware Error event trigger an unexpected link loss
on all active connections. 

Thanks,

Catalin



-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
