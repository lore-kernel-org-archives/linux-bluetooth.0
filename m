Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jiri Kosina <jkosina@suse.cz>
In-Reply-To: <Pine.LNX.4.64.0705021144291.21227@twin.jikos.cz>
References: <Pine.LNX.4.64.0705021144291.21227@twin.jikos.cz>
Date: Fri, 04 May 2007 08:41:53 +0200
Message-Id: <1178260913.25425.27.camel@violet>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@linux-foundation.org>,
        bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Bluez-devel] [PATCH] Bluetooth: postpone hci_dev unregistration
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

Hi Jiri,

> (I sent this a week ago but it seems to have got lost in other noise, 
> resending)
> 
> From: Jiri Kosina <jkosina@suse.cz>
> 
> Bluetooth: postpone hci_dev unregistration
>     
> Commit b40df57 substituted bh_lock_sock() in hci_sock_dev_event() for 
> lock_sock() when unregistering HCI device, in order to prevent deadlock 
> against locking in l2cap_connect_cfm() from softirq context.
>     
> This however introduces another problem - hci_sock_dev_event() for 
> HCI_DEV_UNREG can also be triggered in atomic context, in which calling 
> lock_sock() is not safe as it could sleep. Reported by Jeremy Fitzhardinge 
> at http://lkml.org/lkml/2007/4/23/271
> 
> This patch moves the detaching of sockets from hci_device into workqueue, 
> so that lock_sock() can be used safely. This requires movement of 
> deallocation of hci_dev - deallocating device just after 
> hci_unregister_dev() would be too soon, as it could happen before the 
> workqueue has been run.

I saw the report on LKML, but I am not really comfortable with this
approach. It feels like an ugly hack. This needs more thinking and I
think that simplifying the looking between HCI and L2CAP should be the
goal.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
