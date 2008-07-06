Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Jul 2008 07:35:21 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20080704163313.GN8715@caesar.sig21.net>
Message-ID: <alpine.LNX.1.10.0807060641520.7069@nge2.ngu.pk>
References: <200807030237.57723.bluez-users-mlist@malte-wetz.de>
	<alpine.LNX.1.10.0807031905300.5583@nge2.ngu.pk>
	<20080704161718.14c7ddc3.profbunny@gmx.de>
	<20080704163313.GN8715@caesar.sig21.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1287622641-156798535-1215344123=:7069"
Subject: Re: [Bluez-users] Headset not working (was: Belkin USB-Dongle
 blocks USB subsystem)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1287622641-156798535-1215344123=:7069
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed



On Fri, 4 Jul 2008, Martin Mueller wrote:

-> > if i understand it right, i need the patch, but i don't know how can i get the patch. do you have a link for me?
-> 
-> You can get the patch from:
-> 
-> http://bluetooth-alsa.cvs.sourceforge.net/*checkout*/bluetooth-alsa/plugz/patches/sco-flowcontrol-v4.4.diff?revision=1.1
-> 
-> But the following section doesn't apply anymore to my 2.6.25 debian
-> kernel maybe someone knows how to fix it:
-> 
-> diff -ru linux-2.6.22-mh3/net/bluetooth/hci_conn.c linux-2.6.22-mh3-sco-flowcontrol/net/bluetooth/hci_conn.c
-> --- linux-2.6.22-mh3/net/bluetooth/hci_conn.c	2007-10-10 15:12:04.000000000 +0200
-> +++ linux-2.6.22-mh3-sco-flowcontrol/net/bluetooth/hci_conn.c	2007-10-10 14:31:19.000000000 +0200
-> 
-> @@ -208,6 +228,11 @@
-> 
->         skb_queue_head_init(&conn->data_q);
-> 
-> +       hrtimer_init(&conn->tx_timer, CLOCK_MONOTONIC, HRTIMER_NORESTART);
-> +
-> +       if(type == SCO_LINK)
-> +               conn->tx_timer.function = hci_sco_tx_timer;
-> +
->         init_timer(&conn->disc_timer);
->         conn->disc_timer.function = hci_conn_timeout;
->         conn->disc_timer.data = (unsigned long) conn;
-> @@ -217,6 +242,7 @@
->


We seem to be talking about different patches. I am refering to the one needed 
to allow older bluetooth (I think it's 1.2?) headsets to work with newer 
kernels, that deals with SCO/ESCO. The one above modifies another file. Below 
is the one I use, and it's working now even on linux-2.6.25.9 (kernel.org) 
that I'm currently using.


--- linux-2.6.23/net/bluetooth/hci_event.c.orig 2008-02-26 12:46:36.000000000 
+0900
+++ linux-2.6.23/net/bluetooth/hci_event.c      2008-02-26 12:47:23.000000000 
+0900
@@ -1313,8 +1313,15 @@
         hci_dev_lock(hdev);

         conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
-       if (!conn)
-               goto unlock;
+       if (!conn) {
+               __u8 link_type = (ev->link_type == ESCO_LINK) ? SCO_LINK : 
ESCO_LINK;
+
+               conn = hci_conn_hash_lookup_ba(hdev, link_type, &ev->bdaddr);
+               if (conn)
+                       conn->type = ev->link_type;
+               else
+                       goto unlock;
+       }

         if (!ev->status) {
                 conn->handle = __le16_to_cpu(ev->handle);




The email clients will probably mangle it (wrap), so I'll try to attach a 
gzipped version. If that doesn't work for some reason, I also have it on my 
ftp server 
ftp://atr2.ath.cx/pub/linux/patches/linux-kernel-bluetooth-1.2-headset-sco.patch.gz

or you can probably find it on the Web by searching for the file name 
(hci_event.c) if my server's being naughty with MSIE or curl's "@example.com" 
login.

---1287622641-156798535-1215344123=:7069
Content-Type: APPLICATION/x-gzip;
	name=linux-kernel-bluetooth-1.2-headset-sco.patch.gz
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LNX.1.10.0807060735210.7069@nge2.ngu.pk>
Content-Description: linux-kernel-bluetooth-1.2-headset-sco.patch.gz
Content-Disposition: attachment;
	filename=linux-kernel-bluetooth-1.2-headset-sco.patch.gz

H4sICPwM0EcAA2J0LTEuMi1oZWFkc2V0cy5wYXRjaACNkFFPgzAQx5/hU5wv
BgKFUhQnyyaJ8cHM6IMfoGFQB4G0y2iJxvjdbTtRN2OyvvT+vbvf/a8IIehb
rl4RibKIpDFnMl73ikkhZBM3VUvZyLiMqkjs2o1DMJ4hTBDJICH5RZanWYSn
AwG+xtgNguBE5jHuKifpH1xRAErSJA1nENg7uYSicMExoJqNtBdV5zU68ucu
6PdKcA4LMGkT0qYcGl0kOrWl69JWhsBGtNQmOyrftiyEc6PXdVnXO01BTvsC
3pnp9rVwNkIKUNwMmrvBryS8a+lQqmbwDdOjvQM6LBZw93z7RB/uH1c+3MAU
Q/7zrrkGdZL3f31rgPG2962FxaHll6sDU7aY9QOzdUcLfth/tGuapkGWUg1m
WZiQTcnr3kAp7VmSUSlotVV2731Ku3E/ATE4g0xdAgAA

---1287622641-156798535-1215344123=:7069
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
---1287622641-156798535-1215344123=:7069
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

---1287622641-156798535-1215344123=:7069--
