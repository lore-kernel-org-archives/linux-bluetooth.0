Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <430B28C7.8000406@core.kaist.ac.kr>
From: Youngwoo Park <ywpark@core.kaist.ac.kr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=EUC-KR
Subject: [Bluez-devel] Bluetooth SCO message sending (sco_send_frame)
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
Date: Tue, 23 Aug 2005 22:46:47 +0900

When the SCO message size is larger than MTU, sco_send_fram function is
just returned
and sco message is not sent.

For that reason, I can't use bluetooth sound application using SCO
channel through h4 interface.
(Of course, I adjusted the MTU size more larger but failed to hear
bluetooth sound.)

I fixed it to divide bluetooth message along with the MTU size and send
more message..
Although it is not perfect, it operate well..

My patch is below..

--- linux-2.6.10/include/net/bluetooth/bluetooth.h 2004-12-25
06:34:32.000000000 +0900
+++ linux-2.6.10-modified/include/net/bluetooth/bluetooth.h 2005-07-28
08:09:38.000000000 +0900
@@ -53,6 +53,12 @@
#define SOL_SCO 17
#define SOL_RFCOMM 18

+//For Debug - ywpark
+#define CONFIG_BT_HCIUART_DEBUG
+#define CONFIG_BT_SCO_DEBUG
+#define CONFIG_BT_HCI_SOCK_DEBUG
+#define CONFIG_BT_HCI_CORE_DEBUG
+
#define BT_INFO(fmt, arg...) printk(KERN_INFO "Bluetooth: " fmt "\n" ,
## arg)
#define BT_DBG(fmt, arg...) printk(KERN_INFO "%s: " fmt "\n" ,
__FUNCTION__ , ## arg)
#define BT_ERR(fmt, arg...) printk(KERN_ERR "%s: " fmt "\n" ,
__FUNCTION__ , ## arg)
diff -uNr linux-2.6.10/net/bluetooth/sco.c
linux-2.6.10-modified/net/bluetooth/sco.c
--- linux-2.6.10/net/bluetooth/sco.c 2004-12-25 06:34:26.000000000 +0900
+++ linux-2.6.10-modified/net/bluetooth/sco.c 2005-07-28
08:09:14.000000000 +0900
@@ -235,19 +235,20 @@
return err;
}

-static inline int sco_send_frame(struct sock *sk, struct msghdr *msg,
int len)
+/*static inline int sco_send_frame(struct sock *sk, struct msghdr *msg,
int len)
{
struct sco_conn *conn = sco_pi(sk)->conn;
struct sk_buff *skb;
- int err, count;
+ int err, count;*/

/* Check outgoing MTU */
- if (len > conn->mtu)
+ /*if (len > conn->mtu)
return -EINVAL;

BT_DBG("sk %p len %d", sk, len);

count = min_t(unsigned int, conn->mtu, len);
+
if (!(skb = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT,
&err)))
return err;

@@ -261,9 +262,70 @@

return count;

+
fail:
kfree_skb(skb);
return err;
+}*/
+
+static inline int sco_send_frame(struct sock *sk, struct msghdr *msg,
int len)
+{
+ struct sco_conn *conn = sco_pi(sk)->conn;
+ struct sk_buff *skb;
+ int err, count;
+
+ //////////Modified by ywpark
+ //int offset=0;
+ //struct hci_dev *hdev = conn->hcon->hdev;
+ //////////Modified by ywpark
+
+ //////////Modified by ywpark
+ do {
+
+ //////////Modified by ywpark
+ /* Check outgoing MTU */
+ //if (len > conn->mtu)
+ // return -EINVAL;
+ //////////Modified by ywpark
+
+ BT_DBG("sk %p len %d", sk, len);
+
+ //////////Modified by ywpark
+ count = min_t(unsigned int, conn->mtu, len);
+ BT_DBG("Young : sk %p len %d", sk, len);
+ //////////Modified by ywpark
+
+ if (!(skb = bt_skb_send_alloc(sk, count, msg->msg_flags &
MSG_DONTWAIT, &err))) {
+ BT_DBG("Young : Faile to alloc");
+ return err;
+ }
+
+ if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
+ err = -EFAULT;
+ goto fail;
+ }
+
+ if ((err = hci_send_sco(conn->hcon, skb)) < 0)
+ goto fail;
+
+
+ //////////Modified by ywpark
+ len -= count;
+ //msg->msg_iov->iov_base += count;
+ //msg->msg_iov->iov_len -= count;
+ //////////Modified by ywpark
+
+ //////////Modified by ywpark
+ //return count;
+ //////////Modified by ywpark
+ } while(len > 0);
+ //////////Modified by ywpark
+
+ return len;
+
+fail:
+ BT_DBG("Young : Fail To Send", sk, len);
+ kfree_skb(skb);
+ return err;
}

static inline void sco_recv_frame(struct sco_conn *conn, struct sk_buff
*skb)
@@ -631,18 +693,26 @@

BT_DBG("sock %p, sk %p", sock, sk);

- if (sk->sk_err)
+ if (sk->sk_err) {
+ BT_DBG("Error: MSG FLAGS");
return sock_error(sk);
+ }

- if (msg->msg_flags & MSG_OOB)
+ if (msg->msg_flags & MSG_OOB) {
+ BT_DBG("Error: MSG FLAGS");
return -EOPNOTSUPP;
+ }

lock_sock(sk);

- if (sk->sk_state == BT_CONNECTED)
+ if (sk->sk_state == BT_CONNECTED) {
+ BT_DBG("Send Frame");
err = sco_send_frame(sk, msg, len);
- else
+ }
+ else {
+ BT_DBG("BT is not Connected");
err = -ENOTCONN;
+ }

release_sock(sk);
return err;


Are there any special reason for droping message?
Is there any problem or misunderstanding of my approach?


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
