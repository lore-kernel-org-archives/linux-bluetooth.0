Return-Path: <steve.crane@rococosoft.com>
Subject: RFComm dynamic channel allocation
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez-devel@lists.sourceforge.net
Cc: marcel@holtmann.org
Content-Type: multipart/mixed; boundary="=-LC+wIiYYCJOPafbN8bON"
Message-Id: <1085138236.2777.10.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: Fri, 21 May 2004 12:17:17 +0100
List-ID: <bluez-devel.lists.sourceforge.net>


--=-LC+wIiYYCJOPafbN8bON
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
The attached patch (against 2.6.6) provides dynamic channel allocation
for RFComm listening sockets. This means that you can bind to channel #0
and the kernel will allocate a channel for you when you call listen() on
it. Retrieve the allocated channel number via getsockname().

The only query I have is what to return if there are no free channels.
Is ENOMEM right?

Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)

--=-LC+wIiYYCJOPafbN8bON
Content-Disposition: attachment; filename=rfcomm.dynamic.patch
Content-Type: text/x-patch; name=rfcomm.dynamic.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- net/bluetooth/rfcomm/sock.c-	2004-05-21 11:49:58.375676516 +0100
+++ net/bluetooth/rfcomm/sock.c	2004-05-21 12:00:33.374126744 +0100
@@ -397,6 +397,19 @@
 		err = -EBADFD;
 		goto done;
 	}
+	if (!rfcomm_pi(sk)->channel) {
+		u8 channel;
+		bdaddr_t *src = &bt_sk(sk)->src;
+		for (channel = 1; channel < 31; channel++)
+			if (!__rfcomm_get_sock_by_addr(channel, src)) {
+				rfcomm_pi(sk)->channel = channel;
+				break;
+			}
+		if (channel == 31) {
+			err = -ENOMEM;
+			goto done;
+		}
+	}
 
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;

--=-LC+wIiYYCJOPafbN8bON--
