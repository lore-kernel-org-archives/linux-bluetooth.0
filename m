Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP raw socket patch
From: Marcel Holtmann <marcel@holtmann.org>
To: "Collin R. Mulliner" <collin@betaversion.net>
Cc: bluez-devel@lists.sf.net
In-Reply-To: <20040210124942.393a6da0.collin@betaversion.net>
References: <20040210124942.393a6da0.collin@betaversion.net>
Content-Type: multipart/mixed; boundary="=-OdhMGfp2/4wIOATf7QEV"
Message-Id: <1076451408.2777.13.camel@pegasus>
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
Date: Tue, 10 Feb 2004 23:16:48 +0100


--=-OdhMGfp2/4wIOATf7QEV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Collin,

> I have written a small patch for l2cap.c to improve the capabilities of
> L2CAP raw sockets. Currently only very few responses travel back to a
> RAW socket (which is very bad if you need to see command responses).
> The patch is very simple - it just puts all responses on the
> Sig-Channel to all open RAW sockets. The owner of the raw socket just
> needs to select his packets and in normal operation there shouldn't be
> much use of RAW sockets so I don't think this is a performance issue.

do anyone have comments about this patch?

> I have attached the patch file to this email, hope this is ok.

BTW this patch is wrong, because we must keep the case statements.
Otherwise the kernel log will be filled with unneeded error messages.

Regards

Marcel


--=-OdhMGfp2/4wIOATf7QEV
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

diff -urN linux-2.6.2/net/bluetooth/l2cap.c linux-2.6.2-mh/net/bluetooth/l2cap.c
--- linux-2.6.2/net/bluetooth/l2cap.c	2004-02-04 04:44:04.000000000 +0100
+++ linux-2.6.2-mh/net/bluetooth/l2cap.c	2004-02-10 23:04:49.000000000 +0100
@@ -1643,6 +1643,8 @@
 			break;
 		}
 
+		l2cap_raw_recv(conn, skb);
+
 		switch (cmd.code) {
 		case L2CAP_CONN_REQ:
 			err = l2cap_connect_req(conn, &cmd, data);
@@ -1670,7 +1672,6 @@
 
 		case L2CAP_COMMAND_REJ:
 			/* FIXME: We should process this */
-			l2cap_raw_recv(conn, skb);
 			break;
 
 		case L2CAP_ECHO_REQ:
@@ -1680,7 +1681,6 @@
 		case L2CAP_ECHO_RSP:
 		case L2CAP_INFO_REQ:
 		case L2CAP_INFO_RSP:
-			l2cap_raw_recv(conn, skb);
 			break;
 
 		default:

--=-OdhMGfp2/4wIOATf7QEV--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
