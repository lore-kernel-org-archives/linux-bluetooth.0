Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=AfBHtuGAcvDJJ8zChCBj_2at-NGBDv4jT8J+L@mail.gmail.com>
References: <1294046076-3712-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1294046076-3712-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<AANLkTi=AfBHtuGAcvDJJ8zChCBj_2at-NGBDv4jT8J+L@mail.gmail.com>
Date: Mon, 10 Jan 2011 17:16:12 +0200
Message-ID: <AANLkTikAXqiu4eZEp_58zkJZvraoZCjG7t62pjPRyP3P@mail.gmail.com>
Subject: Re: [PATCHv4] Bluetooth: Use non-flushable by default L2CAP data packets
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 7, 2011 at 1:08 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> On Mon, Jan 3, 2011 at 11:14 AM, Emeltchenko Andrei
> <Andrei.Emeltchenko.news@gmail.com> wrote:
>> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>>
>> Modification of Nick Pelly <npelly@google.com> patch.
>>
>> With Bluetooth 2.1 ACL packets can be flushable or non-flushable. This commit
>> makes ACL data packets non-flushable by default on compatible chipsets, and
>> adds the BT_FLUSHABLE socket option to explicitly request flushable ACL
>> data packets for a given L2CAP socket. This is useful for A2DP data which can
>> be safely discarded if it can not be delivered within a short time (while
>> other ACL data should not be discarded).
>>
>> Note that making ACL data flushable has no effect unless the automatic flush
>> timeout for that ACL link is changed from its default of 0 (infinite).
>>
>> Default packet types (for compatible chipsets):
>> Frame 34: 13 bytes on wire (104 bits), 13 bytes captured (104 bits)
>> Bluetooth HCI H4
>> Bluetooth HCI ACL Packet
>>    .... 0000 0000 0010 = Connection Handle: 0x0002
>>    ..00 .... .... .... = PB Flag: First Non-automatically Flushable Packet (0)
>>    00.. .... .... .... = BC Flag: Point-To-Point (0)
>>    Data Total Length: 8
>> Bluetooth L2CAP Packet
>>
>> After setting BT_FLUSHABLE
>> (sock.setsockopt(274 /*SOL_BLUETOOTH*/, 8 /* BT_FLUSHABLE */, 1 /* flush */))
>> Frame 34: 13 bytes on wire (104 bits), 13 bytes captured (104 bits)
>> Bluetooth HCI H4
>> Bluetooth HCI ACL Packet
>>    .... 0000 0000 0010 = Connection Handle: 0x0002
>>    ..10 .... .... .... = PB Flag: First Automatically Flushable Packet (2)
>>    00.. .... .... .... = BC Flag: Point-To-Point (0)
>>    Data Total Length: 8
>> Bluetooth L2CAP Packet
>>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.
>> ---
>>  include/net/bluetooth/bluetooth.h |    5 +++
>>  include/net/bluetooth/hci.h       |    2 +
>>  include/net/bluetooth/hci_core.h  |    1 +
>>  include/net/bluetooth/l2cap.h     |    1 +
>>  net/bluetooth/hci_core.c          |    7 +++-
>>  net/bluetooth/l2cap.c             |   59 ++++++++++++++++++++++++++++++++++--
>>  6 files changed, 69 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>> index 0c5e725..ed7d775 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -64,6 +64,11 @@ struct bt_security {
>>
>>  #define BT_DEFER_SETUP 7
>>
>> +#define BT_FLUSHABLE   8
>> +
>> +#define BT_FLUSHABLE_OFF       0
>> +#define BT_FLUSHABLE_ON                1
>> +
>>  #define BT_INFO(fmt, arg...) printk(KERN_INFO "Bluetooth: " fmt "\n" , ## arg)
>>  #define BT_ERR(fmt, arg...)  printk(KERN_ERR "%s: " fmt "\n" , __func__ , ## arg)
>>  #define BT_DBG(fmt, arg...)  pr_debug("%s: " fmt "\n" , __func__ , ## arg)
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 29a7a8c..5d033dc 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -150,6 +150,7 @@ enum {
>>  #define EDR_ESCO_MASK  (ESCO_2EV3 | ESCO_3EV3 | ESCO_2EV5 | ESCO_3EV5)
>>
>>  /* ACL flags */
>> +#define ACL_START_NO_FLUSH     0x00
>>  #define ACL_CONT               0x01
>>  #define ACL_START              0x02
>>  #define ACL_ACTIVE_BCAST       0x04
>> @@ -194,6 +195,7 @@ enum {
>>  #define LMP_EDR_3S_ESCO        0x80
>>
>>  #define LMP_SIMPLE_PAIR        0x08
>> +#define LMP_NO_FLUSH   0x40
>>
>>  /* Connection modes */
>>  #define HCI_CM_ACTIVE  0x0000
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index a29feb0..59135a6 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -457,6 +457,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>>  #define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
>>  #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
>>  #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
>> +#define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
>>
>>  /* ----- HCI protocols ----- */
>>  struct hci_proto {
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index 7ad25ca..7f88a87 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -327,6 +327,7 @@ struct l2cap_pinfo {
>>        __u8            sec_level;
>>        __u8            role_switch;
>>        __u8            force_reliable;
>> +       __u8            flushable;
>>
>>        __u8            conf_req[64];
>>        __u8            conf_len;
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 8b602d8..3c0990d 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1391,7 +1391,7 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
>>
>>        skb->dev = (void *) hdev;
>>        bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
>> -       hci_add_acl_hdr(skb, conn->handle, flags | ACL_START);
>> +       hci_add_acl_hdr(skb, conn->handle, flags);
>>
>>        list = skb_shinfo(skb)->frag_list;
>>        if (!list) {
>> @@ -1409,12 +1409,15 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
>>                spin_lock_bh(&conn->data_q.lock);
>>
>>                __skb_queue_tail(&conn->data_q, skb);
>> +
>> +               flags &= ~ACL_START;
>> +               flags |= ACL_CONT;
>>                do {
>>                        skb = list; list = list->next;
>>
>>                        skb->dev = (void *) hdev;
>>                        bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
>> -                       hci_add_acl_hdr(skb, conn->handle, flags | ACL_CONT);
>> +                       hci_add_acl_hdr(skb, conn->handle, flags);
>>
>>                        BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index c791fcd..ff191b9 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -362,13 +362,19 @@ static inline u8 l2cap_get_ident(struct l2cap_conn *conn)
>>  static inline void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data)
>>  {
>>        struct sk_buff *skb = l2cap_build_cmd(conn, code, ident, len, data);
>> +       u8 flags;
>>
>>        BT_DBG("code 0x%2.2x", code);
>>
>>        if (!skb)
>>                return;
>>
>> -       hci_send_acl(conn->hcon, skb, 0);
>> +       if (lmp_no_flush_capable(conn->hcon->hdev))
>> +               flags = ACL_START_NO_FLUSH;
>> +       else
>> +               flags = ACL_START;
>> +
>> +       hci_send_acl(conn->hcon, skb, flags);
>>  }
>>
>>  static inline void l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
>> @@ -378,6 +384,7 @@ static inline void l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
>>        struct l2cap_conn *conn = pi->conn;
>>        struct sock *sk = (struct sock *)pi;
>>        int count, hlen = L2CAP_HDR_SIZE + 2;
>> +       u8 flags;
>>
>>        if (sk->sk_state != BT_CONNECTED)
>>                return;
>> @@ -414,7 +421,12 @@ static inline void l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
>>                put_unaligned_le16(fcs, skb_put(skb, 2));
>>        }
>>
>> -       hci_send_acl(pi->conn->hcon, skb, 0);
>> +       if (lmp_no_flush_capable(conn->hcon->hdev))
>> +               flags = ACL_START_NO_FLUSH;
>> +       else
>> +               flags = ACL_START;
>> +
>> +       hci_send_acl(pi->conn->hcon, skb, flags);
>>  }
>>
>>  static inline void l2cap_send_rr_or_rnr(struct l2cap_pinfo *pi, u16 control)
>> @@ -900,6 +912,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
>>                pi->sec_level = l2cap_pi(parent)->sec_level;
>>                pi->role_switch = l2cap_pi(parent)->role_switch;
>>                pi->force_reliable = l2cap_pi(parent)->force_reliable;
>> +               pi->flushable = l2cap_pi(parent)->flushable;
>>        } else {
>>                pi->imtu = L2CAP_DEFAULT_MTU;
>>                pi->omtu = 0;
>> @@ -915,6 +928,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
>>                pi->sec_level = BT_SECURITY_LOW;
>>                pi->role_switch = 0;
>>                pi->force_reliable = 0;
>> +               pi->flushable = BT_FLUSHABLE_OFF;
>>        }
>>
>>        /* Default config options */
>> @@ -1450,10 +1464,17 @@ static void l2cap_drop_acked_frames(struct sock *sk)
>>  static inline void l2cap_do_send(struct sock *sk, struct sk_buff *skb)
>>  {
>>        struct l2cap_pinfo *pi = l2cap_pi(sk);
>> +       struct hci_conn *hcon = pi->conn->hcon;
>> +       u16 flags;
>>
>>        BT_DBG("sk %p, skb %p len %d", sk, skb, skb->len);
>>
>> -       hci_send_acl(pi->conn->hcon, skb, 0);
>> +       if (!pi->flushable && lmp_no_flush_capable(hcon->hdev))
>> +               flags = ACL_START_NO_FLUSH;
>> +       else
>> +               flags = ACL_START;
>> +
>> +       hci_send_acl(hcon, skb, flags);
>>  }
>>
>>  static void l2cap_streaming_send(struct sock *sk)
>> @@ -2098,6 +2119,30 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
>>                bt_sk(sk)->defer_setup = opt;
>>                break;
>>
>> +       case BT_FLUSHABLE:
>> +               if (get_user(opt, (u32 __user *) optval)) {
>> +                       err = -EFAULT;
>> +                       break;
>> +               }
>> +
>> +               if (opt > BT_FLUSHABLE_ON) {
>> +                       err = -EINVAL;
>> +                       break;
>> +               }
>> +
>> +               if (opt == BT_FLUSHABLE_OFF) {
>> +                       struct l2cap_conn *conn = l2cap_pi(sk)->conn;
>> +                       /* proceed futher only when we have l2cap_conn and
>> +                          No Flush support in the LM */
>> +                       if (!conn || !lmp_no_flush_capable(conn->hcon->hdev)) {
>> +                               err = -EINVAL;
>> +                               break;
>> +                       }
>> +               }
>> +
>> +               l2cap_pi(sk)->flushable = opt;
>> +               break;
>> +
>>        default:
>>                err = -ENOPROTOOPT;
>>                break;
>> @@ -2237,6 +2282,12 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
>>
>>                break;
>>
>> +       case BT_FLUSHABLE:
>> +               if (put_user(l2cap_pi(sk)->flushable, (u32 __user *) optval))
>> +                       err = -EFAULT;
>> +
>> +               break;
>> +
>>        default:
>>                err = -ENOPROTOOPT;
>>                break;
>> @@ -4697,7 +4748,7 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
>>
>>        BT_DBG("conn %p len %d flags 0x%x", conn, skb->len, flags);
>>
>> -       if (flags & ACL_START) {
>> +       if (!(flags & ACL_CONT)) {
>>                struct l2cap_hdr *hdr;
>>                struct sock *sk;
>>                u16 cid;
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> ping
>

any comments?
