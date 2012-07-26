Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Jul 2012 22:54:12 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Subject: Re: [RFCv0 12/21] Bluetooth: Add state to hci_chan
Message-ID: <20120726195410.GB5144@aemeltch-MOBL1>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
 <1343260274-11953-13-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343260274-11953-13-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, Jul 25, 2012 at 04:51:04PM -0700, Mat Martineau wrote:
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/hci_core.h | 7 ++++---
>  net/bluetooth/hci_conn.c         | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 41d9439..4de510a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -336,11 +336,12 @@ struct hci_conn {
>  };
>  
>  struct hci_chan {
> -	struct list_head list;
> +	struct list_head	list;
>  
> -	struct hci_conn *conn;
> -	struct sk_buff_head data_q;
> +	struct hci_conn	*conn;
> +	struct sk_buff_head	data_q;

the real patch start here?

>  	unsigned int	sent;
> +	__u8	state;
>  };
>  
>  extern struct list_head hci_dev_list;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 5ad7da2..1b796e5 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -903,6 +903,7 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
>  
>  	chan->conn = conn;
>  	skb_queue_head_init(&chan->data_q);
> +	chan->state = BT_CONNECTED;
>  
>  	list_add_rcu(&chan->list, &conn->chan_list);
>  

