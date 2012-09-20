Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Sep 2012 13:39:22 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Subject: Re: [RFCv1 01/20] Bluetooth: Add new l2cap_chan struct members for
 high speed channels
Message-ID: <20120920103920.GC13291@aemeltch-MOBL1>
References: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
 <1347387691-5285-2-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347387691-5285-2-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Tue, Sep 11, 2012 at 11:21:12AM -0700, Mat Martineau wrote:
> An L2CAP channel using high speed continues to be associated with a
> BR/EDR l2cap_conn, while also tracking an additional hci_conn
> (representing a physical link on a high speed controller) and hci_chan
> (representing a logical link).  There may only be one physical link
> between two high speed controllers.  Each physical link may contain
> several logical links, with each logical link representing a channel
> with specific quality of service.
> 
> During a channel move, the destination channel id, current move state,
> and role (initiator vs. responder) are tracked and used by the channel
> move state machine.  The ident value associated with a move request
> must also be stored in order to use it in later move responses.
> 
> The active channel is stored in local_amp_id.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h | 29 +++++++++++++++++++++++++++++
>  net/bluetooth/l2cap_core.c    |  5 +++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 7ed8e35..6b6fb27 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -433,6 +433,8 @@ struct l2cap_chan {
>  	struct sock *sk;
>  
>  	struct l2cap_conn	*conn;
> +	struct hci_conn		*hs_hcon;

Do we need hs_hcon if we have hs_hchan ?

> +	struct hci_chan		*hs_hchan;
>  	struct kref	kref;
>  
>  	__u8		state;
> @@ -476,6 +478,11 @@ struct l2cap_chan {
>  	unsigned long	conn_state;
>  	unsigned long	flags;
>  
> +	__u8		local_amp_id;
> +	__u8		move_id;

So this is Destination AMP ctrl id, would this be better to name it like
move_dst_amp_id or dst_amp_id;

...

Best regards 
Andrei Emeltchenko 

