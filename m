Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101022173411.GB980@vigoh>
References: <1287714419-13545-1-git-send-email-haijun.liu@atheros.com>
 <1287714419-13545-2-git-send-email-haijun.liu@atheros.com> <20101022173411.GB980@vigoh>
From: haijun liu <liuhaijun.er@gmail.com>
Date: Mon, 25 Oct 2010 10:15:48 +0800
Message-ID: <AANLkTinbP=N-pTKG1dN9PEPFHSLk9N98cq8aC=dfzav7@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] Bluetooth: Fix system crash bug of no send queue protect
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Haijun Liu <haijun.liu@atheros.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

>> During test session with another vendor's bt stack, found that
>> without lock protect for TX_QUEUE(sk) will cause system crash while
>> data transfer over AMP controller. So I just add lock protect for
>> TX_QUEUE(sk).
>
> We already use the default socket lock protection. Is it not working for
> you? Why? Could you show a crash case that requires your patch to fix
> it?
>

Yes,  there is socket lock protection, but only for sk_buff, for the related
variable we need protect them as well, such as 'sk->sk_send_head',
because later in different context we will use it as sk_buff directly, but at
that time maybe it has been freed and that buffer be occupied by another
sk_buff.

Below is the crash case we met:

[  265.544145] l2cap_sock_sendmsg: sock e7f4e380, sk e015fc00, msg
e01f5ea4, len 1668
[  265.544149] l2cap_sock_sendmsg: sk->scid 42, sk->dcid 5d, sk->mode 3
[  265.544157] block_sendmsg_condition:
[  265.544160] l2cap_tx_window_full:
[  265.544163] block_sendmsg_condition: tx_window full: 0, or
wait_f/remote busy.
[  265.544168] l2cap_sar_segment_sdu: sk e015fc00 len 5736
[  265.544172] l2cap_create_iframe_pdu: sk e015fc00 len 1011 control
4000  sdulen 5736
[  265.544175] l2cap_loglink_validate:
[  265.544179] l2cap_skbuff_fromiovec:
[  265.544183] l2cap_create_iframe_pdu: sk e015fc00 len 1011 control
c000  sdulen 0
[  265.544187] l2cap_loglink_validate:
[  265.544191] l2cap_skbuff_fromiovec:
[  265.544195] l2cap_create_iframe_pdu: sk e015fc00 len 1011 control
c000  sdulen 0
[  265.544200] l2cap_loglink_validate:
[  265.544203] l2cap_skbuff_fromiovec:
[  265.544207] l2cap_create_iframe_pdu: sk e015fc00 len 1011 control
c000  sdulen 0
[  265.544211] l2cap_loglink_validate:
[  265.544214] l2cap_skbuff_fromiovec:
[  265.544218] l2cap_create_iframe_pdu: sk e015fc00 len 1011 control
c000  sdulen 0
[  265.544221] l2cap_loglink_validate:
[  265.544225] l2cap_skbuff_fromiovec:
[  265.544229] l2cap_create_iframe_pdu: sk e015fc00 len 681 control
8000  sdulen 0
[  265.544252] l2cap_loglink_validate:
[  265.544255] l2cap_skbuff_fromiovec:
[  265.544483] l2cap_recv_acldata:
[  265.544488] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.544492] l2cap_recv_frame: conn f461bcc0, skb ee91ccc0, cid 42, len 4
[  265.544496] l2cap_recv_frame: len 4, cid 0x0042
[  265.544498] l2cap_data_channel:
[  265.544501] l2cap_get_chan_by_scid:
[  265.544504] __l2cap_get_chan_by_scid:
[  265.544508] l2cap_data_channel: sk e015fc00, len 4
[  265.544511] l2cap_ertm_data_rcv:
[  265.544514] l2cap_check_fcs:
[  265.544517] l2cap_data_channel_sframe: sk e015fc00 rx_control 0x2209 len 0
[  265.544521] l2cap_data_channel_rnrframe: sk e015fc00, req_seq 34 ctrl 0x2209
[  265.544525] l2cap_drop_acked_frames:
[  265.544636] l2cap_recv_acldata:
[  265.544641] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.544645] l2cap_recv_frame: conn f461bcc0, skb ee91c6c0, cid 42, len 4
[  265.544649] l2cap_recv_frame: len 4, cid 0x0042
[  265.544652] l2cap_data_channel:
[  265.544655] l2cap_get_chan_by_scid:
[  265.544657] __l2cap_get_chan_by_scid:
[  265.570492] l2cap_recv_acldata:
[  265.570503] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.570507] l2cap_recv_frame: conn f461bcc0, skb ee91c0c0, cid 42, len 4
[  265.570513] l2cap_recv_frame: len 4, cid 0x0042
[  265.570517] l2cap_data_channel:
[  265.570520] l2cap_get_chan_by_scid:
[  265.570524] __l2cap_get_chan_by_scid:
[  265.570529] l2cap_data_channel: sk e015fc00, len 4
[  265.570533] l2cap_ertm_data_rcv:
[  265.570536] l2cap_check_fcs:
[  265.570542] l2cap_data_channel_sframe: sk e015fc00 rx_control 0x2709 len 0
[  265.570547] l2cap_data_channel_rnrframe: sk e015fc00, req_seq 39 ctrl 0x2709
[  265.570550] l2cap_drop_acked_frames:
[  265.570658] l2cap_recv_acldata:
[  265.570663] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.570668] l2cap_recv_frame: conn f461bcc0, skb ee91ca80, cid 42, len 4
[  265.570673] l2cap_recv_frame: len 4, cid 0x0042
[  265.570677] l2cap_data_channel:
[  265.570680] l2cap_get_chan_by_scid:
[  265.570683] __l2cap_get_chan_by_scid:
[  265.570687] l2cap_data_channel: sk e015fc00, len 4
[  265.570691] l2cap_ertm_data_rcv:
[  265.570694] l2cap_check_fcs:
[  265.570698] l2cap_data_channel_sframe: sk e015fc00 rx_control 0x2809 len 0
[  265.570702] l2cap_data_channel_rnrframe: sk e015fc00, req_seq 40 ctrl 0x2809
[  265.570706] l2cap_drop_acked_frames:
[  265.570858] l2cap_recv_acldata:
[  265.572903] l2cap_recv_acldata:
[  265.572910] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.572915] l2cap_recv_frame: conn f461bcc0, skb f469fa80, cid 42, len 4
[  265.572919] l2cap_recv_frame: len 4, cid 0x0042
[  265.572921] l2cap_data_channel:
[  265.572925] l2cap_get_chan_by_scid:
[  265.572928] __l2cap_get_chan_by_scid:
[  265.572933] l2cap_data_channel: sk e015fc00, len 4
[  265.572936] l2cap_ertm_data_rcv:
[  265.572938] l2cap_check_fcs:
[  265.572943] l2cap_data_channel_sframe: sk e015fc00 rx_control 0x2b09 len 0
[  265.573348] l2cap_recv_acldata:

[  265.609993] l2cap_recv_acldata:
[  265.610005] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.610009] l2cap_recv_frame: conn f461bcc0, skb ee91c540, cid 42, len 4
[  265.610013] l2cap_recv_frame: len 4, cid 0x0042
[  265.610016] l2cap_data_channel:
[  265.610019] l2cap_get_chan_by_scid:
[  265.610022] __l2cap_get_chan_by_scid:
[  265.610025] l2cap_data_channel: sk e015fc00, len 4
[  265.610029] l2cap_ertm_data_rcv:
[  265.610032] l2cap_check_fcs:
[  265.610036] l2cap_data_channel_sframe: sk e015fc00 rx_control 0x3801 len 0
[  265.610041] l2cap_data_channel_rrframe: sk e015fc00, req_seq 56 ctrl 0x3801
[  265.610044] l2cap_drop_acked_frames:
[  265.610060] l2cap_ertm_send: sk e015fc00, sk->scid 42, sk->dcid 5d
[  265.610064] l2cap_tx_window_full:
[  265.610071] l2cap_ertm_send: pi->next_tx_seq: 13, pi->buffer_seq: 2
[  265.610075] l2cap_do_send: sk e015fc00, cid 66 skb e0147840 len 1019
[  265.610078] l2cap_loglink_validate:
[  265.610081] l2cap_do_send: send I frame over AMP controller
[  265.610085] l2cap_tx_window_full:
[  265.610093] l2cap_ertm_send: pi->next_tx_seq: 14, pi->buffer_seq: 2
[  265.610096] l2cap_do_send: sk e015fc00, cid 66 skb f4801cc0 len 1019
[  265.610099] l2cap_loglink_validate:
[  265.610102] l2cap_do_send: send I frame over AMP controller
[  265.610105] l2cap_tx_window_full:
[  265.610112] l2cap_ertm_send: pi->next_tx_seq: 15, pi->buffer_seq: 2
[  265.610115] l2cap_do_send: sk e015fc00, cid 66 skb f4801600 len 1019
[  265.610118] l2cap_loglink_validate:
[  265.610121] l2cap_do_send: send I frame over AMP controller
[  265.610124] l2cap_tx_window_full:
[  265.610130] l2cap_ertm_send: pi->next_tx_seq: 16, pi->buffer_seq: 2
[  265.610133] l2cap_do_send: sk e015fc00, cid 66 skb f4801c00 len 689
[  265.610137] l2cap_loglink_validate:
[  265.610140] l2cap_do_send: send I frame over AMP controller
[  265.610143] l2cap_tx_window_full:
[  265.610153] l2cap_ertm_send: pi->next_tx_seq: 17, pi->buffer_seq: 2
[  265.610215] l2cap_ertm_send: pi->next_tx_seq: 20, pi->buffer_seq: 2
[  265.610219] l2cap_do_send: sk e015fc00, cid 66 skb f47f03c0 len 1019
[  265.610222] l2cap_loglink_validate:
[  265.619937] l2cap_recv_acldata:
[  265.619948] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.619952] l2cap_recv_frame: conn f461bcc0, skb ee91c300, cid 42, len 4
[  265.619956] l2cap_recv_frame: len 4, cid 0x0042
[  265.620154] l2cap_ertm_send: pi->next_tx_seq: 29, pi->buffer_seq: 2
[  265.629111] l2cap_recv_acldata:
[  265.629123] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3

[  265.639371] l2cap_recv_acldata:
[  265.639384] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.639388] l2cap_recv_frame: conn f461bcc0, skb ee91ccc0, cid 42, len 4
[  265.639392] l2cap_recv_frame: len 4, cid 0x0042
[  265.639395] l2cap_data_channel:
[  265.639398] l2cap_get_chan_by_scid:
[  265.639401] __l2cap_get_chan_by_scid:
[  265.639405] l2cap_data_channel: sk e015fc00, len 4
[  265.639407] l2cap_ertm_data_rcv:
[  265.639570] l2cap_do_send: send I frame over AMP controller
[  265.646669] l2cap_recv_acldata:
[  265.646681] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.646685] l2cap_recv_frame: conn f461bcc0, skb ee91c6c0, cid 42, len 4
[  265.646822] l2cap_loglink_validate:
[  265.646825] l2cap_skbuff_fromiovec:
[  265.647800] l2cap_recv_acldata:
[  265.647808] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.649645] l2cap_recv_acldata:
[  265.649655] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.649659] l2cap_recv_frame: conn f461bcc0, skb ee91c180, cid 42, len 4
[  265.649663] l2cap_recv_frame: len 4, cid 0x0042
[  265.651518] l2cap_recv_acldata:
[  265.651527] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.651532] l2cap_recv_frame: conn f461bcc0, skb ee91c0c0, cid 42, len 4
[  265.655539] l2cap_recv_acldata:
[  265.655547] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.655550] l2cap_recv_frame: conn f461bcc0, skb e035bc00, cid 42, len 4
[  265.655554] l2cap_recv_frame: len 4, cid 0x0042
[  265.655556] l2cap_data_channel:
[  265.655559] l2cap_get_chan_by_scid:
[  265.655562] __l2cap_get_chan_by_scid:
[  265.663270] l2cap_recv_acldata:
[  265.663276] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.667987] l2cap_recv_acldata:
[  265.673206] l2cap_recv_acldata:
[  265.673217] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.673221] l2cap_recv_frame: conn f461bcc0, skb ee91c780, cid 42, len 4
[  265.673225] l2cap_recv_frame: len 4, cid 0x0042
[  265.673227] l2cap_data_channel:
[  265.673230] l2cap_get_chan_by_scid:
[  265.673233] __l2cap_get_chan_by_scid:
[  265.673236] l2cap_data_channel: sk e015fc00, len 4
[  265.673240] l2cap_ertm_data_rcv:
[  265.673243] l2cap_check_fcs:
[  265.673247] l2cap_data_channel_sframe: sk e015fc00 rx_control 0x3109 len 0
[  265.675265] l2cap_recv_acldata:
[  265.675273] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.691337] l2cap_recv_acldata:
[  265.691348] l2cap_recv_acldata: conn f461bcc0 len 8 flags 0x3
[  265.691352] l2cap_recv_frame: conn f461bcc0, skb ee91c000, cid 42, len 4
[  265.691356] l2cap_recv_frame: len 4, cid 0x0042
[  265.691359] l2cap_data_channel:
[  265.691362] l2cap_get_chan_by_scid:
[  265.691366] __l2cap_get_chan_by_scid:
[  265.691369] l2cap_data_channel: sk e015fc00, len 4
[  265.691372] l2cap_ertm_data_rcv:
[  265.691375] l2cap_check_fcs:
[  265.691379] l2cap_data_channel_sframe: sk e015fc00 rx_control 0x3511 len 0
[  265.691383] l2cap_data_channel_rrframe: sk e015fc00, req_seq 53 ctrl 0x3511
[  265.691386] l2cap_drop_acked_frames:
[  265.691389] l2cap_send_i_or_rr_or_rnr:
[  265.691392] l2cap_ertm_send: sk e015fc00, sk->scid 42, sk->dcid 5d
[  265.691396] l2cap_tx_window_full:
[  265.691400] l2cap_ertm_send: pi->next_tx_seq: 53, pi->buffer_seq: 2
[  265.691404] l2cap_do_send: sk e015fc00, cid 66 skb e0204000 len 101
[  265.691407] l2cap_loglink_validate:
[  265.691410] l2cap_do_send: send I frame over AMP controller
[  265.691415] skb_under_panic: text:f8224a57 len:105 put:4
head:e002ba00 data:e002b9fe tail:0xe002ba2c end:0xe002ba80 dev:瘗"?
[  265.691443] ------------[ cut here ]------------
[  265.691446] kernel BUG at net/core/skbuff.c:147!
[  265.691450] invalid opcode: 0000 [#1] SMP
[  265.691456] last sysfs file:
/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:00/PNP0C09:00/PNP0C0A:00/power_supply/BAT0/energy_full
[  265.691460] Modules linked in:[  265.692743]  [<f822573e>]
hci_rx_task+0x2de/0x380 [bluetooth]
[  265.692748]  [<c0132921>] ? __dequeue_entity+0x21/0x40
[  265.696007] NOHZ: local_softirq_pending 0e

>From above context, we know we expect a skb with length 1019(1011+8),
but dump context tell us, the len is 105.

-- 
Haijun Liu
