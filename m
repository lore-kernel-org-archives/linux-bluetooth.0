Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <430B3F5F.6070908@core.kaist.ac.kr>
From: Youngwoo Park <ywpark@core.kaist.ac.kr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=EUC-KR
Subject: [Bluez-devel] Re: Bluetooth SCO message sending (sco_send_frame) (Marcel Holtmann)
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
Date: Wed, 24 Aug 2005 00:23:11 +0900



I'm sorry about my coding style and thank you for your comment.
I modified sco_send_frame() function like following..


Before Modification...
-----------------

/*static inline int sco_send_frame(struct sock *sk, struct msghdr *msg,
int len)
{
struct sco_conn *conn = sco_pi(sk)->conn;
struct sk_buff *skb;
int err, count;*/

/* Check outgoing MTU */
if (len > conn->mtu)
return -EINVAL;

BT_DBG("sk %p len %d", sk, len);

count = min_t(unsigned int, conn->mtu, len);
if (!(skb = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT,
&err)))
return err;

if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
err = -EFAULT;
goto fail;
}

if ((err = hci_send_sco(conn->hcon, skb)) < 0)
goto fail;

return count;


fail:
kfree_skb(skb);
return err;
}*/



After Modification...
----------------

/**
* sco_send_frame - send sco frame
*
* Modified 2005 by Youngwoo Park
*
* Send large sco frame sequentially even if frame size is larger than MTU
*
**/
static inline int sco_send_frame(struct sock *sk, struct msghdr *msg,
int len)
{
struct sco_conn *conn = sco_pi(sk)->conn;
struct sk_buff *skb;
int err, count;

do {

BT_DBG("sk %p len %d", sk, len);

count = min_t(unsigned int, conn->mtu, len);

if (!(skb = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT,
&err))) {
BT_DBG("Faile to alloc");
return err;
}

if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
err = -EFAULT;
goto fail;
}

if ((err = hci_send_sco(conn->hcon, skb)) < 0)
goto fail;

len -= count;

} while(len > 0);

return len;

fail:
BT_DBG("Fail To Send", sk, len);
kfree_skb(skb);
return err;
}



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
