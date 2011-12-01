Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Dec 2011 23:13:05 +0900
From: Gustavo Padovan <padovan@profusion.mobi>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH-v5 4/6] Bluetooth: Centralize SMP pairing failure handling
Message-ID: <20111201141305.GF2894@joana>
References: <1322065718-11570-1-git-send-email-bgix@codeaurora.org>
 <1322065718-11570-5-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322065718-11570-5-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

* Brian Gix <bgix@codeaurora.org> [2011-11-23 08:28:36 -0800]:

> Signed-off-by: Brian Gix <bgix@codeaurora.org>
> ---
>  net/bluetooth/smp.c |   22 ++++++++++++++++------
>  1 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index b9af488..0b96737 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -232,6 +232,18 @@ static u8 check_enc_key_size(struct l2cap_conn *conn, __u8 max_key_size)
>  	return 0;
>  }
>  
> +static void smp_failure(struct l2cap_conn *conn, u8 reason, u8 send)
> +{
> +	if (send)
> +		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
> +								&reason);
> +
> +	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->hcon->pend);
> +	mgmt_auth_failed(conn->hcon->hdev, conn->dst, reason);
> +	del_timer(&conn->security_timer);
> +	smp_chan_destroy(conn);
> +}
> +
>  static void confirm_work(struct work_struct *work)
>  {
>  	struct smp_chan *smp = container_of(work, struct smp_chan, confirm);
> @@ -270,8 +282,7 @@ static void confirm_work(struct work_struct *work)
>  	return;
>  
>  error:
> -	smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason), &reason);
> -	smp_chan_destroy(conn);
> +	smp_failure(conn, reason, 1);
>  }
>  
>  static void random_work(struct work_struct *work)
> @@ -354,8 +365,7 @@ static void random_work(struct work_struct *work)
>  	return;
>  
>  error:
> -	smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason), &reason);
> -	smp_chan_destroy(conn);
> +	smp_failure(conn, reason, 1);
>  }
>  
>  static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
> @@ -655,6 +665,7 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
>  		break;
>  
>  	case SMP_CMD_PAIRING_FAIL:
> +		smp_failure(conn, skb->data[0], 0);
>  		reason = 0;
>  		err = -EPERM;
>  		break;
> @@ -700,8 +711,7 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
>  
>  done:
>  	if (reason)
> -		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
> -								&reason);
> +		smp_failure(conn, reason, 1);
>  
>  	kfree_skb(skb);
>  	return err;

Patch 1 to 4 were applied. Thanks.

	Gustavo
