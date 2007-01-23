Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45B58D22.7030908@st.com>
Date: Tue, 23 Jan 2007 09:50:50 +0530
From: Mayank BATRA <mayank.batra@st.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <be976db60701221642w1a2ff16wd8f51f44e4db3185@mail.gmail.com>
In-Reply-To: <be976db60701221642w1a2ff16wd8f51f44e4db3185@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------000203000702050500060803"
Subject: Re: [Bluez-devel] SPP connections
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

This is a multi-part message in MIME format.
--------------000203000702050500060803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Mark,

> I have a program and listen for connections from a device that uses
> SPP.  My program just opens RFCOMM socket and waits for connection to
> come in.  The device that connects into my program has a connection LED
> indicating a successful connections.
> 
> I have noticed that if close my RFCOMM socket, even if I stop my
> listener process, the connection LED on the device remains lit.  The
> only thing I get it to not lit (and thus indicates that it is giving up
> on that connection) is to remove my USB bluetooth dongle.

I also faced the same problem sometime ago and Marcel gave me the
attached patch which fixed the problem.
By the way, which kernel are you using? This problem is there only in
older kernel versions.

Best Regards,

Mayank

--
Random Quote Follows:
Recursive, adj.; see Recursive

--------------000203000702050500060803
Content-Type: text/plain;
 name="patch-rfcomm-incoming-session-refcount.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-rfcomm-incoming-session-refcount.txt"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/18 13:25:42+01:00 marcel@holtmann.org 
#   [Bluetooth] Fix session reference counting for RFCOMM
#   
#   When an incoming connection terminates, the signal DLC is never
#   closed and thus the underlaying L2CAP connection stays open. This
#   problem doesn't show up often, because most times the other side
#   takes care of terminating the signal DLC.
#   
#   Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
# 
# net/bluetooth/rfcomm/core.c
#   2005/03/18 13:24:00+01:00 marcel@holtmann.org +4 -0
#   Fix session reference counting for RFCOMM
# 
diff -Nru a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
--- a/net/bluetooth/rfcomm/core.c	2005-03-18 13:30:07 +01:00
+++ b/net/bluetooth/rfcomm/core.c	2005-03-18 13:30:07 +01:00
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
 

--------------000203000702050500060803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------000203000702050500060803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------000203000702050500060803--
