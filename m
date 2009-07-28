Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: gfpadovan@gmail.com
In-Reply-To: <1248688751.28545.184.camel@violet>
References: <1248675424-20977-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248675424-20977-2-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248688751.28545.184.camel@violet>
Date: Tue, 28 Jul 2009 08:24:40 -0300
Message-ID: <6b53b1990907280424l461f6f4du3cc162d14bc73877@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: Add initial support for ERTM packets
	transfers
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jul 27, 2009 at 6:59 AM, Marcel Holtmann<marcel@holtmann.org> wrote=
:
> Hi Gustavo,
>

>> +static struct sk_buff *l2cap_create_pdu(struct sock *sk, struct msghdr =
*msg, size_t len, u16 *control)
>
> Why does control have to be a pointer here. You are not modifying its
> content anyway.

Because control could be 0 too. So I pass the control =3D NULL when we
don't  want control field.

>
>> +{
>> + =A0 =A0 struct l2cap_conn *conn =3D l2cap_pi(sk)->conn;
>> + =A0 =A0 struct sk_buff *skb;
>> + =A0 =A0 int err, count, hlen =3D L2CAP_HDR_SIZE;
>> + =A0 =A0 struct l2cap_hdr *lh;
>> +
>> + =A0 =A0 BT_DBG("sk %p len %d", sk, (int)len);
>> +
>> + =A0 =A0 if (control)
>> + =A0 =A0 =A0 =A0 =A0 =A0 hlen +=3D 2;
>> + =A0 =A0 else if (sk->sk_type =3D=3D SOCK_DGRAM)
>> + =A0 =A0 =A0 =A0 =A0 =A0 hlen +=3D 2;
>
> An if (control || sk->sk_type =3D=3D ...) would do the same here. I know
> wanna make it the same as below, but it is confusing.
>
>> +
>> + =A0 =A0 count =3D min_t(unsigned int, (conn->mtu - hlen), len);
>> + =A0 =A0 skb =3D bt_skb_send_alloc(sk, count + hlen,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->msg_flags & MSG_DONTWAIT,=
 &err);
>> + =A0 =A0 if (!skb)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);
>> +
>> + =A0 =A0 /* Create L2CAP header */
>> + =A0 =A0 lh =3D (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
>> + =A0 =A0 lh->cid =3D cpu_to_le16(l2cap_pi(sk)->dcid);
>> + =A0 =A0 lh->len =3D cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
>> +
>> + =A0 =A0 if (control)
>> + =A0 =A0 =A0 =A0 =A0 =A0 put_unaligned_le16(*control, skb_put(skb, 2));
>> + =A0 =A0 else if (sk->sk_type =3D=3D SOCK_DGRAM)
>> + =A0 =A0 =A0 =A0 =A0 =A0 put_unaligned_le16(l2cap_pi(sk)->psm, skb_put(=
skb, 2));
>> +
>> + =A0 =A0 err =3D l2cap_skbuff_fromiovec(sk, msg, len, count, skb);
>> + =A0 =A0 if (unlikely(err < 0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree_skb(skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(err);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return skb;
>> =A0}
>>
>> =A0static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock=
, struct msghdr *msg, size_t len)
>> =A0{
>> =A0 =A0 =A0 struct sock *sk =3D sock->sk;
>> - =A0 =A0 int err =3D 0;
>> + =A0 =A0 struct l2cap_pinfo *pi =3D l2cap_pi(sk);
>> + =A0 =A0 struct sk_buff *skb;
>> + =A0 =A0 u16 control;
>> + =A0 =A0 int err;
>>
>> =A0 =A0 =A0 BT_DBG("sock %p, sk %p", sock, sk);
>>
>> @@ -1238,16 +1339,61 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb=
, struct socket *sock, struct ms
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
>>
>> =A0 =A0 =A0 /* Check outgoing MTU */
>> - =A0 =A0 if (sk->sk_type !=3D SOCK_RAW && len > l2cap_pi(sk)->omtu)
>> + =A0 =A0 if ((sk->sk_type !=3D SOCK_RAW || pi->mode =3D=3D L2CAP_MODE_B=
ASIC)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && len > pi->omtu)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> I am confused now. Wouldn't it be better to check for =3D=3D SOCK_SEQPACK=
ET
> and that it is basic mode and that the len in smaller than the MTU.

So do we need to add a new check? One for SOCK_RAW (the old) and for
the other you told?

>
>> =A0 =A0 =A0 lock_sock(sk);
>>
>> - =A0 =A0 if (sk->sk_state =3D=3D BT_CONNECTED)
>> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D l2cap_do_send(sk, msg, len);
>> - =A0 =A0 else
>> + =A0 =A0 if (sk->sk_state !=3D BT_CONNECTED) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOTCONN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 switch (pi->mode) {
>> + =A0 =A0 case L2CAP_MODE_BASIC:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Create a basic PDU */
>> + =A0 =A0 =A0 =A0 =A0 =A0 skb =3D l2cap_create_pdu(sk, msg, len, NULL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(skb)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D l2cap_do_send(sk, skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D len;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case L2CAP_MODE_ERTM:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Entire SDU fits into one PDU */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (len <=3D pi->omtu) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 control =3D L2CAP_SDU_UNSEGMEN=
TED;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb =3D l2cap_create_pdu(sk, m=
sg, len, &control);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(skb)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ER=
R(skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: Segmentation will be=
 added later */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 __skb_queue_tail(TX_QUEUE(sk), skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (sk->sk_send_head =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sk->sk_send_head =3D skb;
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D l2cap_ertm_send(sk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D len;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 BT_DBG("bad state %1.1x", pi->mode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>> + =A0 =A0 }
>> +
>> +done:
>> =A0 =A0 =A0 release_sock(sk);
>> =A0 =A0 =A0 return err;
>> =A0}
>> @@ -2302,6 +2448,10 @@ static inline int l2cap_config_req(struct l2cap_c=
onn *conn, struct l2cap_cmd_hdr
>>
>> =A0 =A0 =A0 if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sk->sk_state =3D BT_CONNECTED;
>> + =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(sk)->next_tx_seq =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(sk)->expected_ack_seq =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(sk)->unacked_frames =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __skb_queue_head_init(TX_QUEUE(sk));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_chan_ready(sk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
>> =A0 =A0 =A0 }
>> @@ -2376,6 +2526,9 @@ static inline int l2cap_config_rsp(struct l2cap_co=
nn *conn, struct l2cap_cmd_hdr
>>
>> =A0 =A0 =A0 if (l2cap_pi(sk)->conf_state & L2CAP_CONF_OUTPUT_DONE) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sk->sk_state =3D BT_CONNECTED;
>> + =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(sk)->expected_tx_seq =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(sk)->num_to_ack =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __skb_queue_head_init(TX_QUEUE(sk));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_chan_ready(sk);
>> =A0 =A0 =A0 }
>>
>> @@ -2406,6 +2559,8 @@ static inline int l2cap_disconnect_req(struct l2ca=
p_conn *conn, struct l2cap_cmd
>>
>> =A0 =A0 =A0 sk->sk_shutdown =3D SHUTDOWN_MASK;
>>
>> + =A0 =A0 skb_queue_purge(TX_QUEUE(sk));
>> +
>> =A0 =A0 =A0 l2cap_chan_del(sk, ECONNRESET);
>> =A0 =A0 =A0 bh_unlock_sock(sk);
>>
>> @@ -2428,6 +2583,8 @@ static inline int l2cap_disconnect_rsp(struct l2ca=
p_conn *conn, struct l2cap_cmd
>> =A0 =A0 =A0 if (!sk)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> + =A0 =A0 skb_queue_purge(TX_QUEUE(sk));
>> +
>> =A0 =A0 =A0 l2cap_chan_del(sk, 0);
>> =A0 =A0 =A0 bh_unlock_sock(sk);
>>
>> @@ -2603,9 +2760,63 @@ static inline void l2cap_sig_channel(struct l2cap=
_conn *conn, struct sk_buff *sk
>> =A0 =A0 =A0 kfree_skb(skb);
>> =A0}
>>
>> +static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_con=
trol, struct sk_buff *skb)
>> +{
>> + =A0 =A0 struct l2cap_pinfo *pi =3D l2cap_pi(sk);
>> + =A0 =A0 u8 tx_seq =3D __get_txseq(rx_control);
>> + =A0 =A0 u16 tx_control =3D 0;
>> + =A0 =A0 int err;
>> +
>> + =A0 =A0 BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb-=
>len);
>> +
>> + =A0 =A0 if (tx_seq !=3D pi->expected_tx_seq)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 L2CAP_SEQ_NUM_INC(pi->expected_tx_seq);
>> + =A0 =A0 err =3D sock_queue_rcv_skb(sk, skb);
>> + =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> +
>> + =A0 =A0 L2CAP_NUM_TO_ACK_INC(pi->num_to_ack);
>> + =A0 =A0 if (pi->num_to_ack =3D=3D L2CAP_DEFAULT_NUM_TO_ACK - 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 tx_control |=3D L2CAP_CTRL_FRAME_TYPE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 tx_control |=3D L2CAP_SUPER_RCV_READY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 tx_control |=3D pi->expected_tx_seq << L2CAP_C=
TRL_REQSEQ_SHIFT;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D l2cap_send_sframe(pi, tx_control);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(err))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>
> Drop this unlikely, too. Just return err. Actually at this point in the
> flow there is no need to check it at all.
>
>> + =A0 =A0 }
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_con=
trol, struct sk_buff *skb)
>> +{
>> + =A0 =A0 struct l2cap_pinfo *pi =3D l2cap_pi(sk);
>> +
>> + =A0 =A0 BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb-=
>len);
>> +
>> + =A0 =A0 switch (rx_control & L2CAP_CTRL_SUPERVISE) {
>> + =A0 =A0 case L2CAP_SUPER_RCV_READY:
>> + =A0 =A0 =A0 =A0 =A0 =A0 pi->expected_ack_seq =3D __get_reqseq(rx_contr=
ol);
>> + =A0 =A0 =A0 =A0 =A0 =A0 l2cap_drop_acked_frames(sk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 l2cap_ertm_send(sk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case L2CAP_SUPER_RCV_NOT_READY:
>> + =A0 =A0 case L2CAP_SUPER_REJECT:
>> + =A0 =A0 case L2CAP_SUPER_SELECT_REJECT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> =A0static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid=
, struct sk_buff *skb)
>> =A0{
>> =A0 =A0 =A0 struct sock *sk;
>> + =A0 =A0 u16 control;
>> + =A0 =A0 int err;
>>
>> =A0 =A0 =A0 sk =3D l2cap_get_chan_by_scid(&conn->chan_list, cid);
>> =A0 =A0 =A0 if (!sk) {
>> @@ -2618,16 +2829,40 @@ static inline int l2cap_data_channel(struct l2ca=
p_conn *conn, u16 cid, struct sk
>> =A0 =A0 =A0 if (sk->sk_state !=3D BT_CONNECTED)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop;
>>
>> - =A0 =A0 if (l2cap_pi(sk)->imtu < skb->len)
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto drop;
>> + =A0 =A0 switch (l2cap_pi(sk)->mode) {
>> + =A0 =A0 case L2CAP_MODE_BASIC:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* If socket recv buffers overflows we drop da=
ta here
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* which is *bad* because L2CAP has to be re=
liable.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* But we don't have any other choice. L2CAP=
 doesn't
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* provide flow control mechanism. */
>>
>> - =A0 =A0 /* If socket recv buffers overflows we drop data here
>> - =A0 =A0 =A0* which is *bad* because L2CAP has to be reliable.
>> - =A0 =A0 =A0* But we don't have any other choice. L2CAP doesn't
>> - =A0 =A0 =A0* provide flow control mechanism. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (l2cap_pi(sk)->imtu < skb->len)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop;
>>
>> - =A0 =A0 if (!sock_queue_rcv_skb(sk, skb))
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!sock_queue_rcv_skb(sk, skb))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case L2CAP_MODE_ERTM:
>> + =A0 =A0 =A0 =A0 =A0 =A0 control =3D get_unaligned_le16(skb->data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 skb_pull(skb, 2);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (l2cap_pi(sk)->imtu < skb->len)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (__is_iframe(control))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D l2cap_data_channel_ifr=
ame(sk, control, skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D l2cap_data_channel_sfr=
ame(sk, control, skb);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 BT_DBG("sk %p: bad mode 0x%2.2x", sk, l2cap_pi=
(sk)->mode);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>>
>> =A0drop:
>> =A0 =A0 =A0 kfree_skb(skb);
>> @@ -2677,6 +2912,9 @@ static void l2cap_recv_frame(struct l2cap_conn *co=
nn, struct sk_buff *skb)
>> =A0 =A0 =A0 cid =3D __le16_to_cpu(lh->cid);
>> =A0 =A0 =A0 len =3D __le16_to_cpu(lh->len);
>>
>> + =A0 =A0 if (len !=3D skb->len)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto drop;
>> +
>> =A0 =A0 =A0 BT_DBG("len %d, cid 0x%4.4x", len, cid);
>>
>> =A0 =A0 =A0 switch (cid) {
>> @@ -2694,6 +2932,10 @@ static void l2cap_recv_frame(struct l2cap_conn *c=
onn, struct sk_buff *skb)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_data_channel(conn, cid, skb);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>> + =A0 =A0 return;
>> +
>> +drop:
>> + =A0 =A0 kfree_skb(skb);
>
> So this change is pointless. Just free the skb and return from the
> actual length check. There is no benefit to go to the end of the
> function here.
>
> Regards
>
> Marcel
>
>
>



--=20
Gustavo F. Padovan
http://padovan.org
