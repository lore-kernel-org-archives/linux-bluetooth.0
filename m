Return-Path: <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] broadcast and qos
From: Max Krasnyansky <maxk@qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mauro Tortonesi <mtortonesi@ing.unife.it>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074302495.2629.140.camel@pegasus>
References: <200401131559.37742.mtortonesi@ing.unife.it>
	 <1074288506.2559.438.camel@localhost>  <1074302495.2629.140.camel@pegasus>
Content-Type: text/plain
Message-Id: <1074632340.1707.177.camel@localhost>
Mime-Version: 1.0
Date: Tue, 20 Jan 2004 12:59:00 -0800
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2004-01-16 at 17:21, Marcel Holtmann wrote:
> do you have a link for this patch, because I can't remember that I read
> something like that.

Here is what I was referring to. btw Patch is probably messed up
(spaces, etc) but it shouldn't be applied as is anyway.

Max

-----

> From: Martin Neuhaeusser <martin@weh.rwth-aachen.de>
> To: bluez-devel@lists.sourceforge.net
> User-Agent: Mutt/1.3.28i
> Subject: [Bluez-devel] ACL Broadcasts (was: dgram socket question)
> Sender: bluez-devel-admin@lists.sourceforge.net
> X-BeenThere: bluez-devel@lists.sourceforge.net
> X-Mailman-Version: 2.0.9-sf.net
> List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
> List-Post: <mailto:bluez-devel@lists.sourceforge.net>
> List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
>         <mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
> List-Id: <bluez-devel.lists.sourceforge.net>
> List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
>         <mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
> List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
> X-Original-Date: Tue, 08 Apr 2003 23:27:42 +0200
> Date: Tue, 08 Apr 2003 23:27:42 +0200
> 
> Hi all!
>  
> As mentioned in the old thread, I've been trying to get some
> kind of active broadcasts working with the BlueZ stack.
> The basic idea was to use a datagram socket for sending and
> receiving broadcast packets. To get this working on the L2CAP
> layer (broadcasts aren't mentioned in the L2CAP spec, right?),
> I defined a special broadcast-address; if the userland application
> sends via a datagram socket to this address, my code creates
> a virtual hci-connection (as broadcasts aren't connection oriented)
> that handles the broadcast on the HCI layer.
> As part of a project at my university, we tested this implementation
> with up to seven devices (3com (USB+PCMCIA), Acer (USB), Epox (USB))
> and it worked fine. Only the Write_Num_Broadcast_Retransmission
> Command seems not to work correctly together with fragmented
> baseband packets (DM1).
>  
> Apart from the support for (active) broadcasts, there are some
> (in my opinion) bugs in the datagram code that are fixed by the patch
> (see old thread for a discussion on that).
>  
> Best regards,
>  
> --
>                         \|||/
>                         (o o)
>             ---------ooO-(_)-Ooo---------
>  
> Martin Neuh?u?er             Tel.  : +49 241 9973278
> R?tscher Stra?e 165          Mobil : +49 172 8966488
> 52072 Aachen, Germany        GnuPG : 0x16FDB298
>  

 
diff -BbNur linux-2.4.20-mh5/include/net/bluetooth/bluetooth.h
linux-2.4.20-bc/include/net/bluetooth/bluetooth.h---
linux-2.4.20-mh5/include/net/bluetooth/bluetooth.h  Sat Aug  3 02:39:46
2002
+++ linux-2.4.20-bc/include/net/bluetooth/bluetooth.h   Thu Apr  3
09:53:13 2003
@@ -23,7 +23,7 @@
 */
  
 /*
- *  $Id: bluetooth.h,v 1.9 2002/05/06 21:11:55 maxk Exp $
+ *  $Id: bluetooth.h,v 1.3 2003/03/26 11:50:13 martin Exp $
  */
  
 #ifndef __BLUETOOTH_H
@@ -114,6 +114,11 @@
  
 #define BDADDR_ANY   (&(bdaddr_t) {{0, 0, 0, 0, 0, 0}})
 #define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff}})
+
+/* some definitions for piconet broadcasts */
+#define BDADDR_ACTIVEBCAST (&(bdaddr_t) {{0xff, 0xff, 0xff, 0xff, 0xff,
0xff}})
+#define CID_PICOBCAST      0x0EFE
+#define CID_ACTIVEBCAST    0x0EFF
  
 /* Copy, swap, convert BD Address */
 static inline int bacmp(bdaddr_t *ba1, bdaddr_t *ba2)
diff -BbNur linux-2.4.20-mh5/include/net/bluetooth/hci_core.h
linux-2.4.20-bc/include/net/bluetooth/hci_core.h
--- linux-2.4.20-mh5/include/net/bluetooth/hci_core.h   Tue Mar 25
14:15:25 2003
+++ linux-2.4.20-bc/include/net/bluetooth/hci_core.h    Thu Apr  3
09:53:23 2003
@@ -23,7 +23,7 @@
 */
  
 /*
- * $Id: hci_core.h,v 1.5 2002/06/27 04:56:30 maxk Exp $
+ * $Id: hci_core.h,v 1.1 2003/03/26 11:42:15 martin Exp $
  */
  
 #ifndef __HCI_CORE_H
@@ -252,6 +252,7 @@
 }
  
 void hci_acl_connect(struct hci_conn *conn);
+void hci_bcast_connect(struct hci_conn *conn);
 void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
 void hci_add_sco(struct hci_conn *conn, __u16 handle);
  
diff -BbNur linux-2.4.20-mh5/net/bluetooth/af_bluetooth.c
linux-2.4.20-bc/net/bluetooth/af_bluetooth.c
--- linux-2.4.20-mh5/net/bluetooth/af_bluetooth.c       Fri Nov 29
00:53:15 2002
+++ linux-2.4.20-bc/net/bluetooth/af_bluetooth.c        Thu Apr  3
09:52:45 2003
@@ -25,7 +25,7 @@
 /*
  * BlueZ Bluetooth address family and sockets.
  *
- * $Id: af_bluetooth.c,v 1.8 2002/07/22 20:32:54 maxk Exp $
+ * $Id: af_bluetooth.c,v 1.3 2003/03/25 13:01:46 martin Exp $
  */
 #define VERSION "2.2"
  
diff -BbNur linux-2.4.20-mh5/net/bluetooth/hci_conn.c
linux-2.4.20-bc/net/bluetooth/hci_conn.c
--- linux-2.4.20-mh5/net/bluetooth/hci_conn.c   Fri Nov 29 00:53:15 2002
+++ linux-2.4.20-bc/net/bluetooth/hci_conn.c    Thu Apr  3 09:52:45 2003
@@ -25,7 +25,7 @@
 /*
  * HCI Connection handling.
  *
- * $Id: hci_conn.c,v 1.5 2002/07/17 18:46:25 maxk Exp $
+ * $Id: hci_conn.c,v 1.9 2003/03/26 11:49:53 martin Exp $
  */
  
 #include <linux/config.h>
@@ -80,15 +80,27 @@
        }
  
        cp.pkt_type = __cpu_to_le16(hdev->pkt_type & ACL_PTYPE_MASK);
+
        if (lmp_rswitch_capable(hdev) && !(hdev->link_mode &
HCI_LM_MASTER))
-               cp.role_switch  = 0x01;
+               cp.role_switch  = 0x01;  /* role-switch supported */
        else
-               cp.role_switch  = 0x00;
+               cp.role_switch  = 0x00;  /* we will not accept
role-switch */
                 
        hci_send_cmd(hdev, OGF_LINK_CTL, OCF_CREATE_CONN,
                                CREATE_CONN_CP_SIZE, &cp);
 }
  
+/* The hci_bcast_connect function creates a virtual connection to the
broadcast
+ * address. Since there is no HCI-Layer connection for broadcasts, we
only
+ * set some values of the hci_conn structure. */
+void hci_bcast_connect(struct hci_conn *conn)
+{
+       conn->state = BT_CONNECTED;
+       conn->out   = 1;
+       conn->link_mode = HCI_LM_MASTER;
+       conn->handle = CID_ACTIVEBCAST;
+}
+
 void hci_acl_disconn(struct hci_conn *conn, __u8 reason)
 {
        disconnect_cp cp;
@@ -97,10 +109,21 @@
  
        conn->state = BT_DISCONN;
  
+        /* here we have to check if we are called to disconnect
+         * a broadcast connection. For these connections we
+         * must not send any HCI commands since broadcasts are
+         * connectionless */
+        if (conn->handle != CID_ACTIVEBCAST) {
        cp.handle = __cpu_to_le16(conn->handle);
        cp.reason = reason;
        hci_send_cmd(conn->hdev, OGF_LINK_CTL, OCF_DISCONNECT,
                                DISCONNECT_CP_SIZE, &cp);
+        }
+        else {
+               conn->state = BT_CLOSED;
+               hci_proto_disconn_ind(conn, reason);
+               hci_conn_del(conn);
+        }
 }
  
 void hci_add_sco(struct hci_conn *conn, __u16 handle)
@@ -264,6 +287,31 @@
  
        hci_conn_hold(acl);
  
+       /* here we check if we have to deal with a HCI connection to the
+         * broadcast address BDADDR_ACTIVEBCAST. If so, we create a
special
+         * connection for the broadcast (which is connectionless) */
+        if (!bacmp(dst, BDADDR_ACTIVEBCAST) && (type == ACL_LINK)) {
+               struct hci_conn *ret = acl;
+
+               switch (acl->state)
+               {
+               case BT_OPEN:
+               case BT_CLOSED:
+                       /* in case of a closed socket, we create a new
pseudo connection to
+                       * for broadcasts */
+                       hci_bcast_connect(acl);
+                       break;
+               case BT_CONNECTED:
+                       /* here we are sure that the socket is already
connected to
+                       * the broadcast address. We just use it and
don't connect */
+                       break;
+               default:
+                       /* default error handler */
+                       ret = NULL;
+               }
+               return ret;
+       }
+
        if (acl->state == BT_OPEN || acl->state == BT_CLOSED)
                hci_acl_connect(acl);
  
diff -BbNur linux-2.4.20-mh5/net/bluetooth/hci_core.c
linux-2.4.20-bc/net/bluetooth/hci_core.c
--- linux-2.4.20-mh5/net/bluetooth/hci_core.c   Tue Mar 25 14:15:25 2003
+++ linux-2.4.20-bc/net/bluetooth/hci_core.c    Thu Apr  3 09:52:45 2003
@@ -25,7 +25,7 @@
 /*
  * BlueZ HCI Core.
  *
- * $Id: hci_core.c,v 1.14 2002/08/26 16:57:57 maxk Exp $
+ * $Id: hci_core.c,v 1.5 2003/03/26 18:06:18 martin Exp $
  */
  
 #include <linux/config.h>
@@ -972,6 +972,8 @@
        /* Get rid of skb owner, prior to sending to the driver. */
        skb_orphan(skb);
  
+        /* SENDME */
+
        return hdev->send(skb);
 }
  
@@ -1290,9 +1292,24 @@
  
        hdev->stat.acl_rx++;
  
+        /* in case of a broadcast packet, we get the connection handle
+         * of the baseband connection which makes the receiver of the
+         * broadcast member of the piconet. */
+        if (flags & ACL_ACTIVE_BCAST) {
+               handle = CID_ACTIVEBCAST;
        hci_dev_lock(hdev);
        conn = conn_hash_lookup_handle(hdev, handle);
        hci_dev_unlock(hdev);
+               if (!conn) {
+                       conn = hci_conn_add(hdev, ACL_LINK,
BDADDR_ACTIVEBCAST);
+                       hci_bcast_connect(conn);
+               }
+       }
+       else {
+               hci_dev_lock(hdev);
+               conn = conn_hash_lookup_handle(hdev, handle);
+               hci_dev_unlock(hdev);
+       }
         
        if (conn) {
                register struct hci_proto *hp;
@@ -1302,11 +1318,10 @@
                        hp->recv_acldata(conn, skb, flags);
                        return;
                }
-       } else {
+       }
+       else
                BT_ERR("%s ACL packet for unknown connection handle %d",
                        hdev->name, handle);
-       }
-
        kfree_skb(skb);
 }
  
diff -BbNur linux-2.4.20-mh5/net/bluetooth/hci_event.c
linux-2.4.20-bc/net/bluetooth/hci_event.c
--- linux-2.4.20-mh5/net/bluetooth/hci_event.c  Fri Nov 29 00:53:15 2002
+++ linux-2.4.20-bc/net/bluetooth/hci_event.c   Thu Apr  3 09:52:45 2003
@@ -25,7 +25,7 @@
 /*
  * HCI Events.
  *
- * $Id: hci_event.c,v 1.4 2002/07/27 18:14:38 maxk Exp $
+ * $Id: hci_event.c,v 1.5 2003/03/26 07:02:54 martin Exp $
  */
  
 #include <linux/config.h>
diff -BbNur linux-2.4.20-mh5/net/bluetooth/hci_sock.c
linux-2.4.20-bc/net/bluetooth/hci_sock.c
--- linux-2.4.20-mh5/net/bluetooth/hci_sock.c   Tue Mar 25 14:15:25 2003
+++ linux-2.4.20-bc/net/bluetooth/hci_sock.c    Thu Apr  3 09:52:45 2003
@@ -25,7 +25,7 @@
 /*
  * BlueZ HCI socket layer.
  *
- * $Id: hci_sock.c,v 1.5 2002/07/22 20:32:54 maxk Exp $
+ * $Id: hci_sock.c,v 1.1 2003/03/18 20:21:46 martin Exp $
  */
  
 #include <linux/config.h>
diff -BbNur linux-2.4.20-mh5/net/bluetooth/l2cap.c
linux-2.4.20-bc/net/bluetooth/l2cap.c
--- linux-2.4.20-mh5/net/bluetooth/l2cap.c      Tue Mar 25 14:15:25 2003
+++ linux-2.4.20-bc/net/bluetooth/l2cap.c       Thu Apr  3 09:52:45 2003
@@ -25,7 +25,7 @@
 /*
  * BlueZ L2CAP core and sockets.
  *
- * $Id: l2cap.c,v 1.15 2002/09/09 01:14:52 maxk Exp $
+ * $Id: l2cap.c,v 1.12 2003/03/26 18:06:19 martin Exp $
  */
 #define VERSION "2.1"
  
@@ -207,7 +207,10 @@
  
                        /* Closest match */
                        if (!bacmp(&bluez_pi(sk)->src, BDADDR_ANY))
+                        {
                                sk1 = sk;
+                          break;
+                        }
                }
        }
        return sk ? sk : sk1;
@@ -254,6 +257,8 @@
  */
 static void l2cap_sock_kill(struct sock *sk)
 {
+        /* here we check whether there is a BSD socket this sock
structure
+         * is linked to. If not, we release it */
        if (!sk->zapped || sk->socket)
                return;
  
@@ -503,7 +508,14 @@
                goto wait;
  
        case BT_CONNECTED:
-               /* Already connected */
+               /* Already connected: If we are dealing with a
SOCK_DGRAM,
+                 * another connect-call closes the current connection
and
+                 * established a new one to the specified address */
+               if ((sk->type == SOCK_DGRAM) &&
+                               (bacmp(&bluez_pi(sk)->dst,
&la->l2_bdaddr))) {
+                       __l2cap_sock_close(sk, 0);
+                       break;
+               }
                goto done;
  
        case BT_OPEN:
@@ -647,6 +659,15 @@
        if (msg->msg_flags & MSG_OOB)
                return -EOPNOTSUPP;
  
+        if ((sk->type == SOCK_DGRAM)
+                       && (msg->msg_namelen == sizeof(struct
sockaddr_l2))) {
+               struct sockaddr_l2 *dst = (struct sockaddr_l2
*)msg->msg_name;
+
+               l2cap_sock_connect(sock, (struct sockaddr *)dst,
sizeof(struct sockaddr_l2), 0);
+               if (!bacmp(&dst->l2_bdaddr, BDADDR_ACTIVEBCAST))
+                       msg->msg_flags |= ACL_ACTIVE_BCAST;
+        }
+
        /* Check outgoing MTU */
        if (len > l2cap_pi(sk)->omtu)
                return -EINVAL;
@@ -662,6 +683,47 @@
        return err;
 }
  
+static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
int len, int flags, struct scm_cookie *scm)
+{
+       int                     noblock = flags & MSG_DONTWAIT;
+       struct                  sock *sk = sock->sk;
+       struct                  sk_buff *skb;
+       int                     copied, err;
+       struct sockaddr_l2*     l2addr = (struct sockaddr_l2
*)msg->msg_name;
+
+       BT_DBG("sock %p sk %p len %d", sock, sk, len);
+
+       if (flags & (MSG_OOB))
+               return -EOPNOTSUPP;
+
+       if (!(skb = skb_recv_datagram(sk, flags, noblock, &err))) {
+               if (sk->shutdown & RCV_SHUTDOWN) return 0;
+               return err;
+       }
+
+       msg->msg_namelen = 0;
+
+       if (l2addr) {
+               l2addr->l2_family = AF_BLUETOOTH;
+               l2addr->l2_psm    = l2cap_pi(sk)->psm;
+               bacpy(&l2addr->l2_bdaddr, &bluez_pi(sk)->dst);
+               msg->msg_namelen = sizeof(struct sockaddr_l2);
+       }
+
+       copied = skb->len;
+       if (len < copied) {
+               msg->msg_flags |= MSG_TRUNC;
+               copied = len;
+       }
+
+       skb->h.raw = skb->data;
+       err = skb_copy_datagram_iovec(skb, 0, msg->msg_iov, copied);
+
+       skb_free_datagram(sk, skb);
+
+       return err ? : copied;
+}
+
 static int l2cap_sock_setsockopt(struct socket *sock, int level, int
optname, char *optval, int optlen)
 {
        struct sock *sk = sock->sk;
@@ -1018,7 +1080,10 @@
        else
                hlen = L2CAP_HDR_SIZE;
  
+       if (conn)
        count = MIN(conn->mtu - hlen, len);
+       else
+               count = len;
  
        skb = bluez_skb_send_alloc(sk, hlen + count,
                        msg->msg_flags & MSG_DONTWAIT, &err);
@@ -1061,8 +1126,14 @@
                frag = &(*frag)->next;
        }
  
+       if ((sk->type == SOCK_DGRAM) && (msg->msg_flags &&
ACL_ACTIVE_BCAST)) {
+               if ((err = hci_send_acl(conn->hcon, skb,
ACL_ACTIVE_BCAST)))
+                       goto fail;
+       }
+       else {
        if ((err = hci_send_acl(conn->hcon, skb, 0)) < 0)
                goto fail;
+       }
  
        return sent;
  
@@ -1729,6 +1800,12 @@
        if (l2cap_pi(sk)->imtu < skb->len)
                goto drop;
  
+        /* here we write the address of the sender of the message
+         * to the socket. Since with SOCK_DGRAM sockets, there
+         * may be several recipients who have a connection with us
+         * the remote party of the socket isn't enough information */
+       bacpy(&bluez_pi(sk)->dst, conn->dst);
+
        if (!sock_queue_rcv_skb(sk, skb))
                goto done;
  
@@ -1757,6 +1834,9 @@
                break;
  
        case 0x0002:
+               /* If we have a frame from a connectionless data channel
(0x0002),
+                 * the header is two bytes longer: These two bytes are
the PSM that
+                 * is extracted here */
                psm = get_unaligned((__u16 *) skb->data);
                skb_pull(skb, 2);
                l2cap_conless_channel(conn, psm, skb);
@@ -1770,6 +1850,9 @@
  
 /* ------------ L2CAP interface with lower layer (HCI) ------------- */
  
+/* l2cap_connect_ind is called to indicate a new connection on the HCI
+ * layer to the L2CAP layer. The bdaddr parameter contains the address
+ * of the remote host, type contains info ACL or SCO connection */
 static int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
__u8 type)
 {
        int exact = 0, lm1 = 0, lm2 = 0;
@@ -1782,21 +1865,37 @@
  
        /* Find listening sockets and check their link_mode */
        read_lock(&l2cap_sk_list.lock);
-       for (sk = l2cap_sk_list.head; sk; sk = sk->next) {
-               if (sk->state != BT_LISTEN)
-                       continue;
+       for (sk = l2cap_sk_list.head; sk; sk = sk->next)
+        {
+               if ((sk->type == SOCK_DGRAM) && (sk->state == BT_BOUND))
{
+                       /* here we have an unconnected SOCK_DGRAM that
could
+                       * receive a message */
+                       if (!bacmp(&bluez_pi(sk)->src, bdaddr)) {
+                               lm1 |= (HCI_LM_ACCEPT |
l2cap_pi(sk)->link_mode);
+                               exact++;
+                       }
+                       else
+                               if (!bacmp(&bluez_pi(sk)->src,
BDADDR_ANY))
+                                       lm2 |= (HCI_LM_ACCEPT |
l2cap_pi(sk)->link_mode);
+               }
  
+               if (sk->state == BT_LISTEN) {
                if (!bacmp(&bluez_pi(sk)->src, bdaddr)) {
                        lm1 |= (HCI_LM_ACCEPT |
l2cap_pi(sk)->link_mode);
                        exact++;
-               } else if (!bacmp(&bluez_pi(sk)->src, BDADDR_ANY))
+                       }
+                       else
+                               if (!bacmp(&bluez_pi(sk)->src,
BDADDR_ANY))
                        lm2 |= (HCI_LM_ACCEPT |
l2cap_pi(sk)->link_mode);
        }
+       }
        read_unlock(&l2cap_sk_list.lock);
  
        return exact ? lm1 : lm2;
 }
  
+/* l2cap_connect_cfm is called whenever a new connection is established
+ * on the lower (HCI) layer */
 static int l2cap_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
        BT_DBG("hcon %p bdaddr %s status %d", hcon, batostr(&hcon->dst),
status);
@@ -1922,6 +2021,8 @@
        return 0;
 }
  
+/* this function is called when the lower (HCI) layer receives an ACL
+ * packet for the L2CAP layer */
 static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff
*skb, __u16 flags)
 {
        struct l2cap_conn *conn = hcon->l2cap_data;
@@ -1936,6 +2037,9 @@
                int len;
  
                if (conn->rx_len) {
+                       if (flags & ACL_ACTIVE_BCAST)
+                               BT_ERR("broadcast fragmentation error:
%d bytes missing.", conn->rx_len);
+                       else
                        BT_ERR("Unexpected start frame (len %d)",
skb->len);
                        kfree_skb(conn->rx_skb);
                        conn->rx_skb = NULL;
@@ -2052,7 +2156,7 @@
        accept:         l2cap_sock_accept,
        getname:        l2cap_sock_getname,
        sendmsg:        l2cap_sock_sendmsg,
-       recvmsg:        bluez_sock_recvmsg,
+       recvmsg:        l2cap_sock_recvmsg,
        poll:           bluez_sock_poll,
        socketpair:     sock_no_socketpair,
        ioctl:          sock_no_ioctl,
 
---- 
 
