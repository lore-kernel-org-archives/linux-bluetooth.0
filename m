Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Connection with
	aphonestaysopenafterclosingRFCOMM channel
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1109952903.8058.72.camel@pegasus>
References: <Pine.LNX.4.44.0503032110450.24841-100000@antilope>
	 <1109952903.8058.72.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-UeLdBC2wVQgXcPuP1CR4"
Message-Id: <1110390729.5462.21.camel@notepaq>
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
Date: Wed, 09 Mar 2005 18:52:09 +0100


--=-UeLdBC2wVQgXcPuP1CR4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Victor,

> > Hope that explains....
> 
> it does not explain it, but this is what I expected. Another reference
> counting problem. Maybe introduced at that time I fixed another one of
> these crazy problems. Funny is that this does not result in an oops. The
> easiest way to fix this is, if you send me one of these phones, because
> otherwise it will take quite some time to reproduce it.

try the attached patch. It fixes it for me when I tested this with a
Nokia 6310.

Regards

Marcel


--=-UeLdBC2wVQgXcPuP1CR4
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== net/bluetooth/rfcomm/core.c 1.49 vs edited =====
--- 1.49/net/bluetooth/rfcomm/core.c	2005-01-23 19:59:56 +01:00
+++ edited/net/bluetooth/rfcomm/core.c	2005-03-09 11:27:46 +01:00
@@ -389,6 +389,8 @@
 		rfcomm_dlc_unlock(d);
 
 		skb_queue_purge(&d->tx_queue);
+		rfcomm_session_put(s);
+
 		rfcomm_dlc_unlink(d);
 	}
 
@@ -597,6 +599,8 @@
 		*err = -ENOMEM;
 		goto failed;
 	}
+
+	rfcomm_session_hold(s);
 
 	s->initiator = 1;
 

--=-UeLdBC2wVQgXcPuP1CR4--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
