Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Andi Kleen <ak@suse.de>
Cc: bluez-devel@lists.sf.net, netdev@oss.sgi.com,
   viro@parcelfarce.linux.org.uk
In-Reply-To: <20040207032428.56ffbebc.ak@suse.de>
References: <20040206050042.20a2b3b0.ak@suse.de>
	 <1076079512.2806.40.camel@pegasus>  <20040207032428.56ffbebc.ak@suse.de>
Content-Type: text/plain
Message-Id: <1076152411.14418.73.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: some bluetooth fixes
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 07 Feb 2004 12:13:31 +0100

Hi Andi,

> > > diff -u linux-2.6.2-work32/net/bluetooth/hci_sock.c-o linux-2.6.2-work32/net/bluetooth/hci_sock.c
> > > --- linux-2.6.2-work32/net/bluetooth/hci_sock.c-o	2004-02-05 08:09:54.000000000 +0100
> > > +++ linux-2.6.2-work32/net/bluetooth/hci_sock.c	2004-02-05 14:57:59.000000000 +0100
> > > @@ -392,6 +392,8 @@
> > >  
> > >  	skb->pkt_type = *((unsigned char *) skb->data);
> > >  	skb_pull(skb, 1);
> > > +	/* AK: looks broken. Who guarantees that hdev doesn't go away while
> > > +	   the skb is queued ? */
> > >  	skb->dev = (void *) hdev;
> > >  
> > >  	if (skb->pkt_type == HCI_COMMAND_PKT) {
> > 
> > Why should hdev go away?
> 
> Because the skbuff is queued, but there is no reference count to keep the device around.
> I wasn't 100% sure on that, so I just commented it. Feel free to remove if you think
> it's correct.

The queue itself is part of the hdev structure and the only call that
let hdev go away is hci_unregister_dev and this clears the queue. So I
don't see a problem here.

> > > diff -u linux-2.6.2-work32/net/bluetooth/hci_conn.c-o linux-2.6.2-work32/net/bluetooth/hci_conn.c
> > > --- linux-2.6.2-work32/net/bluetooth/hci_conn.c-o	2004-02-05 08:09:54.000000000 +0100
> > > +++ linux-2.6.2-work32/net/bluetooth/hci_conn.c	2004-02-05 15:06:10.000000000 +0100
> > > @@ -353,21 +353,24 @@
> > >  	struct hci_conn_info *ci;
> > >  	struct hci_dev *hdev;
> > >  	struct list_head *p;
> > > -	int n = 0, size;
> > > +	int n = 0, size, err;
> > >  
> > >  	if (copy_from_user(&req, (void *) arg, sizeof(req)))
> > >  		return -EFAULT;
> > >  
> > > -	if (!(hdev = hci_dev_get(req.dev_id)))
> > > -		return -ENODEV;
> > > +	if (req.conn_num >= (2*PAGE_SIZE)/sizeof(struct hci_conn_info))
> > > +		return -EINVAL; 
> > >  
> > >  	size = req.conn_num * sizeof(struct hci_conn_info) + sizeof(req);
> > >  
> > > -	if (verify_area(VERIFY_WRITE, (void *)arg, size))
> > > -		return -EFAULT;
> > > -
> > >  	if (!(cl = (void *) kmalloc(size, GFP_KERNEL)))
> > >  		return -ENOMEM;
> > > +
> > > +	if (!(hdev = hci_dev_get(req.dev_id))) { 
> > > +		kfree(cl);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > >  	ci = cl->conn_info;
> > >  
> > >  	hci_dev_lock_bh(hdev);
> > 
> > Why 2*PAGE_SIZE in this case? What is different?
> 
> It's just an arbitary number. Mainly to stop overflow attacks on 
> user controlled values. e.g. user can pass UINT_MAX for conn_num.
> The kmalloc would overflow and succeed. But a later loop running
> through the values could do wrong things on the too small buffer.
> The code seems to not be vunerable to this, but only by luck.
> 
> Also in general it's good practice to stop user controlled kmalloc
> at a reasonable size.

I check this. Maybe we have more of them. What do you propose as max
size value for kmalloc? 2*PAGE_SIZE or 4*PAGE_SIZE?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
