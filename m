Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Handling a Hardware Error event on iPAQ h5550
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20050324T130536-748@post.gmane.org>
References: 
	 <Pine.LNX.4.33.0503171141200.22782-100000@redbean.intranet.gw-instruments.de>
	 <1111057586.11792.58.camel@pegasus>
	 <loom.20050324T123636-904@post.gmane.org>
	 <1111664767.1916.54.camel@pegasus>
	 <loom.20050324T130536-748@post.gmane.org>
Content-Type: text/plain
Message-Id: <1111667700.1916.70.camel@pegasus>
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
Date: Thu, 24 Mar 2005 13:35:00 +0100

Hi Catalin,

> > > Could you give a few more details on this one, please? What I want to do is
> > > what Pieter suggested: have the Hardware Error event trigger an unexpected
> > > link loss on all active connections. 
> > 
> > if you wanna do this, then this should be done directly in the Bluetooth
> > core module in the kernel. Look at hci_event.c and add the handling for
> > the hardware error event to trigger the appropriate actions.
>  
> I know that it has to be done in hci_event.c; what I was trying to figure out
> was what the necessary actions are. As far as I've been able to tell the
> function hci_conn_hash_flush in hci_conn.c seems to do most of the work. Is that
> it or is there something else to do? Should we tasklet_kill the RX and TX tasks?

I am not 100% sure, but the right actions seem to me:

	disable RX task
	disable TX task

	lock device
	flush connection hash
	unlock device

	call flush() function of the driver

	disable cmd task

	drop rx queue
	drop cmd queue
	drop raw queue

	drop last sent command

	enable RX task
	enable TX task
	enable cmd task

It is somekind of tricky to get this fully correct and I don't have any
device to really test it. However send in a patch when you got it done.

> A somewhat unrelated question, but I could not help noticing this: in
> hci_conn.c, in function hci_conn_del there is this:
> 
> if (conn->type == SCO_LINK) {
>                 struct hci_conn *acl = conn->link;
>                 if (acl) {
>                         acl->link = NULL;
>                         hci_conn_put(acl);
>                 }
>         } else {
>                 struct hci_conn *sco = conn->link;
>                 if (sco)
>                         sco->link = NULL;
> 
>                 /* Unacked frames */
>                 hdev->acl_cnt += conn->sent;
>         }
> 
> I don't claim to have a good understanding of this code, but it seems that on
> the true branch ACL is handled and on the false branch, SCO is handled. So
> shouldn't that be:
> 
> if (conn->type != SCO_LINK)

You are wrong here. We check for conn->link and that is the associated
SCO or ACL link.

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
