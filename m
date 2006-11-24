Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <019001c70fa5$dbf8e1d0$8935c70a@dlh.st.com>
References: <019001c70fa5$dbf8e1d0$8935c70a@dlh.st.com>
Content-Type: multipart/mixed; boundary="=-7c1yJH9iLRLUjxM2qsAY"
Date: Fri, 24 Nov 2006 18:25:20 +0100
Message-Id: <1164389120.28284.22.camel@localhost>
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


--=-7c1yJH9iLRLUjxM2qsAY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Sumeet,

> I have attached the kernel messages log as well as the HCI log. There is no
> ACL Disconnect after L2CAP disc response. 

the problem is that we didn't create the ACL link and so we feel not
responsible for cleaning up. However with the following patch that went
into the 2.6 kernel series a long time ago, this will be solved.

Regards

Marcel


--=-7c1yJH9iLRLUjxM2qsAY
Content-Disposition: attachment; filename=patch-hci-disconnect
Content-Type: text/plain; name=patch-hci-disconnect; charset=utf-8
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/01/13 04:17:12+01:00 marcel@holtmann.org 
#   [Bluetooth] Set disconnect timer for incoming ACL links
#   
#   In general a Bluetooth stack that creates an ACL link should also take
#   care of its termination, but some Bluetooth devices think otherwise. The
#   problem is that the Bluetooth specification don't defines an ownership
#   of an ACL link and if nobody cares about it, two devices stay connected
#   even if there is no need. To avoid leftover ACL links the disconnect
#   timer must also be used for incoming connections, but it is set twice
#   the default disconnect timeout so the other side get enough time to
#   clean everything by itself.
# 
# include/net/bluetooth/hci_core.h
#   2004/01/13 04:15:32+01:00 marcel@holtmann.org +5 -3
#   Set disconnect timer for incoming ACL links
# 
diff -Nru a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
--- a/include/net/bluetooth/hci_core.h	Tue Jan 13 04:39:32 2004
+++ b/include/net/bluetooth/hci_core.h	Tue Jan 13 04:39:32 2004
@@ -281,10 +281,12 @@
 static inline void hci_conn_put(struct hci_conn *conn)
 {
 	if (atomic_dec_and_test(&conn->refcnt)) {
-		if (conn->type == SCO_LINK)
+		if (conn->type == ACL_LINK) {
+			unsigned long timeo = (conn->out) ?
+				HCI_DISCONN_TIMEOUT : HCI_DISCONN_TIMEOUT * 2;
+			hci_conn_set_timer(conn, timeo);
+		} else
 			hci_conn_set_timer(conn, HZ / 100);
-		else if (conn->out)
-			hci_conn_set_timer(conn, HCI_DISCONN_TIMEOUT);
 	}
 }
 

--=-7c1yJH9iLRLUjxM2qsAY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-7c1yJH9iLRLUjxM2qsAY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=-7c1yJH9iLRLUjxM2qsAY--
