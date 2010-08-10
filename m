Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Tue, 10 Aug 2010 18:57:37 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC 1/7] Bluetooth: Calculate L2CAP FCS on fragmented skbuffs.
Message-ID: <20100810215737.GA3203@vigoh>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
 <1281467704-5378-2-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281467704-5378-2-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2010-08-10 12:14:58 -0700]:

> When L2CAP PDUs are longer than the HCI MTU, they are stored in
> fragmented skbuffs.  This adds a function to calculate the FCS
> on any skbuff (fragmented or not), and replaces direct calls
> to crc16 with calls to the new apply_fcs() function.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |   57 ++++++++++++++++++++++++++++++++----------------
>  1 files changed, 38 insertions(+), 19 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 8d362d7..5e78c18 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -351,6 +351,33 @@ static inline u8 l2cap_get_ident(struct l2cap_conn *conn)
>  	return id;
>  }
>  
> +static void apply_fcs(struct sk_buff *skb)

I would call this l2cap_apply_fcs().


-- 
Gustavo F. Padovan
http://padovan.org
