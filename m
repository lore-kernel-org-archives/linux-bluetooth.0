Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: gfpadovan@gmail.com
In-Reply-To: <1248689138.28545.191.camel@violet>
References: <1248675424-20977-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248675424-20977-2-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248675424-20977-3-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248689138.28545.191.camel@violet>
Date: Tue, 28 Jul 2009 08:30:42 -0300
Message-ID: <6b53b1990907280430q7fc22008sc6aaab80509bdcaa@mail.gmail.com>
Subject: Re: [PATCH 2/4] Bluetooth: Add support for Segmentation and
	Reassembly of SDUs
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jul 27, 2009 at 7:05 AM, Marcel Holtmann<marcel@holtmann.org> wrote=
:
> Hi Gustavo,
>
>> ERTM should use Segmentation and Reassembly to break down a SDU in many
>> PDUs on sending data to the other side.
>> On sending packets we queue all 'segments' until end of segmentation and
>> just the add them to the queue for sending.
>> On receiving we create a new skb with the SDU reassembled.
>>
>> Initially based on a patch from Nathan Holstein <nathan@lampreynetworks.=
com>
>>
>> Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
>> ---
>> =A0include/net/bluetooth/l2cap.h | =A0 10 ++-
>> =A0net/bluetooth/l2cap.c =A0 =A0 =A0 =A0 | =A0180 ++++++++++++++++++++++=
++++++++++++++-----
>> =A02 files changed, 168 insertions(+), 22 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap=
.h
>> index cae561a..233a2fa 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -34,7 +34,7 @@
>> =A0#define L2CAP_DEFAULT_MAX_RECEIVE =A0 =A01
>> =A0#define L2CAP_DEFAULT_RETRANS_TO =A0 =A0 300 =A0 =A0/* 300 millisecon=
ds */
>> =A0#define L2CAP_DEFAULT_MONITOR_TO =A0 =A0 1000 =A0 /* 1 second */
>> -#define L2CAP_DEFAULT_MAX_RX_APDU =A0 =A00xfff7
>> +#define L2CAP_DEFAULT_MAX_PDU_SIZE =A0 672
>>
>> =A0#define L2CAP_CONN_TIMEOUT =A0 (40000) /* 40 seconds */
>> =A0#define L2CAP_INFO_TIMEOUT =A0 (4000) =A0/* =A04 seconds */
>> @@ -313,6 +313,7 @@ struct l2cap_pinfo {
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0conf_req[64];
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0conf_len;
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0conf_state;
>> + =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0conn_state;
>>
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0next_tx_seq;
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0expected_ack_seq;
>> @@ -320,6 +321,10 @@ struct l2cap_pinfo {
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0expected_tx_seq;
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0unacked_frames;
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0num_to_ack;
>> + =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 sdu_len;
>> + =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 partial_sdu_len;
>> + =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0start_txseq;
>> + =A0 =A0 struct sk_buff =A0*sdu;
>>
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0ident;
>>
>> @@ -348,6 +353,8 @@ struct l2cap_pinfo {
>> =A0#define L2CAP_CONF_MAX_CONF_REQ 2
>> =A0#define L2CAP_CONF_MAX_CONF_RSP 2
>>
>> +#define L2CAP_CONN_SAR_SDU =A0 =A0 =A0 =A0 0x01
>> +
>> =A0static inline int l2cap_tx_window_full(struct sock *sk)
>> =A0{
>> =A0 =A0 =A0 struct l2cap_pinfo *pi =3D l2cap_pi(sk);
>> @@ -365,6 +372,7 @@ static inline int l2cap_tx_window_full(struct sock *=
sk)
>> =A0#define __get_reqseq(ctrl) ((ctrl) & L2CAP_CTRL_REQSEQ) >> 8
>> =A0#define __is_iframe(ctrl) !((ctrl) & L2CAP_CTRL_FRAME_TYPE)
>> =A0#define __is_sframe(ctrl) (ctrl) & L2CAP_CTRL_FRAME_TYPE
>> +#define __is_sar_sdu_start(ctrl) ((ctrl) & L2CAP_CTRL_SAR) =3D=3D L2CAP=
_SDU_START
>
> Using just __is_sar_start is enough here.
>
>> =A0void l2cap_load(void);
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index b2fd4f9..dcde60b 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -1282,7 +1282,7 @@ static inline int l2cap_skbuff_fromiovec(struct so=
ck *sk, struct msghdr *msg, in
>> =A0 =A0 =A0 return sent;
>> =A0}
>>
>> -static struct sk_buff *l2cap_create_pdu(struct sock *sk, struct msghdr =
*msg, size_t len, u16 *control)
>> +static struct sk_buff *l2cap_create_pdu(struct sock *sk, struct msghdr =
*msg, size_t len, u16 *control, u16 sdulen)
>> =A0{
>> =A0 =A0 =A0 struct l2cap_conn *conn =3D l2cap_pi(sk)->conn;
>> =A0 =A0 =A0 struct sk_buff *skb;
>> @@ -1291,8 +1291,11 @@ static struct sk_buff *l2cap_create_pdu(struct so=
ck *sk, struct msghdr *msg, siz
>>
>> =A0 =A0 =A0 BT_DBG("sk %p len %d", sk, (int)len);
>>
>> - =A0 =A0 if (control)
>> + =A0 =A0 if (control) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hlen +=3D 2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (sdulen)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hlen +=3D2;
>> + =A0 =A0 }
>> =A0 =A0 =A0 else if (sk->sk_type =3D=3D SOCK_DGRAM)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hlen +=3D 2;
>
> This is just ugly. We might really wanna split PDU creation here in
> connection less, basic and ertm. Think about it.

Maybe it's better we split the PDU create, we also solve the problem
of control be a pointer.
We will duplicate some code, but things will look better.

>
>> @@ -1307,8 +1310,11 @@ static struct sk_buff *l2cap_create_pdu(struct so=
ck *sk, struct msghdr *msg, siz
>> =A0 =A0 =A0 lh->cid =3D cpu_to_le16(l2cap_pi(sk)->dcid);
>> =A0 =A0 =A0 lh->len =3D cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
>>
>> - =A0 =A0 if (control)
>> + =A0 =A0 if (control) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_unaligned_le16(*control, skb_put(skb, 2)=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (sdulen)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_unaligned_le16(sdulen, skb=
_put(skb, 2));
>> + =A0 =A0 }
>> =A0 =A0 =A0 else if (sk->sk_type =3D=3D SOCK_DGRAM)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_unaligned_le16(l2cap_pi(sk)->psm, skb_pu=
t(skb, 2));
>>
>> @@ -1317,10 +1323,58 @@ static struct sk_buff *l2cap_create_pdu(struct s=
ock *sk, struct msghdr *msg, siz
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree_skb(skb);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(err);
>> =A0 =A0 =A0 }
>> -
>> =A0 =A0 =A0 return skb;
>> =A0}
>>
>> +static inline int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr =
*msg, size_t len)
>> +{
>> + =A0 =A0 struct l2cap_pinfo *pi =3D l2cap_pi(sk);
>> + =A0 =A0 struct sk_buff *skb;
>> + =A0 =A0 struct sk_buff_head sar_queue;
>> + =A0 =A0 u16 control;
>> + =A0 =A0 size_t size =3D 0;
>> +
>> + =A0 =A0 __skb_queue_head_init(&sar_queue);
>> + =A0 =A0 control |=3D L2CAP_SDU_START;
>> + =A0 =A0 skb =3D l2cap_create_pdu(sk, msg, pi->max_pdu_size, &control, =
len);
>> + =A0 =A0 if (IS_ERR(skb))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(skb);
>> +
>> + =A0 =A0 __skb_queue_tail(&sar_queue, skb);
>> + =A0 =A0 len -=3D pi->max_pdu_size;
>> + =A0 =A0 size +=3Dpi->max_pdu_size;
>> + =A0 =A0 control =3D 0;
>> +
>> + =A0 =A0 while (len > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 size_t buflen;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (len > pi->max_pdu_size) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 control |=3D L2CAP_SDU_CONTINU=
E;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buflen =3D pi->max_pdu_size;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 else {
>
> Coding style error. Must be =A0} else { all on the same line.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 control |=3D L2CAP_SDU_END;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buflen =3D len;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 skb =3D l2cap_create_pdu(sk, msg, buflen ,&con=
trol, 0);
>
> It is ,<space> and not <space>,
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(skb)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb_queue_purge(&sar_queue);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 __skb_queue_tail(&sar_queue, skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 len -=3D buflen;
>> + =A0 =A0 =A0 =A0 =A0 =A0 size +=3D buflen;
>> + =A0 =A0 =A0 =A0 =A0 =A0 control =3D 0;
>> + =A0 =A0 }
>> + =A0 =A0 skb_queue_splice_tail(&sar_queue, TX_QUEUE(sk));
>> + =A0 =A0 if (sk->sk_send_head =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 sk->sk_send_head =3D sar_queue.next;
>> +
>> + =A0 =A0 return size;
>> +}
>> +
>> =A0static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock=
, struct msghdr *msg, size_t len)
>> =A0{
>> =A0 =A0 =A0 struct sock *sk =3D sock->sk;
>> @@ -1339,7 +1393,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, =
struct socket *sock, struct ms
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
>>
>> =A0 =A0 =A0 /* Check outgoing MTU */
>> - =A0 =A0 if ((sk->sk_type !=3D SOCK_RAW || pi->mode =3D=3D L2CAP_MODE_B=
ASIC)
>> + =A0 =A0 if ((sk->sk_type !=3D SOCK_RAW && pi->mode =3D=3D L2CAP_MODE_B=
ASIC)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && len > pi->omtu)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> I don't understand this one. If it is right, then also the extra
> brackets are pointless now.

It's wrong! Need to be:

 +if ((sk->sk_type !=3D SOCK_SEQPACKET&& pi->mode =3D=3D L2CAP_MODE_BASIC)


So we will need another check for SOCK_RAW as I said on a comment on 1/4.

>
>>
>> @@ -1353,7 +1407,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, =
struct socket *sock, struct ms
>> =A0 =A0 =A0 switch (pi->mode) {
>> =A0 =A0 =A0 case L2CAP_MODE_BASIC:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Create a basic PDU */
>> - =A0 =A0 =A0 =A0 =A0 =A0 skb =3D l2cap_create_pdu(sk, msg, len, NULL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 skb =3D l2cap_create_pdu(sk, msg, len, NULL, 0=
);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(skb)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(skb);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> @@ -1366,22 +1420,23 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb=
, struct socket *sock, struct ms
>>
>> =A0 =A0 =A0 case L2CAP_MODE_ERTM:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Entire SDU fits into one PDU */
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (len <=3D pi->omtu) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (len <=3D pi->max_pdu_size) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 control =3D L2CAP_SDU_UNSEGM=
ENTED;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb =3D l2cap_create_pdu(sk, m=
sg, len, &control);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb =3D l2cap_create_pdu(sk, m=
sg, len, &control, 0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(skb)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_=
ERR(skb);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __skb_queue_tail(TX_QUEUE(sk),=
 skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sk->sk_send_head =3D=3D NU=
LL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sk->sk_send_he=
ad =3D skb;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Segment SDU into multiples PDUs */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: Segmentation will be=
 added later */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D l2cap_sar_segment_sdu(=
sk, msg, len);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(err < 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 __skb_queue_tail(TX_QUEUE(sk), skb);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (sk->sk_send_head =3D=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sk->sk_send_head =3D skb;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D l2cap_ertm_send(sk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>> @@ -1959,7 +2014,7 @@ done:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.max_transmit =A0 =A0=3D L2CAP_DEFAULT_MA=
X_RECEIVE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.retrans_timeout =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.monitor_timeout =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 rfc.max_pdu_size =A0 =A0=3D cpu_to_le16(L2CAP_=
DEFAULT_MAX_RX_APDU);
>> + =A0 =A0 =A0 =A0 =A0 =A0 rfc.max_pdu_size =A0 =A0=3D cpu_to_le16(L2CAP_=
DEFAULT_MAX_PDU_SIZE);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 sizeof(rfc), (unsigned long) &rfc);
>> @@ -1971,7 +2026,7 @@ done:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.max_transmit =A0 =A0=3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.retrans_timeout =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfc.monitor_timeout =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 rfc.max_pdu_size =A0 =A0=3D cpu_to_le16(L2CAP_=
DEFAULT_MAX_RX_APDU);
>> + =A0 =A0 =A0 =A0 =A0 =A0 rfc.max_pdu_size =A0 =A0=3D cpu_to_le16(L2CAP_=
DEFAULT_MAX_PDU_SIZE);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 sizeof(rfc), (unsigned long) &rfc);
>> @@ -2760,6 +2815,85 @@ static inline void l2cap_sig_channel(struct l2cap=
_conn *conn, struct sk_buff *sk
>> =A0 =A0 =A0 kfree_skb(skb);
>> =A0}
>>
>> +static int l2cap_sar_reassembly_sdu(struct sock *sk, struct sk_buff *sk=
b, u16 control, u8 txseq)
>> +{
>> + =A0 =A0 struct l2cap_pinfo *pi =3D l2cap_pi(sk);
>> + =A0 =A0 struct sk_buff *_skb;
>> + =A0 =A0 int err =3D -EINVAL;
>> +
>> + =A0 =A0 switch (control & L2CAP_CTRL_SAR) {
>> + =A0 =A0 case L2CAP_SDU_UNSEGMENTED:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pi->conn_state & L2CAP_CONN_SAR_SDU)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop2;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D sock_queue_rcv_skb(sk, skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(err < 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop;
>
> Drop the unlikely here. Not helping much.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case L2CAP_SDU_START:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pi->conn_state & L2CAP_CONN_SAR_SDU)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop2;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 pi->sdu_len =3D get_unaligned_le16(skb->data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 skb_pull(skb, 2);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 pi->sdu =3D bt_skb_alloc(pi->sdu_len, GFP_ATOM=
IC);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pi->sdu)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(skb_put(pi->sdu, skb->len), skb->data, =
skb->len);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 pi->conn_state |=3D L2CAP_CONN_SAR_SDU;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pi->partial_sdu_len =3D skb->len;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pi->start_txseq =3D txseq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree_skb(skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case L2CAP_SDU_CONTINUE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(pi->conn_state & L2CAP_CONN_SAR_SDU))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(skb_put(pi->sdu, skb->len), skb->data, =
skb->len);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 pi->partial_sdu_len +=3D skb->len;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pi->partial_sdu_len > pi->sdu_len)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop2;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree_skb(skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case L2CAP_SDU_END:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(pi->conn_state & L2CAP_CONN_SAR_SDU))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(skb_put(pi->sdu, skb->len), skb->data, =
skb->len);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 pi->conn_state &=3D !L2CAP_CONN_SAR_SDU;
>
> What is this. Removing a flag is &=3D ~ and not &=3D !.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 pi->partial_sdu_len +=3D skb->len;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pi->partial_sdu_len !=3D pi->sdu_len)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop2;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 _skb =3D skb_clone(pi->sdu, GFP_ATOMIC);
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D sock_queue_rcv_skb(sk, _skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(err < 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree_skb(_skb);
>
> Drop the Unlikely here, too.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree_skb(pi->sdu);
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree_skb(skb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> + =A0 =A0 return 0;
>> +
>> +drop2:
>> + =A0 =A0 kfree_skb(pi->sdu);
>> +
>> +drop:
>> + =A0 =A0 kfree_skb(skb);
>> + =A0 =A0 return err;
>> +}
>> +
>> =A0static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_c=
ontrol, struct sk_buff *skb)
>> =A0{
>> =A0 =A0 =A0 struct l2cap_pinfo *pi =3D l2cap_pi(sk);
>> @@ -2772,11 +2906,11 @@ static inline int l2cap_data_channel_iframe(stru=
ct sock *sk, u16 rx_control, str
>> =A0 =A0 =A0 if (tx_seq !=3D pi->expected_tx_seq)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> - =A0 =A0 L2CAP_SEQ_NUM_INC(pi->expected_tx_seq);
>> - =A0 =A0 err =3D sock_queue_rcv_skb(sk, skb);
>> - =A0 =A0 if (err)
>> + =A0 =A0 err =3D l2cap_sar_reassembly_sdu(sk, skb, rx_control, tx_seq);
>> + =A0 =A0 if (unlikely(err < 0))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>
> No unlikely please.
>
>>
>> + =A0 =A0 L2CAP_SEQ_NUM_INC(pi->expected_tx_seq);
>> =A0 =A0 =A0 L2CAP_NUM_TO_ACK_INC(pi->num_to_ack);
>> =A0 =A0 =A0 if (pi->num_to_ack =3D=3D L2CAP_DEFAULT_NUM_TO_ACK - 1) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_control |=3D L2CAP_CTRL_FRAME_TYPE;
>> @@ -2815,7 +2949,7 @@ static inline int l2cap_data_channel_sframe(struct=
 sock *sk, u16 rx_control, str
>> =A0static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid=
, struct sk_buff *skb)
>> =A0{
>> =A0 =A0 =A0 struct sock *sk;
>> - =A0 =A0 u16 control;
>> + =A0 =A0 u16 control, len;
>> =A0 =A0 =A0 int err;
>>
>> =A0 =A0 =A0 sk =3D l2cap_get_chan_by_scid(&conn->chan_list, cid);
>> @@ -2846,8 +2980,12 @@ static inline int l2cap_data_channel(struct l2cap=
_conn *conn, u16 cid, struct sk
>> =A0 =A0 =A0 case L2CAP_MODE_ERTM:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 control =3D get_unaligned_le16(skb->data);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb_pull(skb, 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 len =3D skb->len;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (l2cap_pi(sk)->imtu < skb->len)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (__is_sar_sdu_start(control))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D 2;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (L2CAP_DEFAULT_MAX_PDU_SIZE < len)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto drop;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (__is_iframe(control))
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
