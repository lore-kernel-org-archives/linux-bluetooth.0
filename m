Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Young <hidave.darkstar@gmail.com>
In-Reply-To: <a8e1da0710310213r1e4f3d7ckcbdf2e6bf854745e@mail.gmail.com>
References: <20071031023017.GA3896@darkstar.te-china.tietoenator.com>
	<20071031.000141.241824894.davem@davemloft.net>
	<1193817409.32459.10.camel@violet>
	<a8e1da0710310213r1e4f3d7ckcbdf2e6bf854745e@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-ymq5j0ZohrYXUT6+QU9b"
Date: Wed, 31 Oct 2007 10:59:32 +0100
Message-Id: <1193824773.32459.22.camel@violet>
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
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-ymq5j0ZohrYXUT6+QU9b
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Dave,

> > > > diff -upr linux/net/bluetooth/hci_sysfs.c linux.new/net/bluetooth/hci_sysfs.c
> > > > --- linux/net/bluetooth/hci_sysfs.c 2007-10-31 10:21:00.000000000 +0800
> > > > +++ linux.new/net/bluetooth/hci_sysfs.c     2007-10-31 10:21:55.000000000 +0800
> > > > @@ -302,7 +302,8 @@ void hci_conn_add_sysfs(struct hci_conn
> > > >     conn->dev.release = bt_release;
> > > >
> > > >     snprintf(conn->dev.bus_id, BUS_ID_SIZE,
> > > > -                   "%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
> > > > +                   "%s%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
> > > > +                   hdev->name,
> > > >                     conn->type == ACL_LINK ? "acl" : "sco",
> > > >                     ba->b[5], ba->b[4], ba->b[3],
> > > >                     ba->b[2], ba->b[1], ba->b[0]);
> > >
> > > This might not work.
> > >
> > > Your device's name is already 15 characters long,
> > > BUS_ID_SIZE is 20, and it seems hdev->name could
> > > easily overflow the 4 or 5 characters of space
> > > remaining.
> >
> > and should also be not needed since their parents are different. However
> > we had to add the connections to a bus. Otherwise the userspace will
> > never see them. I have to think about the right solution for this
> > problem.
> 
> Maybe we can use this instead:
>  	snprintf(conn->dev.bus_id, BUS_ID_SIZE,
> -			"%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
> +			"%s%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
> +			hdev->name + 3,
>  			conn->type == ACL_LINK ? "acl" : "sco",
>  			ba->b[5], ba->b[4], ba->b[3],
>  			ba->b[2], ba->b[1], ba->b[0]);

I had a look on how other subsystems handle this case and yes, they
duplicate the id number from its parent device. So I applied the
attached patch to my tree.

The best would be to use '"%d-%d", hdev->id, conn->handle', but at the
time we create the hci_conn structure and add the sysfs entry the
connection handle is not know yet. I have to look into that and see if
that can be changed.

Regards

Marcel


--=-ymq5j0ZohrYXUT6+QU9b
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index cef1e3e..0cd9bd5 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -302,8 +302,8 @@ void hci_conn_add_sysfs(struct hci_conn *conn)
 	conn->dev.release = bt_release;
 
 	snprintf(conn->dev.bus_id, BUS_ID_SIZE,
-			"%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
-			conn->type == ACL_LINK ? "acl" : "sco",
+			"%d-%s%2.2X%2.2X%2.2X%2.2X%2.2X%2.2X",
+			hdev->id, conn->type == ACL_LINK ? "acl" : "sco",
 			ba->b[5], ba->b[4], ba->b[3],
 			ba->b[2], ba->b[1], ba->b[0]);
 

--=-ymq5j0ZohrYXUT6+QU9b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--=-ymq5j0ZohrYXUT6+QU9b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-ymq5j0ZohrYXUT6+QU9b--
