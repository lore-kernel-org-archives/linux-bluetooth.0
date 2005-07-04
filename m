Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: ville.tervo@nokia.com
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1120490370.30194.50.camel@localhost.localdomain>
References: <1120490370.30194.50.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-mT9vnyt+l3jRt9lyfiAF"
Message-Id: <1120490944.10273.164.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: rfcomm oops
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
Date: Mon, 04 Jul 2005 17:29:04 +0200


--=-mT9vnyt+l3jRt9lyfiAF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ville,

> I found reproducible way to make rfcomm layer oops. I attached oops and
> some notes how they were produced. I used several Nokia phones and IBM
> T40 laptop in these tests.

if the attached patch makes it go away, then I know what it is. Actually
I introduced that problem when I tried to fix another bug with buggy
phones that can't disconnect their DLCI 0 even if they established it.

Regards

Marcel


--=-mT9vnyt+l3jRt9lyfiAF
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -389,8 +389,6 @@ static int __rfcomm_dlc_close(struct rfc
 		rfcomm_dlc_unlock(d);
 
 		skb_queue_purge(&d->tx_queue);
-		rfcomm_session_put(s);
-
 		rfcomm_dlc_unlink(d);
 	}
 
@@ -600,8 +598,6 @@ static struct rfcomm_session *rfcomm_ses
 		goto failed;
 	}
 
-	rfcomm_session_hold(s);
-
 	s->initiator = 1;
 
 	bacpy(&addr.l2_bdaddr, dst);

--=-mT9vnyt+l3jRt9lyfiAF--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
