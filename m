Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Deleted acl-handles on failed
	hci_create_connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Gaufer <andreas.gaufer@blue-cell-networks.com>
Cc: Bluez Devel <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040610203555.273c77bd.Andreas.Gaufer@blue-cell-networks.com>
References: <20040610203555.273c77bd.Andreas.Gaufer@blue-cell-networks.com>
Content-Type: multipart/mixed; boundary="=-bTYfbb0CI/IaQv5TeAXy"
Message-Id: <1086893582.7930.55.camel@pegasus>
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
Date: Thu, 10 Jun 2004 20:53:02 +0200


--=-bTYfbb0CI/IaQv5TeAXy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andreas,

> Heres a patch for hci_event.c to fix the problem that acl-handles are removed 
> from the kernels connection hash when a hci_create_connection returnes a
> command status thats not 0x00.
> 
> One of the problems that was caused by this bug was that cc could be issued 
> even if the peer was already connected. This case leads to the error message 
> "Too many links" with sdptool and rfcomm for example. This connection could 
> only be removed if the acl handle was known otherwise or by removing power 
> from the usb-dongle (unplugg).

I think your patch is wrong, because in case of the first try through
L2CAP etc. a negative return value must result in a drop of the hci_conn
structure. Check if the attached patch is also working (againt 2.6).

Regards

Marcel


--=-bTYfbb0CI/IaQv5TeAXy
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

===== net/bluetooth/hci_event.c 1.13 vs edited =====
--- 1.13/net/bluetooth/hci_event.c	2004-05-31 22:15:12 +02:00
+++ edited/net/bluetooth/hci_event.c	2004-06-10 20:48:55 +02:00
@@ -358,7 +358,7 @@
 			status, batostr(&cp->bdaddr), conn);
 
 	if (status) {
-		if (conn) {
+		if (conn && conn->state == BT_CONNECT) {
 			conn->state = BT_CLOSED;
 			hci_proto_connect_cfm(conn, status);
 			hci_conn_del(conn);

--=-bTYfbb0CI/IaQv5TeAXy--



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
