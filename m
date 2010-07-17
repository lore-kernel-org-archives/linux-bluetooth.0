Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Sat, 17 Jul 2010 14:51:40 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	=?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@profusion.mobi>,
	linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] l2cap: fix signedness bugs
Message-ID: <20100717175139.GF16892@vigoh>
References: <20100717170548.GH17585@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100717170548.GH17585@bicker>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

* Dan Carpenter <error27@gmail.com> [2010-07-17 19:05:48 +0200]:

> These variables are only used for math.  They should be from -63 to +63.
> In the original code instead of being negative they would be largish
> positive numbers.  I changed them to ints.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 1b682a5..4a13499 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -3795,7 +3795,7 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
>  	u8 tx_seq = __get_txseq(rx_control);
>  	u8 req_seq = __get_reqseq(rx_control);
>  	u8 sar = rx_control >> L2CAP_CTRL_SAR_SHIFT;
> -	u8 tx_seq_offset, expected_tx_seq_offset;
> +	int tx_seq_offset, expected_tx_seq_offset;
>  	int num_to_ack = (pi->tx_win/6) + 1;
>  	int err = 0;
>  
> @@ -4080,7 +4080,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
>  	struct sock *sk;
>  	struct l2cap_pinfo *pi;
>  	u16 control, len;
> -	u8 tx_seq, req_seq, next_tx_seq_offset, req_seq_offset;
> +	int tx_seq, req_seq, next_tx_seq_offset, req_seq_offset;
>  
>  	sk = l2cap_get_chan_by_scid(&conn->chan_list, cid);
>  	if (!sk) {

I fixed this already. Thanks.

-- 
Gustavo F. Padovan
http://padovan.org
