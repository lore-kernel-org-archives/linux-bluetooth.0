Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <431F0CEB.30605@palmsource.com>
From: Frederic Danis <frederic.danis@palmsource.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] LM_AUTH and LM_ENCRYPT support	for	outgoing
 sockets
References: <4316C4A0.1070100@palmsource.com>	 <1125922059.11955.15.camel@pegasus>  <431F0401.4010808@palmsource.com> <1126107009.10631.69.camel@blade>
In-Reply-To: <1126107009.10631.69.camel@blade>
Content-Type: multipart/mixed;
 boundary="------------070404000401000209050506"
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
Date: Wed, 07 Sep 2005 17:53:15 +0200

This is a multi-part message in MIME format.
--------------070404000401000209050506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

Find attached the l2cap patch.

Regards

Fred

-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic            PalmSource Europe
Software engineer
Mail : mailto:frederic.danis@palmsource.com
-----------------------------------------------



Marcel Holtmann wrote:

>Hi Fred,
>
>  
>
>>This patch can help us to develop an application to create pairing 
>>between devices with no need to be root. Further more, in Handsfree 
>>profile it is written that : "If both devices support authentication and 
>>encryption, the application on either device may require its use."
>>    
>>
>
>I don't really like it, but I already opened my mind to accept such a
>patch. However this must be tested a lot so we can be sure that it
>doesn't break any state machine.
>
>  
>
>>I have updated the patch so it should no more break userspace.
>>    
>>
>
>The RFCOMM part is wrong. You can't set the LM mode of RFCOMM to the
>underlaying L2CAP. This means that the authentication/encryption will be
>triggered when the L2CAP connection is created and not on the SABM at
>RFCOMM level.
>
>Please drop the RFCOMM part for now and send in patch that only modifies
>the L2CAP layer. We need to get this right and tested first anyhow.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>SF.Net email is Sponsored by the Better Software Conference & EXPO
>September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
>Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
>Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>  
>

--------------070404000401000209050506
Content-Type: text/plain;
 name="patch-l2cap-2.6.12.5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-l2cap-2.6.12.5"

diff -ruN linux-2.6.12.5/net/bluetooth/l2cap.c linux-2.6.12.5-fda/net/bluetooth/l2cap.c
--- linux-2.6.12.5/net/bluetooth/l2cap.c	2005-08-15 02:20:18.000000000 +0200
+++ linux-2.6.12.5-fda/net/bluetooth/l2cap.c	2005-09-07 16:35:56.335412288 +0200
@@ -498,6 +498,15 @@
 	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 
 	if (hcon->state == BT_CONNECTED) {
+		if ((l2cap_pi(sk)->link_mode & L2CAP_LM_ENCRYPT) ||
+				(l2cap_pi(sk)->link_mode & L2CAP_LM_SECURE)) {
+			if (!hci_conn_encrypt(conn->hcon))
+				goto done;
+		} else if (l2cap_pi(sk)->link_mode & L2CAP_LM_AUTH) {
+			if (!hci_conn_auth(conn->hcon))
+				goto done;
+		}
+
 		if (sk->sk_type == SOCK_SEQPACKET) {
 			struct l2cap_conn_req req;
 			l2cap_pi(sk)->ident = l2cap_get_ident(conn);
@@ -1091,6 +1100,15 @@
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
 		bh_lock_sock(sk);
 
+		if ((l2cap_pi(sk)->link_mode & L2CAP_LM_ENCRYPT) ||
+				(l2cap_pi(sk)->link_mode & L2CAP_LM_SECURE)) {
+			if (!hci_conn_encrypt(conn->hcon))
+				goto done;
+		} else if (l2cap_pi(sk)->link_mode & L2CAP_LM_AUTH) {
+			if (!hci_conn_auth(conn->hcon))
+				goto done;
+		}
+
 		if (sk->sk_type != SOCK_SEQPACKET) {
 			l2cap_sock_clear_timer(sk);
 			sk->sk_state = BT_CONNECTED;
@@ -1103,6 +1121,7 @@
 			l2cap_send_cmd(conn, l2cap_pi(sk)->ident, L2CAP_CONN_REQ, sizeof(req), &req);
 		}
 
+done:
 		bh_unlock_sock(sk);
 	}
 
@@ -1972,28 +1991,47 @@
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
 		bh_lock_sock(sk);
 
-		if (sk->sk_state != BT_CONNECT2 ||
+		if ((sk->sk_state != BT_CONNECT && sk->sk_state != BT_CONNECT2) ||
 				(l2cap_pi(sk)->link_mode & L2CAP_LM_ENCRYPT) ||
 				(l2cap_pi(sk)->link_mode & L2CAP_LM_SECURE)) {
 			bh_unlock_sock(sk);
 			continue;
 		}
 
-		if (!status) {
-			sk->sk_state = BT_CONFIG;
-			result = 0;
-		} else {
-			sk->sk_state = BT_DISCONN;
-			l2cap_sock_set_timer(sk, HZ/10);
-			result = L2CAP_CR_SEC_BLOCK;
-		}
+		if (sk->sk_state == BT_CONNECT) {
+			if (status) {
+				l2cap_chan_del(sk, ECONNREFUSED);
+				continue;
+			}
 
-		rsp.scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
-		rsp.dcid   = __cpu_to_le16(l2cap_pi(sk)->scid);
-		rsp.result = __cpu_to_le16(result);
-		rsp.status = __cpu_to_le16(0);
-		l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
-				L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+			if (sk->sk_type == SOCK_SEQPACKET) {
+				struct l2cap_conn_req req;
+				l2cap_pi(sk)->ident = l2cap_get_ident(conn);
+				req.scid = __cpu_to_le16(l2cap_pi(sk)->scid);
+				req.psm  = l2cap_pi(sk)->psm;
+				l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
+						L2CAP_CONN_REQ, sizeof(req), &req);
+			} else {
+				l2cap_sock_clear_timer(sk);
+				sk->sk_state = BT_CONNECTED;
+			}
+		} else if (sk->sk_state == BT_CONNECT2) {
+			if (!status) {
+				sk->sk_state = BT_CONFIG;
+				result = 0;
+			} else {
+				sk->sk_state = BT_DISCONN;
+				l2cap_sock_set_timer(sk, HZ/10);
+				result = L2CAP_CR_SEC_BLOCK;
+			}
+
+			rsp.scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
+			rsp.dcid   = __cpu_to_le16(l2cap_pi(sk)->scid);
+			rsp.result = __cpu_to_le16(result);
+			rsp.status = __cpu_to_le16(0);
+			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
+					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+		}
 
 		bh_unlock_sock(sk);
 	}
@@ -2021,29 +2059,48 @@
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
 		bh_lock_sock(sk);
 
-		if (sk->sk_state != BT_CONNECT2) {
+		if (sk->sk_state != BT_CONNECT && sk->sk_state != BT_CONNECT2) {
 			bh_unlock_sock(sk);
 			continue;
 		}
 
-		if (!status) {
-			sk->sk_state = BT_CONFIG;
-			result = 0;
-		} else {
-			sk->sk_state = BT_DISCONN;
-			l2cap_sock_set_timer(sk, HZ/10);
-			result = L2CAP_CR_SEC_BLOCK;
-		}
+		if (sk->sk_state == BT_CONNECT) {
+			if (status) {
+				l2cap_chan_del(sk, ECONNREFUSED);
+				continue;
+			}
 
-		rsp.scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
-		rsp.dcid   = __cpu_to_le16(l2cap_pi(sk)->scid);
-		rsp.result = __cpu_to_le16(result);
-		rsp.status = __cpu_to_le16(0);
-		l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
-				L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+			if (sk->sk_type == SOCK_SEQPACKET) {
+				struct l2cap_conn_req req;
+				l2cap_pi(sk)->ident = l2cap_get_ident(conn);
+				req.scid = __cpu_to_le16(l2cap_pi(sk)->scid);
+				req.psm  = l2cap_pi(sk)->psm;
+				l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
+						L2CAP_CONN_REQ, sizeof(req), &req);
+			} else {
+				l2cap_sock_clear_timer(sk);
+				sk->sk_state = BT_CONNECTED;
+			}
+		} else if (sk->sk_state == BT_CONNECT2) {
+			if (!status) {
+				sk->sk_state = BT_CONFIG;
+				result = 0;
+			} else {
+				sk->sk_state = BT_DISCONN;
+				l2cap_sock_set_timer(sk, HZ/10);
+				result = L2CAP_CR_SEC_BLOCK;
+			}
 
-		if (l2cap_pi(sk)->link_mode & L2CAP_LM_SECURE)
-			hci_conn_change_link_key(hcon);
+			rsp.scid   = __cpu_to_le16(l2cap_pi(sk)->dcid);
+			rsp.dcid   = __cpu_to_le16(l2cap_pi(sk)->scid);
+			rsp.result = __cpu_to_le16(result);
+			rsp.status = __cpu_to_le16(0);
+			l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
+					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+
+			if (l2cap_pi(sk)->link_mode & L2CAP_LM_SECURE)
+				hci_conn_change_link_key(hcon);
+		}
 
 		bh_unlock_sock(sk);
 	}
 

--------------070404000401000209050506--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
