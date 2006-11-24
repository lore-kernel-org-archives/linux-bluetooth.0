Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <017801c70f8d$a9d62ea0$8935c70a@dlh.st.com>
References: <017801c70f8d$a9d62ea0$8935c70a@dlh.st.com>
Content-Type: multipart/mixed; boundary="=-y16/zUpRvlntHOr3ofeS"
Date: Fri, 24 Nov 2006 07:14:21 +0100
Message-Id: <1164348861.28284.4.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] L2CAP disconnect problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--=-y16/zUpRvlntHOr3ofeS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Sumeet,

> I investigated the RFCOMM disconnect problem in more detail and found out
> that when the device is a listener, it expects the initiator of RFCOMM
> connection to disconnect dlci 0. But all devices don't send RFCOMM DISC for
> dlci 0. For ex PTS doesn't disconnect dlci 0 in case of HS profile testing 
> Test Case: 
> -> IUT (BlueZ) is HS Gateway, PTS is HS
> -> PTS initiates connection and then disconnect
> -> RFCOMM data channel is disconnected by BlueZ but it waits for PTS to
> disconnect RFCOMM control channel which doesn't happen.
> -> As a result test case fails
> 
> The HS Spec says HS Gateway is responsible for disconnecting the connection.
> In that case I think there is a misbehaviour here.
> 
> If there is something I am missing in understanding the RFCOMM
> implementation and this problem, please correct me.
> Otherwise do you have a patch to solve this problem, wherein the listener
> disconnects dlci 0?

I told you that this was a known bug and we fixed it. You should have
tested a recent 2.6 kernel and this basically means 2.6.18 or even
later. Not an ancient RHEL4 kernel. Anyway, this is the patch that went
in upstream to fix this problem.

Regards

Marcel


--=-y16/zUpRvlntHOr3ofeS
Content-Disposition: attachment;
	filename=patch-rfcomm-incoming-session-refcount
Content-Type: text/plain; name=patch-rfcomm-incoming-session-refcount;
	charset=utf-8
Content-Transfer-Encoding: 7bit

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
 

--=-y16/zUpRvlntHOr3ofeS
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-y16/zUpRvlntHOr3ofeS
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=-y16/zUpRvlntHOr3ofeS--
