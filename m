Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid and 2.4.25-mh2
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403182217.50114.cijoml@volny.cz>
References: <200403171304.37863.cijoml@volny.cz>
	 <200403182116.24096.cijoml@volny.cz> <1079642075.3301.62.camel@pegasus>
	 <200403182217.50114.cijoml@volny.cz>
Content-Type: multipart/mixed; boundary="=-1NMipAhl6EIvqG8/vAsW"
Message-Id: <1079645990.3301.68.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 18 Mar 2004 22:39:51 +0100


--=-1NMipAhl6EIvqG8/vAsW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Michal,

> > > Works without problem :) Maybe "Patch day" was not so patch :D
> > > Marcel send me in privat your mh2 patch differenced into parts and I'll
> > > find which "patch" in it si bad.
> >
> > I think it can be only this one. Please apply -mh2 and apply the
> > attached patch with -R.
> 
> That is the one :) Now it works :)

I did a fixup for the -mh2, so please apply the attached patch on top of
a -mh2 and see if it still works.

Regards

Marcel


--=-1NMipAhl6EIvqG8/vAsW
Content-Disposition: attachment; filename=patch-fix-mh2
Content-Type: text/x-patch; name=patch-fix-mh2; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

diff -urN linux-2.4.25-mh2/net/bluetooth/af_bluetooth.c linux-2.4.25-mh2-fix/net/bluetooth/af_bluetooth.c
--- linux-2.4.25-mh2/net/bluetooth/af_bluetooth.c	2004-03-18 22:29:38.000000000 +0100
+++ linux-2.4.25-mh2-fix/net/bluetooth/af_bluetooth.c	2004-03-18 22:32:55.000000000 +0100
@@ -218,20 +218,6 @@
 	return err ? : copied;
 }
 
-static inline unsigned int bluez_accept_poll(struct sock *parent)
-{
-	struct list_head *p, *n;
-	struct sock *sk;
-
-	list_for_each_safe(p, n, &bluez_pi(parent)->accept_q) {
-		sk = (struct sock *) list_entry(p, struct bluez_pinfo, accept_q);
-		if (sk->state == BT_CONNECTED)
-			return POLLIN | POLLRDNORM;
-	}
-
-	return 0;
-}
-
 unsigned int bluez_sock_poll(struct file * file, struct socket *sock, poll_table *wait)
 {
 	struct sock *sk = sock->sk;
@@ -241,9 +227,6 @@
 
 	poll_wait(file, sk->sleep, wait);
 
-	if (sk->state == BT_LISTEN)
-		return bluez_accept_poll(sk);
-
 	if (sk->err || !skb_queue_empty(&sk->error_queue))
 		mask |= POLLERR;
 
@@ -251,6 +234,7 @@
 		mask |= POLLHUP;
 
 	if (!skb_queue_empty(&sk->receive_queue) || 
+			!list_empty(&bluez_pi(sk)->accept_q) ||
 			(sk->shutdown & RCV_SHUTDOWN))
 		mask |= POLLIN | POLLRDNORM;
 

--=-1NMipAhl6EIvqG8/vAsW--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
