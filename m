Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP raw socket patch
From: Marcel Holtmann <marcel@holtmann.org>
To: "Collin R. Mulliner" <collin@betaversion.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040211000722.2368d2e9.collin@betaversion.net>
References: <20040210124942.393a6da0.collin@betaversion.net>
	 <1076451408.2777.13.camel@pegasus>
	 <20040210232330.4cf4935d.collin@betaversion.net>
	 <1076452346.2777.31.camel@pegasus>
	 <20040211000722.2368d2e9.collin@betaversion.net>
Content-Type: multipart/mixed; boundary="=-/Zodkoa/0mpQZeefWq8T"
Message-Id: <1077463890.2716.53.camel@pegasus>
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
Date: Sun, 22 Feb 2004 16:31:30 +0100


--=-/Zodkoa/0mpQZeefWq8T
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Collin,

> so what do you all think about the RAW socket patch, does it make sense
> putting it into the official tree?

the original code was even wrong. If a SKB contains two or more commands
or responses the SKB will be put more than once to the raw socket. I am
going to apply the attached patch and hope we don't get a performance
decrease.

Regards

Marcel


--=-/Zodkoa/0mpQZeefWq8T
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

===== net/bluetooth/l2cap.c 1.36 vs edited =====
--- 1.36/net/bluetooth/l2cap.c	Wed Jan 14 21:56:53 2004
+++ edited/net/bluetooth/l2cap.c	Sun Feb 22 16:22:51 2004
@@ -1629,6 +1629,8 @@
 	struct l2cap_cmd_hdr cmd;
 	int err = 0;
 
+	l2cap_raw_recv(conn, skb);
+
 	while (len >= L2CAP_CMD_HDR_SIZE) {
 		memcpy(&cmd, data, L2CAP_CMD_HDR_SIZE);
 		data += L2CAP_CMD_HDR_SIZE;
@@ -1670,7 +1672,6 @@
 
 		case L2CAP_COMMAND_REJ:
 			/* FIXME: We should process this */
-			l2cap_raw_recv(conn, skb);
 			break;
 
 		case L2CAP_ECHO_REQ:
@@ -1680,11 +1681,10 @@
 		case L2CAP_ECHO_RSP:
 		case L2CAP_INFO_REQ:
 		case L2CAP_INFO_RSP:
-			l2cap_raw_recv(conn, skb);
 			break;
 
 		default:
-			BT_ERR("Uknown signaling command 0x%2.2x", cmd.code);
+			BT_ERR("Unknown signaling command 0x%2.2x", cmd.code);
 			err = -EINVAL;
 			break;
 		}

--=-/Zodkoa/0mpQZeefWq8T--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
