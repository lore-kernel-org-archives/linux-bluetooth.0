Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] Re: Small fix for L2CAP MTU
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez-devel@lists.sourceforge.net
Cc: jim.oleary@rococosoft.com, marcel@holtmann.org
In-Reply-To: <1117032403.30044.218.camel@pegasus>
References: <1117032099.5854.56.camel@baroque.rococosoft.com>
	 <1117032403.30044.218.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-O2l1LVuKXDcszbiPA8qk"
Date: Wed, 25 May 2005 16:02:39 +0100
Message-Id: <1117033359.5854.62.camel@baroque.rococosoft.com>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>


--=-O2l1LVuKXDcszbiPA8qk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

(Oops, mea culpa. diff -Naur attached.)

On Wed, 2005-05-25 at 16:46 +0200, Marcel Holtmann wrote:
> Hi Steve,
> 
> > I've attached a small change to the L2CAP layer which causes it to
> > better adhere to a sender's choice of MTU.
> > 
> > The background is that we have a test here where the client asks for an
> > omtu of 50 and tries to send more than this to the server, which in turn
> > checks that only 50 bytes were sent.
> > 
> > With the current kernel code, the omtu is always returned as the default
> > MTU (672) which causes our test to fail.
> > 
> > I've attached a patch against 2.6.11.10 (proposed by my colleague Jim
> > O'Leary) which assigns omtu from that proposed by the peer, iff we don't
> > care about the omtu.
> 
> please use unified diff. I am unable to read context diffs.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
> online with coworkers and clients while avoiding the high cost of travel and
> communications. There is no equipment to buy and you can meet as often as
> you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)

--=-O2l1LVuKXDcszbiPA8qk
Content-Disposition: attachment; filename=l2cap.patch
Content-Type: text/x-patch; name=l2cap.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- net/bluetooth/l2cap.c-	2005-05-25 15:35:10.000000000 +0100
+++ net/bluetooth/l2cap.c	2005-05-25 15:37:45.000000000 +0100
@@ -1356,12 +1356,13 @@
 
 	/* Configure output options and let the other side know
 	 * which ones we don't like. */
-	if (pi->conf_mtu < pi->omtu) {
-		l2cap_add_conf_opt(ptr, L2CAP_CONF_MTU, 2, pi->omtu);
-		result = L2CAP_CONF_UNACCEPT;
-	} else {
-		pi->omtu = pi->conf_mtu;
-	}
+	if (pi->omtu == 0) {
+		/* If we don't care about the MTU, use peer's proposal */
+                pi->omtu = pi->conf_mtu;
+	} else if (pi->conf_mtu < pi->omtu) {
+                l2cap_add_conf_opt(ptr, L2CAP_CONF_MTU, 2, pi->omtu);
+                result = L2CAP_CONF_UNACCEPT;
+        }
 
 	BT_DBG("sk %p result %d", sk, result);
 	return result;

--=-O2l1LVuKXDcszbiPA8qk--
