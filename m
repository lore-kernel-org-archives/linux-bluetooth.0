Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Young <hidave.darkstar@gmail.com>
In-Reply-To: <a8e1da0710311920sa7db787s604f154f201d3a1@mail.gmail.com>
References: <20071031023017.GA3896@darkstar.te-china.tietoenator.com>
	<20071031.000141.241824894.davem@davemloft.net>
	<1193817409.32459.10.camel@violet>
	<a8e1da0710310213r1e4f3d7ckcbdf2e6bf854745e@mail.gmail.com>
	<1193824773.32459.22.camel@violet>
	<a8e1da0710311805l32282ce0ve9df9280cf7cce06@mail.gmail.com>
	<a8e1da0710311920sa7db787s604f154f201d3a1@mail.gmail.com>
Date: Thu, 01 Nov 2007 05:56:50 +0100
Message-Id: <1193893010.32459.104.camel@violet>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net, David Miller <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [Bluez-devel] [PATCH]bluetooth: hci_sysfs connection bus_id add
	support for	diffrent hci device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Dave,

> > > Maybe we can use this instead:
> > > >       snprintf(conn->dev.bus_id, BUS_ID_SIZE,
> > > > -                     "%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
> > > > +                     "%s%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
> > > > +                     hdev->name + 3,
> > > >                       conn->type == ACL_LINK ? "acl" : "sco",
> > > >                       ba->b[5], ba->b[4], ba->b[3],
> > > >                       ba->b[2], ba->b[1], ba->b[0]);
> > >
> > > I had a look on how other subsystems handle this case and yes, they
> > > duplicate the id number from its parent device. So I applied the
> > > attached patch to my tree.
>
> Sorry for my noise.
> Theoretically, for the "%d-%s" version, overwrite is also possible.
> 
> hdev->id is u16, imagine the id is 65535, then total length is 21.

even to reach 3 digits you have to attach 100 Bluetooth devices at the
same time. Tell me when you have done that ;)

However, as I said, we have to move to using the connection handle.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
