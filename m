Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-M89Uk2ZV4lk2uDnxETbA"
Message-Id: <1071971552.2684.28.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Apple mouse and disconnect problem
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
Date: Sun, 21 Dec 2003 02:52:32 +0100


--=-M89Uk2ZV4lk2uDnxETbA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Folks,

I played with the Apple Bluetooth mouse and I had a problem with the
termination of the ACL link after the two L2CAP channels are closed. The
ACL link still stays there, but not always. After a long time of testing
and tracking possible errors I found that the Apple mouse itself never
terminates the ACL link (like it does not role switch itself or go to
sniff mode after idle time). So the host stack has to terminate the ACL
link if no other L2CAP connection is open. In the case of BlueZ we do
this only for outgoing and not for incoming ones. And this means that if
the mouse reconnects the ACL link will never closed if we terminate the
connection because of idle time or because the bthid daemon was shut
down. I looked through the revisions of the HCI core code, but we never
close the ACL link if the connection was not created by us and so I must
assume that no one else had this problem before. However the relevant
code is in include/net/bluetooth/hci_core.h

	static inline void hci_conn_put(struct hci_conn *conn)
	{
	        if (atomic_dec_and_test(&conn->refcnt)) {
	                if (conn->type == SCO_LINK)
	                        hci_conn_set_timer(conn, HZ / 100);
	                else if (conn->out)
	                        hci_conn_set_timer(conn, HCI_DISCONN_TIMEOUT);
	        }
	}

My question is now, why we only initiate the disconnect timer for
outgoing connections? Is the device that creates the ACL link also
responsible for its termination? If yes, why the hell is the Bluetooth
stack on the Apple mouse not doing this and how did this device then got
qualified?

I used the attached patch and everything seems to be ok. Any comments?

Regards

Marcel


--=-M89Uk2ZV4lk2uDnxETbA
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- 1.13/include/net/bluetooth/hci_core.h	Thu Jun  5 02:57:06 2003
+++ edited/include/net/bluetooth/hci_core.h	Sun Dec 21 02:29:01 2003
@@ -281,10 +281,9 @@
 static inline void hci_conn_put(struct hci_conn *conn)
 {
 	if (atomic_dec_and_test(&conn->refcnt)) {
-		if (conn->type == SCO_LINK)
-			hci_conn_set_timer(conn, HZ / 100);
-		else if (conn->out)
-			hci_conn_set_timer(conn, HCI_DISCONN_TIMEOUT);
+		unsigned long timeo = (conn->type == ACL_LINK) ?
+					HCI_DISCONN_TIMEOUT : HZ / 100;
+		hci_conn_set_timer(conn, timeo);
 	}
 }
 

--=-M89Uk2ZV4lk2uDnxETbA--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
