Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Jul 2008 18:33:13 +0200
From: Martin Mueller <lists@sig21.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20080704163313.GN8715@caesar.sig21.net>
References: <200807030237.57723.bluez-users-mlist@malte-wetz.de>
	<alpine.LNX.1.10.0807031905300.5583@nge2.ngu.pk>
	<20080704161718.14c7ddc3.profbunny@gmx.de>
MIME-Version: 1.0
In-Reply-To: <20080704161718.14c7ddc3.profbunny@gmx.de>
Subject: Re: [Bluez-users] Headset not working (was: Belkin
	USB-Dongle	blocks USB subsystem)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Moin,

On Fri, Jul 04, 2008 at 04:17:18PM +0200, Michael Domann wrote:
> 
> if i understand it right, i need the patch, but i don't know how can i get the patch. do you have a link for me?

You can get the patch from:

http://bluetooth-alsa.cvs.sourceforge.net/*checkout*/bluetooth-alsa/plugz/patches/sco-flowcontrol-v4.4.diff?revision=1.1

But the following section doesn't apply anymore to my 2.6.25 debian
kernel maybe someone knows how to fix it:

diff -ru linux-2.6.22-mh3/net/bluetooth/hci_conn.c linux-2.6.22-mh3-sco-flowcontrol/net/bluetooth/hci_conn.c
--- linux-2.6.22-mh3/net/bluetooth/hci_conn.c	2007-10-10 15:12:04.000000000 +0200
+++ linux-2.6.22-mh3-sco-flowcontrol/net/bluetooth/hci_conn.c	2007-10-10 14:31:19.000000000 +0200

@@ -208,6 +228,11 @@
 
        skb_queue_head_init(&conn->data_q);
 
+       hrtimer_init(&conn->tx_timer, CLOCK_MONOTONIC, HRTIMER_NORESTART);
+
+       if(type == SCO_LINK)
+               conn->tx_timer.function = hci_sco_tx_timer;
+
        init_timer(&conn->disc_timer);
        conn->disc_timer.function = hci_conn_timeout;
        conn->disc_timer.data = (unsigned long) conn;
@@ -217,6 +242,7 @@

bye
  MM
--
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
