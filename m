Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200612191147.39325.thsuut@utu.fi>
References: <200612191103.20942.thsuut@utu.fi>
	<1166521154.29972.4.camel@violet>  <200612191147.39325.thsuut@utu.fi>
Content-Type: multipart/mixed; boundary="=-afH1bvVdA+p34kKgDLmC"
Date: Tue, 19 Dec 2006 11:31:39 +0100
Message-Id: <1166524299.29972.24.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] rfcomm_sock_sendmsg with len==0 (in Linux 2.6.18)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-afH1bvVdA+p34kKgDLmC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Tuomas,

> > > rfcomm_sock_sendmsg() in net/bluetooth/rfcomm/sock.c. It returns
> > > uninitialized variable err, if called with len==0.
> > >
> > > Simple fix is to initialize err to 0.
> >
> > this would only hide the real problem. It should only return err if
> > the sent is still 0. The return statement is
> >
> > 	return sent ? sent : err;
> 
> Yep, exactly. It returns err, which isn't initialized, so it could be 
> positive.
> 
> Am I missing something?

that is really strange. A recent compiler should detect that err can be
used uninitialized.

How about the attached patch. Does it work for you?

Regards

Marcel


--=-afH1bvVdA+p34kKgDLmC
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 544d65b..4297ff6 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -557,7 +557,6 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	struct sock *sk = sock->sk;
 	struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
 	struct sk_buff *skb;
-	int err;
 	int sent = 0;
 
 	if (msg->msg_flags & MSG_OOB)
@@ -572,6 +571,7 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 
 	while (len) {
 		size_t size = min_t(size_t, len, d->mtu);
+		int err;
 		
 		skb = sock_alloc_send_skb(sk, size + RFCOMM_SKB_RESERVE,
 				msg->msg_flags & MSG_DONTWAIT, &err);
@@ -589,6 +589,7 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 		err = rfcomm_dlc_send(d, skb);
 		if (err < 0) {
 			kfree_skb(skb);
+			sent = err;
 			break;
 		}
 
@@ -598,7 +599,7 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 
 	release_sock(sk);
 
-	return sent ? sent : err;
+	return sent;
 }
 
 static long rfcomm_sock_data_wait(struct sock *sk, long timeo)

--=-afH1bvVdA+p34kKgDLmC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-afH1bvVdA+p34kKgDLmC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-afH1bvVdA+p34kKgDLmC--
