Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Prepare patch bluez for the CoD in hci_conn
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1102348405.3281.4.camel@debian>
References: <1102340081.653.6.camel@debian>
	 <1102315236.8510.55.camel@pegasus>  <1102345868.2011.2.camel@debian>
	 <1102317505.8510.66.camel@pegasus>  <1102348405.3281.4.camel@debian>
Content-Type: multipart/mixed; boundary="=-lp3W4PWljO/AWHb7bELM"
Message-Id: <1102322516.8510.74.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 06 Dec 2004 09:41:56 +0100


--=-lp3W4PWljO/AWHb7bELM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Chen,

> The attachment is my patch, the comments and the debug info can be
> removed as soon as this patch is tested fully.

and your patch is quite too complex. Mine consists of three additional
lines only.

Regards

Marcel


--=-lp3W4PWljO/AWHb7bELM
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== include/net/bluetooth/hci_core.h 1.29 vs edited =====
--- 1.29/include/net/bluetooth/hci_core.h	2004-12-06 09:15:52 +01:00
+++ edited/include/net/bluetooth/hci_core.h	2004-12-06 09:26:59 +01:00
@@ -152,6 +152,7 @@
 	__u16		 state;
 	__u8		 type;
 	__u8		 out;
+	__u8		 dev_class[3];
 	__u32		 link_mode;
 	unsigned long	 pend;
 	
===== net/bluetooth/hci_conn.c 1.18 vs edited =====
--- 1.18/net/bluetooth/hci_conn.c	2004-12-06 09:16:18 +01:00
+++ edited/net/bluetooth/hci_conn.c	2004-12-06 09:38:53 +01:00
@@ -74,6 +74,7 @@
 		cp.pscan_rep_mode = ie->data.pscan_rep_mode;
 		cp.pscan_mode     = ie->data.pscan_mode;
 		cp.clock_offset   = ie->data.clock_offset | __cpu_to_le16(0x8000);
+		memcpy(conn->dev_class, ie->data.dev_class, 3);
 	}
 
 	cp.pkt_type = __cpu_to_le16(hdev->pkt_type & ACL_PTYPE_MASK);
===== net/bluetooth/hci_event.c 1.20 vs edited =====
--- 1.20/net/bluetooth/hci_event.c	2004-12-06 09:16:20 +01:00
+++ edited/net/bluetooth/hci_event.c	2004-12-06 09:29:36 +01:00
@@ -555,6 +555,7 @@
 				return;
 			}
 		}
+		memcpy(conn->dev_class, ev->dev_class, 3);
 		conn->state = BT_CONNECT;
 		hci_dev_unlock(hdev);
 

--=-lp3W4PWljO/AWHb7bELM--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
