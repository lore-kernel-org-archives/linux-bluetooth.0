Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1095804444.5762.21.camel@pegasus>
References: <001c01c4a021$b21545c0$1a01010a@baked>
	 <1095804444.5762.21.camel@pegasus>
Content-Type: text/plain
Message-Id: <1095805605.5762.24.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 22 Sep 2004 00:26:45 +0200

Hi Daryl,

> At the moment I think calling ...sock_close() and ...sock_kill() in that
> function is wrong. However I am not 100% sure.

maybe this one helps:

--- 1.29/net/bluetooth/rfcomm/sock.c    2004-06-04 02:41:47 +02:00
+++ edited/net/bluetooth/rfcomm/sock.c  2004-09-22 00:12:34 +02:00
@@ -104,8 +104,13 @@
                if (d->state == BT_CONNECTED)
                        rfcomm_session_getaddr(d->session, &bt_sk(sk)->src, NULL);
                sk->sk_state_change(sk);
-       } else
+       } else {
+               if (d->state == BT_CLOSED) {
+                       bt_accept_unlink(sk);
+                       sk->sk_zapped = 1;
+               }
                parent->sk_data_ready(parent, 0);
+       }
 
        bh_unlock_sock(sk);
 }

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
