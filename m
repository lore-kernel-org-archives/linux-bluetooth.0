Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Mar 2012 16:19:27 -0800 (PST)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <padovan@profusion.mobi>
cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org,
	marcel@holtmann.org, luiz.dentz@gmail.com, ulisses@profusion.mobi,
	andrei.emeltchenko.news@gmail.com
Subject: Re: [RFC 1/2] Bluetooth: Header changes for ERTM state machine
 replacement
In-Reply-To: <20120228233305.GA30668@joana>
Message-ID: <alpine.DEB.2.02.1203021546520.7289@mathewm-linux>
References: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org> <1330029469-8565-2-git-send-email-mathewm@codeaurora.org> <20120228233305.GA30668@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Tue, 28 Feb 2012, Gustavo Padovan wrote:

> Hi Mat,
>
> * Mat Martineau <mathewm@codeaurora.org> [2012-02-23 12:37:48 -0800]:
>
>> This change affects data structures storing ERTM state and control
>> fields, and adds new definitions for states and events.  An
>> l2cap_seq_list structure is added for tracking ERTM sequence numbers
>> without repeated memory allocations.  Control fields are carried in
>> the bt_skb_cb struct rather than constantly doing shift and mask
>> operations.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  include/net/bluetooth/bluetooth.h |   14 ++-
>>  include/net/bluetooth/l2cap.h     |  260 +++++++++----------------------------
>>  2 files changed, 73 insertions(+), 201 deletions(-)
>>
>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>> index 262ebd1..a667cb8 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -215,14 +215,24 @@ void bt_accept_unlink(struct sock *sk);
>>  struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock);
>>
>>  /* Skb helpers */
>> +struct bt_l2cap_control {
>
> I would call this struct l2cap_ctrl only. Much smaller.

Ok.

>> +	__u8  frame_type;
>
> This could be frame_type:1, only one bit is needed here.
>
>> +	__u8  final;
>
> final:1
>
>> +	__u8  sar;
>
> sar:2
>
>> +	__u8  super;
>
> super:2
>> +	__u16 reqseq;
>
> go on..

Will convert to a bitfield.

>> +	__u16 txseq;
>> +	__u8  poll;
>> +	__u8  fcs;
>> +};
>> +
>>  struct bt_skb_cb {
>>  	__u8 pkt_type;
>>  	__u8 incoming;
>>  	__u16 expect;
>> -	__u16 tx_seq;
>>  	__u8 retries;
>
> I would put retries inside l2cap_ctrl. It says how many times we sent that
> frame, looks a type of information that fits there.

Sure.  That l2cap_ctrl struct was originally just ERTM control field 
stuff, but fcs got in there.  retries might as well too.

>> -	__u8 sar;
>>  	__u8 force_active;
>> +	struct bt_l2cap_control control;
>>  };
>>  #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index d6d8ec8..a499b60 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -3,6 +3,7 @@
>>     Copyright (C) 2000-2001 Qualcomm Incorporated
>>     Copyright (C) 2009-2010 Gustavo F. Padovan <gustavo@padovan.org>
>>     Copyright (C) 2010 Google Inc.
>> +   Copyright (c) 2012 Code Aurora Forum.  All rights reserved.
>
> Leave the Copyright note to when you really add code to l2cap.c

Ok.

>>
>>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>>
>> @@ -44,6 +45,9 @@
>>  #define L2CAP_DEFAULT_MAX_SDU_SIZE	0xFFFF
>>  #define L2CAP_DEFAULT_SDU_ITIME		0xFFFFFFFF
>>  #define L2CAP_DEFAULT_ACC_LAT		0xFFFFFFFF
>> +#define L2CAP_BREDR_MAX_PAYLOAD		1019    /* 3-DH5 packet */
>> +#define L2CAP_MAX_ERTM_QUEUED		5
>> +#define L2CAP_MIN_ERTM_QUEUED		2
>>
>>  #define L2CAP_DISC_TIMEOUT             (100)
>>  #define L2CAP_DISC_REJ_TIMEOUT         (5000)  /*  5 seconds */
>> @@ -139,6 +143,8 @@ struct l2cap_conninfo {
>>
>>  #define L2CAP_CTRL_TXSEQ_SHIFT		1
>>  #define L2CAP_CTRL_SUPER_SHIFT		2
>> +#define L2CAP_CTRL_POLL_SHIFT		4
>> +#define L2CAP_CTRL_FINAL_SHIFT		7
>>  #define L2CAP_CTRL_REQSEQ_SHIFT		8
>>  #define L2CAP_CTRL_SAR_SHIFT		14
>>
>> @@ -152,9 +158,11 @@ struct l2cap_conninfo {
>>  #define L2CAP_EXT_CTRL_FINAL		0x00000002
>>  #define L2CAP_EXT_CTRL_FRAME_TYPE	0x00000001 /* I- or S-Frame */
>>
>> +#define L2CAP_EXT_CTRL_FINAL_SHIFT	1
>>  #define L2CAP_EXT_CTRL_REQSEQ_SHIFT	2
>>  #define L2CAP_EXT_CTRL_SAR_SHIFT	16
>>  #define L2CAP_EXT_CTRL_SUPER_SHIFT	16
>> +#define L2CAP_EXT_CTRL_POLL_SHIFT	18
>>  #define L2CAP_EXT_CTRL_TXSEQ_SHIFT	18
>>
>>  /* L2CAP Supervisory Function */
>> @@ -186,6 +194,8 @@ struct l2cap_hdr {
>>  #define L2CAP_FCS_SIZE		2
>>  #define L2CAP_SDULEN_SIZE	2
>>  #define L2CAP_PSMLEN_SIZE	2
>> +#define L2CAP_ENH_CTRL_SIZE	2
>> +#define L2CAP_EXT_CTRL_SIZE	4
>>
>>  struct l2cap_cmd_hdr {
>>  	__u8       code;
>> @@ -401,9 +411,12 @@ struct l2cap_conn_param_update_rsp {
>>  #define L2CAP_CONN_PARAM_REJECTED	0x0001
>>
>>  /* ----- L2CAP channels and connections ----- */
>> -struct srej_list {
>> -	__u16	tx_seq;
>> -	struct list_head list;
>> +struct l2cap_seq_list {
>> +	__u16 head;
>> +	__u16 tail;
>> +	__u16 size;
>> +	__u16 mask;
>> +	__u16 *list;
>>  };
>
> So I looked to the code and saw the big kalloc you do in the list element
> here that is 256KB if we use the maximum tx_win in both directions.
> I'm open to ideas here, I don't have any better.

It's pretty useless to have a tx_window any larger than a few hundred 
packets, if you're worried about maximum allocation maybe we should 
limit the the tx_window.

There is a tradeoff here, where we do a one-time allocation to ensure 
that the retransmit and srej lists can be searched in constant time 
and that list nodes don't have to be alloc'd and freed for every 
retransmitted packet.  With typical tx_windows, it's only a few 
hundred bytes of overhead.

>>
>>  struct l2cap_chan {
>> @@ -446,6 +459,9 @@ struct l2cap_chan {
>>  	__u16		monitor_timeout;
>>  	__u16		mps;
>>
>> +	__u8		tx_state;
>> +	__u8		rx_state;
>> +
>>  	unsigned long	conf_state;
>>  	unsigned long	conn_state;
>>  	unsigned long	flags;
>> @@ -454,15 +470,16 @@ struct l2cap_chan {
>>  	__u16		expected_ack_seq;
>>  	__u16		expected_tx_seq;
>>  	__u16		buffer_seq;
>> -	__u16		buffer_seq_srej;
>>  	__u16		srej_save_reqseq;
>> +	__u16		last_acked_seq;
>>  	__u16		frames_sent;
>>  	__u16		unacked_frames;
>>  	__u8		retry_count;
>> -	__u8		num_acked;
>> +	__u16		srej_queue_next;
>>  	__u16		sdu_len;
>>  	struct sk_buff	*sdu;
>>  	struct sk_buff	*sdu_last_frag;
>> +	atomic_t	ertm_queued;
>>
>>  	__u16		remote_tx_win;
>>  	__u8		remote_max_tx;
>> @@ -486,11 +503,13 @@ struct l2cap_chan {
>>  	struct delayed_work	retrans_timer;
>>  	struct delayed_work	monitor_timer;
>>  	struct delayed_work	ack_timer;
>> +	struct work_struct	tx_work;
>
> Do we really need another work in the L2CAP code?

I'll address this in my reply to your other email.

>>
>>  	struct sk_buff		*tx_send_head;
>>  	struct sk_buff_head	tx_q;
>>  	struct sk_buff_head	srej_q;
>> -	struct list_head	srej_l;
>> +	struct l2cap_seq_list	srej_list;
>> +	struct l2cap_seq_list	retrans_list;
>>
>>  	struct list_head list;
>>  	struct list_head global_l;
>> @@ -645,200 +664,43 @@ static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
>>
>>  #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
>>  #define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)
>> -#define __set_retrans_timer(c) l2cap_set_timer(c, &c->retrans_timer, \
>> -		msecs_to_jiffies(L2CAP_DEFAULT_RETRANS_TO));
>> -#define __clear_retrans_timer(c) l2cap_clear_timer(c, &c->retrans_timer)
>> -#define __set_monitor_timer(c) l2cap_set_timer(c, &c->monitor_timer, \
>> -		msecs_to_jiffies(L2CAP_DEFAULT_MONITOR_TO));
>> -#define __clear_monitor_timer(c) l2cap_clear_timer(c, &c->monitor_timer)
>> -#define __set_ack_timer(c) l2cap_set_timer(c, &chan->ack_timer, \
>> -		msecs_to_jiffies(L2CAP_DEFAULT_ACK_TO));
>> -#define __clear_ack_timer(c) l2cap_clear_timer(c, &c->ack_timer)
>
> So, I was expecting a patch that we could build without the l2cap.c code so we
> could apply it and move on, but this one completely breaks the build.

My goal with this patch was to get feedback on some of the names. 
I'll aim for something independently buildable in the next iteration.

> Also I noted that you just turned some of macros here in functions in l2cap.c.
> Why? Keep those as is for the next round of patches, no unnecessary changes here.

Some of the updated functions have more code than seems appropriate 
for a macro, and it seemed best to have them all in one place.

>> -
>> -static inline int __seq_offset(struct l2cap_chan *chan, __u16 seq1, __u16 seq2)
>> -{
>> -	int offset;
>> -
>> -	offset = (seq1 - seq2) % (chan->tx_win_max + 1);
>> -	if (offset < 0)
>> -		offset += (chan->tx_win_max + 1);
>> -
>> -	return offset;
>> -}
>> -
>> -static inline __u16 __next_seq(struct l2cap_chan *chan, __u16 seq)
>> -{
>> -	return (seq + 1) % (chan->tx_win_max + 1);
>> -}
>> -
>> -static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
>> -{
>> -	int sub;
>> -
>> -	sub = (ch->next_tx_seq - ch->expected_ack_seq) % 64;
>> -
>> -	if (sub < 0)
>> -		sub += 64;
>> -
>> -	return sub == ch->remote_tx_win;
>> -}
>> -
>> -static inline __u16 __get_reqseq(struct l2cap_chan *chan, __u32 ctrl)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return (ctrl & L2CAP_EXT_CTRL_REQSEQ) >>
>> -						L2CAP_EXT_CTRL_REQSEQ_SHIFT;
>> -	else
>> -		return (ctrl & L2CAP_CTRL_REQSEQ) >> L2CAP_CTRL_REQSEQ_SHIFT;
>> -}
>> -
>> -static inline __u32 __set_reqseq(struct l2cap_chan *chan, __u32 reqseq)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return (reqseq << L2CAP_EXT_CTRL_REQSEQ_SHIFT) &
>> -							L2CAP_EXT_CTRL_REQSEQ;
>> -	else
>> -		return (reqseq << L2CAP_CTRL_REQSEQ_SHIFT) & L2CAP_CTRL_REQSEQ;
>> -}
>> -
>> -static inline __u16 __get_txseq(struct l2cap_chan *chan, __u32 ctrl)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return (ctrl & L2CAP_EXT_CTRL_TXSEQ) >>
>> -						L2CAP_EXT_CTRL_TXSEQ_SHIFT;
>> -	else
>> -		return (ctrl & L2CAP_CTRL_TXSEQ) >> L2CAP_CTRL_TXSEQ_SHIFT;
>> -}
>> -
>> -static inline __u32 __set_txseq(struct l2cap_chan *chan, __u32 txseq)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return (txseq << L2CAP_EXT_CTRL_TXSEQ_SHIFT) &
>> -							L2CAP_EXT_CTRL_TXSEQ;
>> -	else
>> -		return (txseq << L2CAP_CTRL_TXSEQ_SHIFT) & L2CAP_CTRL_TXSEQ;
>> -}
>> -
>> -static inline bool __is_sframe(struct l2cap_chan *chan, __u32 ctrl)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return ctrl & L2CAP_EXT_CTRL_FRAME_TYPE;
>> -	else
>> -		return ctrl & L2CAP_CTRL_FRAME_TYPE;
>> -}
>> -
>> -static inline __u32 __set_sframe(struct l2cap_chan *chan)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return L2CAP_EXT_CTRL_FRAME_TYPE;
>> -	else
>> -		return L2CAP_CTRL_FRAME_TYPE;
>> -}
>> -
>> -static inline __u8 __get_ctrl_sar(struct l2cap_chan *chan, __u32 ctrl)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return (ctrl & L2CAP_EXT_CTRL_SAR) >> L2CAP_EXT_CTRL_SAR_SHIFT;
>> -	else
>> -		return (ctrl & L2CAP_CTRL_SAR) >> L2CAP_CTRL_SAR_SHIFT;
>> -}
>>
>> -static inline __u32 __set_ctrl_sar(struct l2cap_chan *chan, __u32 sar)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return (sar << L2CAP_EXT_CTRL_SAR_SHIFT) & L2CAP_EXT_CTRL_SAR;
>> -	else
>> -		return (sar << L2CAP_CTRL_SAR_SHIFT) & L2CAP_CTRL_SAR;
>> -}
>> -
>> -static inline bool __is_sar_start(struct l2cap_chan *chan, __u32 ctrl)
>> -{
>> -	return __get_ctrl_sar(chan, ctrl) == L2CAP_SAR_START;
>> -}
>> -
>> -static inline __u32 __get_sar_mask(struct l2cap_chan *chan)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return L2CAP_EXT_CTRL_SAR;
>> -	else
>> -		return L2CAP_CTRL_SAR;
>> -}
>> -
>> -static inline __u8 __get_ctrl_super(struct l2cap_chan *chan, __u32 ctrl)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return (ctrl & L2CAP_EXT_CTRL_SUPERVISE) >>
>> -						L2CAP_EXT_CTRL_SUPER_SHIFT;
>> -	else
>> -		return (ctrl & L2CAP_CTRL_SUPERVISE) >> L2CAP_CTRL_SUPER_SHIFT;
>> -}
>> -
>> -static inline __u32 __set_ctrl_super(struct l2cap_chan *chan, __u32 super)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return (super << L2CAP_EXT_CTRL_SUPER_SHIFT) &
>> -						L2CAP_EXT_CTRL_SUPERVISE;
>> -	else
>> -		return (super << L2CAP_CTRL_SUPER_SHIFT) &
>> -							L2CAP_CTRL_SUPERVISE;
>> -}
>> -
>> -static inline __u32 __set_ctrl_final(struct l2cap_chan *chan)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return L2CAP_EXT_CTRL_FINAL;
>> -	else
>> -		return L2CAP_CTRL_FINAL;
>> -}
>> -
>> -static inline bool __is_ctrl_final(struct l2cap_chan *chan, __u32 ctrl)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return ctrl & L2CAP_EXT_CTRL_FINAL;
>> -	else
>> -		return ctrl & L2CAP_CTRL_FINAL;
>> -}
>> -
>> -static inline __u32 __set_ctrl_poll(struct l2cap_chan *chan)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return L2CAP_EXT_CTRL_POLL;
>> -	else
>> -		return L2CAP_CTRL_POLL;
>> -}
>> -
>> -static inline bool __is_ctrl_poll(struct l2cap_chan *chan, __u32 ctrl)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return ctrl & L2CAP_EXT_CTRL_POLL;
>> -	else
>> -		return ctrl & L2CAP_CTRL_POLL;
>> -}
>> -
>> -static inline __u32 __get_control(struct l2cap_chan *chan, void *p)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return get_unaligned_le32(p);
>> -	else
>> -		return get_unaligned_le16(p);
>> -}
>> -
>> -static inline void __put_control(struct l2cap_chan *chan, __u32 control,
>> -								void *p)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return put_unaligned_le32(control, p);
>> -	else
>> -		return put_unaligned_le16(control, p);
>> -}
>> -
>> -static inline __u8 __ctrl_size(struct l2cap_chan *chan)
>> -{
>> -	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
>> -		return L2CAP_EXT_HDR_SIZE - L2CAP_HDR_SIZE;
>> -	else
>> -		return L2CAP_ENH_HDR_SIZE - L2CAP_HDR_SIZE;
>> -}
>
> Are we going to replace the Extended Window Size implemetation too?

The state machine code makes frequent use of the l2cap_ctrl struct, so 
all these functions are not needed.  All packing and unpacking of the 
control headers is done one time in one place.

>> +#define L2CAP_SEQ_LIST_CLEAR       0xFFFF
>> +#define L2CAP_SEQ_LIST_TAIL        0x8000
>> +
>> +#define L2CAP_ERTM_TX_STATE_XMIT          0x01
>> +#define L2CAP_ERTM_TX_STATE_WAIT_F        0x02
>> +
>> +#define L2CAP_ERTM_RX_STATE_RECV                    0x01
>> +#define L2CAP_ERTM_RX_STATE_SREJ_SENT               0x02
>> +
>> +#define L2CAP_ERTM_TXSEQ_EXPECTED        0x00
>> +#define L2CAP_ERTM_TXSEQ_EXPECTED_SREJ   0x01
>> +#define L2CAP_ERTM_TXSEQ_UNEXPECTED      0x02
>> +#define L2CAP_ERTM_TXSEQ_UNEXPECTED_SREJ 0x03
>> +#define L2CAP_ERTM_TXSEQ_DUPLICATE       0x04
>> +#define L2CAP_ERTM_TXSEQ_DUPLICATE_SREJ  0x05
>> +#define L2CAP_ERTM_TXSEQ_INVALID         0x06
>> +#define L2CAP_ERTM_TXSEQ_INVALID_IGNORE  0x07
>> +
>> +#define L2CAP_ERTM_EVENT_DATA_REQUEST          0x01
>> +#define L2CAP_ERTM_EVENT_LOCAL_BUSY_DETECTED   0x02
>> +#define L2CAP_ERTM_EVENT_LOCAL_BUSY_CLEAR      0x03
>> +#define L2CAP_ERTM_EVENT_RECV_REQSEQ_AND_FBIT  0x04
>> +#define L2CAP_ERTM_EVENT_RECV_FBIT             0x05
>> +#define L2CAP_ERTM_EVENT_RETRANS_TIMER_EXPIRES 0x06
>
> 			...RETRANS_TO

Ok

>> +#define L2CAP_ERTM_EVENT_MONITOR_TIMER_EXPIRES 0x07
>
> 			...MONITOR_TO

Ok.

>> +#define L2CAP_ERTM_EVENT_EXPLICIT_POLL         0x08
>> +#define L2CAP_ERTM_EVENT_RECV_IFRAME           0x09
>> +#define L2CAP_ERTM_EVENT_RECV_RR               0x0a
>> +#define L2CAP_ERTM_EVENT_RECV_REJ              0x0b
>> +#define L2CAP_ERTM_EVENT_RECV_RNR              0x0c
>> +#define L2CAP_ERTM_EVENT_RECV_SREJ             0x0d
>> +#define L2CAP_ERTM_EVENT_RECV_FRAME            0x0e
>
> When we started ERTM we decided to let "_ERTM_" out of the macro names, can we
> go that way? Shorter names are better.
>
> Also s/EVENT/EV/

Will do.  Thanks for the review.


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

