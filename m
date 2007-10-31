Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20071031.000141.241824894.davem@davemloft.net>
References: <20071031023017.GA3896@darkstar.te-china.tietoenator.com>
	<20071031.000141.241824894.davem@davemloft.net>
Date: Wed, 31 Oct 2007 08:56:49 +0100
Message-Id: <1193817409.32459.10.camel@violet>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
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

> > diff -upr linux/net/bluetooth/hci_sysfs.c linux.new/net/bluetooth/hci_sysfs.c
> > --- linux/net/bluetooth/hci_sysfs.c	2007-10-31 10:21:00.000000000 +0800
> > +++ linux.new/net/bluetooth/hci_sysfs.c	2007-10-31 10:21:55.000000000 +0800
> > @@ -302,7 +302,8 @@ void hci_conn_add_sysfs(struct hci_conn 
> >  	conn->dev.release = bt_release;
> >  
> >  	snprintf(conn->dev.bus_id, BUS_ID_SIZE,
> > -			"%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
> > +			"%s%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
> > +			hdev->name,
> >  			conn->type == ACL_LINK ? "acl" : "sco",
> >  			ba->b[5], ba->b[4], ba->b[3],
> >  			ba->b[2], ba->b[1], ba->b[0]);
> 
> This might not work.
> 
> Your device's name is already 15 characters long,
> BUS_ID_SIZE is 20, and it seems hdev->name could
> easily overflow the 4 or 5 characters of space
> remaining.

and should also be not needed since their parents are different. However
we had to add the connections to a bus. Otherwise the userspace will
never see them. I have to think about the right solution for this
problem.

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
