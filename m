Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Dec 2010 14:39:51 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: Re: [RFC v2 4/9] Bluetooth: simple SMP pairing negotiation
Message-ID: <20101207163951.GE2944@vigoh>
References: <1291671832-13435-1-git-send-email-vinicius.gomes@openbossa.org>
 <1291671832-13435-5-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291671832-13435-5-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2010-12-06 18:43:47 -0300]:

> From: Anderson Briglia <anderson.briglia@openbossa.org>
> 
> This implementation only exchanges SMP messages between the Host and the
> Remote. No keys are being generated. TK and STK generation will be
> provided in further patches.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/l2cap_core.c |    3 +-
>  net/bluetooth/smp.c        |  114 ++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 112 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 674799c..da4f13d 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4630,7 +4630,8 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
>  		break;
>  
>  	case L2CAP_CID_SMP:
> -		smp_sig_channel(conn, skb);
> +		if (smp_sig_channel(conn, skb))
> +			l2cap_conn_del(conn->hcon, 0x05);

So this could be in the previous patch instead of this one.

>  		break;
>  
>  	default:
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index e9dde5f..b25010f 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -64,6 +64,102 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
>  	hci_send_acl(conn->hcon, skb, 0);
>  }
>  
> +static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
> +{
> +	struct smp_cmd_pairing *rp = (void *) skb->data;
> +
> +	BT_DBG("");

BT_DBG("conn %p", conn); is better. Same for the other functions below.

> +
> +	skb_pull(skb, sizeof(struct smp_cmd_pairing));
> +
> +	rp->io_capability = 0x00;
> +	rp->oob_flag = 0x00;
> +	rp->max_key_size = 16;
> +	rp->init_key_dist = 0x00;
> +	rp->resp_key_dist = 0x00;
> +	rp->auth_req &= 0x05;
> +
> +	smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(*rp), rp);
> +}
> +
> +static void smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
> +{
> +	struct smp_cmd_pairing_confirm cp;
> +
> +	BT_DBG("");
> +
> +	memset(&cp, 0, sizeof(struct smp_cmd_pairing_confirm));
> +
> +	smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
> +}
> +
> +static void smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
> +{
> +	BT_DBG("");

	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave"); 

Is better, no?

> +
> +	if (conn->hcon->out) {
> +		struct smp_cmd_pairing_random random;
> +
> +		BT_DBG("master");
> +
> +		memset(&random, 0, sizeof(struct smp_cmd_pairing_random));
> +
> +		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(random),
> +								&random);
> +	} else {
> +		struct smp_cmd_pairing_confirm confirm;
> +
> +		BT_DBG("slave");
> +
> +		memset(&confirm, 0, sizeof(struct smp_cmd_pairing_confirm));
> +
> +		smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(confirm),
> +								&confirm);
> +	}
> +}
> +
> +static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
> +{
> +	struct smp_cmd_pairing_random cp;
> +
> +	BT_DBG("");
> +
> +	skb_pull(skb, sizeof(struct smp_cmd_pairing_random));
> +
> +	/* FIXME: check if random matches */
> +
> +	if (conn->hcon->out) {
> +		BT_DBG("master");
> +		/* FIXME: start encryption */
> +	} else {
> +		BT_DBG("slave");
> +
> +		memset(&cp, 0, sizeof(struct smp_cmd_pairing_random));
> +
> +		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(cp), &cp);
> +	}
> +}
> +
> +static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
> +{
> +	struct smp_cmd_security_req *rp = (void *) skb->data;
> +	struct smp_cmd_pairing cp;
> +
> +	BT_DBG("");
> +
> +	skb_pull(skb, sizeof(struct smp_cmd_security_req));
> +	memset(&cp, 0, sizeof(struct smp_cmd_pairing));
> +
> +	cp.io_capability = 0x00;
> +	cp.oob_flag = 0x00;
> +	cp.max_key_size = 16;
> +	cp.init_key_dist = 0x00;
> +	cp.resp_key_dist = 0x00;
> +	cp.auth_req = rp->auth_req & 0x05;
> +
> +	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
> +}
> +
>  int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
>  {
>  	__u8 authreq;
> @@ -114,23 +210,33 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
>  
>  	switch (code) {
>  	case SMP_CMD_PAIRING_REQ:
> -		reason = SMP_PAIRING_NOTSUPP;
> -		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, 1, &reason);
> -		err = -1;
> +		smp_cmd_pairing_req(conn, skb);
>  		break;
>  
>  	case SMP_CMD_PAIRING_FAIL:
>  		break;
>  
>  	case SMP_CMD_PAIRING_RSP:
> +		smp_cmd_pairing_rsp(conn, skb);
> +		break;
> +
> +	case SMP_CMD_SECURITY_REQ:
> +		smp_cmd_security_req(conn, skb);
> +		break;
> +
>  	case SMP_CMD_PAIRING_CONFIRM:
> +		smp_cmd_pairing_confirm(conn, skb);
> +		break;
> +
>  	case SMP_CMD_PAIRING_RANDOM:
> +		smp_cmd_pairing_random(conn, skb);
> +		break;
> +
>  	case SMP_CMD_ENCRYPT_INFO:
>  	case SMP_CMD_MASTER_IDENT:
>  	case SMP_CMD_IDENT_INFO:
>  	case SMP_CMD_IDENT_ADDR_INFO:
>  	case SMP_CMD_SIGN_INFO:
> -	case SMP_CMD_SECURITY_REQ:
>  	default:
>  		BT_DBG("Unknown command code 0x%2.2x", code);
>  
> -- 
> 1.7.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gustavo F. Padovan
http://profusion.mobi
