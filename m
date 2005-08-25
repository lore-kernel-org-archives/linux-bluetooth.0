Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <c8850521050824203567b8914c@mail.gmail.com>
From: Young-woo Park <lucky.park@gmail.com>
To: bluez-devel@lists.sourceforge.net
Cc: ywpark@core.kaist.ac.kr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Re: Re: Bluetooth SCO message sending (sco_send_frame)
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
Date: Thu, 25 Aug 2005 12:35:47 +0900

I'm really apologize my mistake.
The problem was my e-mail sending program.
Of course, I follow up the bluez-coding style.
However the e-mail program sent message as a plain text removing tab!!!
I change my mail server now.


It's all my fault that I don't confirm my message.


Here is my patch..



--- linux-2.6.12/net/bluetooth/sco.c=092005-06-18 04:48:29.000000000 +0900
+++ linux-2.6.12-patch/net/bluetooth/sco.c=092005-08-25 10:58:44.537536256 =
+0900
@@ -234,33 +234,48 @@
 =09return err;
 }
=20
+/**
+ *  sco_send_frame
+ *
+ *  Modified 2005 by Youngwoo Park
+ *
+ *  Send large sco frame sequentially even if frame size is larger than MT=
U
+ *
+ **/
 static inline int sco_send_frame(struct sock *sk, struct msghdr *msg, int =
len)
 {
 =09struct sco_conn *conn =3D sco_pi(sk)->conn;
 =09struct sk_buff *skb;
 =09int err, count;
=20
-=09/* Check outgoing MTU */
-=09if (len > conn->mtu)
-=09=09return -EINVAL;
+=09do {
=20
-=09BT_DBG("sk %p len %d", sk, len);
+=09=09BT_DBG("sk %p len %d", sk, len);
=20
-=09count =3D min_t(unsigned int, conn->mtu, len);
-=09if (!(skb =3D bt_skb_send_alloc(sk, count, msg->msg_flags &
MSG_DONTWAIT, &err)))
-=09=09return err;
+=09=09count =3D min_t(unsigned int, conn->mtu, len);
+=09=09BT_DBG("sk %p len %d", sk, len);
=20
-=09if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
-=09=09err =3D -EFAULT;
-=09=09goto fail;
-=09}
+=09=09if (!(skb =3D bt_skb_send_alloc(sk, count, msg->msg_flags &
MSG_DONTWAIT, &err))) {
+=09=09=09BT_DBG("Faile to alloc");
+=09=09=09return err;
+=09=09}
+
+=09=09if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
+=09=09=09err =3D -EFAULT;
+=09=09=09goto fail;
+=09=09}
+
+=09=09if ((err =3D hci_send_sco(conn->hcon, skb)) < 0)
+=09=09=09goto fail;
+
+=09=09len -=3D count;
=20
-=09if ((err =3D hci_send_sco(conn->hcon, skb)) < 0)
-=09=09goto fail;
+=09} while(len > 0);
=20
-=09return count;
+=09return len;
=20
 fail:
+=09BT_DBG("Fail To Send", sk, len);
 =09kfree_skb(skb);
 =09return err;
 }

Regards

Park


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
