Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1210786481.4797.4.camel@localhost.localdomain>
References: <1210786481.4797.4.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-oPCzenOg2CPAu7TU/fRj"
Date: Thu, 15 May 2008 16:15:04 +0200
Message-Id: <1210860904.7025.50.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bug report: trouble reconnecting keyboard
	after	timeout
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


--=-oPCzenOg2CPAu7TU/fRj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Dick,

> I upgraded bluez-utils and bluez-libs (3.31) and it didn't help.
> 
> I've attached a logfile, I hope it's sufficient.
> 
> My mouse and keyboard couldn't connect, I've reconnected them by
> manually disconnecting them in bluetooth-applet.

if I am not mistaken, then the attached kernel patch will fix this
issue.

Regards

Marcel


--=-oPCzenOg2CPAu7TU/fRj
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 519cdb9..96434d7 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -581,6 +581,12 @@ static int hidp_session(void *arg)
 		hid_free_device(session->hid);
 	}
 
+	/* Wakeup user-space polling for socket errors */
+	session->intr_sock->sk->sk_err = EUNATCH;
+	session->ctrl_sock->sk->sk_err = EUNATCH;
+
+	hidp_schedule(session);
+
 	fput(session->intr_sock->file);
 
 	wait_event_timeout(*(ctrl_sk->sk_sleep),
@@ -879,6 +885,10 @@ int hidp_del_connection(struct hidp_conndel_req *req)
 			skb_queue_purge(&session->ctrl_transmit);
 			skb_queue_purge(&session->intr_transmit);
 
+			/* Wakeup user-space polling for socket errors */
+			session->intr_sock->sk->sk_err = EUNATCH;
+			session->ctrl_sock->sk->sk_err = EUNATCH;
+
 			/* Kill session thread */
 			atomic_inc(&session->terminate);
 			hidp_schedule(session);

--=-oPCzenOg2CPAu7TU/fRj
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-oPCzenOg2CPAu7TU/fRj
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-oPCzenOg2CPAu7TU/fRj--
