Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <430C0976.40400@core.kaist.ac.kr>
From: Youngwoo Park <ywpark@core.kaist.ac.kr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=EUC-KR
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
Date: Wed, 24 Aug 2005 14:45:26 +0900



I apologize my inexperience..

This is unified diff result..


--- linux-2.6.12/net/bluetooth/sco.c 2005-06-18 04:48:29.000000000 +0900
+++ linux-2.6.12-patch/net/bluetooth/sco.c 2005-08-24 14:33:54.517717440
+0900
@@ -234,35 +234,50 @@
return err;
}

+/**
+ * sco_send_frame
+ *
+ * Modified 2005 by Youngwoo Park
+ *
+ * Send large sco frame sequentially even if frame size is larger than MTU
+ *
+ **/
static inline int sco_send_frame(struct sock *sk, struct msghdr *msg,
int len)
{
- struct sco_conn *conn = sco_pi(sk)->conn;
- struct sk_buff *skb;
- int err, count;
+ struct sco_conn *conn = sco_pi(sk)->conn;
+ struct sk_buff *skb;
+ int err, count;

- /* Check outgoing MTU */
- if (len > conn->mtu)
- return -EINVAL;
+ do {

- BT_DBG("sk %p len %d", sk, len);
+ BT_DBG("sk %p len %d", sk, len);

- count = min_t(unsigned int, conn->mtu, len);
- if (!(skb = bt_skb_send_alloc(sk, count, msg->msg_flags &
MSG_DONTWAIT, &err)))
- return err;
+ count = min_t(unsigned int, conn->mtu, len);
+ BT_DBG("sk %p len %d", sk, len);

- if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
- err = -EFAULT;
- goto fail;
- }
+ if (!(skb = bt_skb_send_alloc(sk, count, msg->msg_flags &
MSG_DONTWAIT, &err))) {
+ BT_DBG("Faile to alloc");
+ return err;
+ }
+
+ if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
+ err = -EFAULT;
+ goto fail;
+ }

- if ((err = hci_send_sco(conn->hcon, skb)) < 0)
- goto fail;
+ if ((err = hci_send_sco(conn->hcon, skb)) < 0)
+ goto fail;

- return count;
+ len -= count;
+
+ } while(len > 0);
+
+ return len;

fail:
- kfree_skb(skb);
- return err;
+ BT_DBG("Fail To Send", sk, len);
+ kfree_skb(skb);
+ return err;
}

static inline void sco_recv_frame(struct sco_conn *conn, struct sk_buff
*skb)



If my diff format or coding style still has a problem.
Please, let me give a hint about that.

Thank you.


Regards

Park.

-- 
Youngwoo Park

M.S. Student
CORE(COmputer engineering REsearch) Lab
Dept. EECS, KAIST, Daejeon 305-701, Korea
Phone: +82-42-869-5425 Fax: +82-42-8695425
e-mail: ywpark@core.kaist.ac.kr

--




















-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
