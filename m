Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Feb 2011 08:37:15 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: Re: [bluetooth-next 16/24] Bluetooth: Add SMP confirmation checks
 methods
Message-ID: <20110210063715.GK874@null>
References: <1297300704-30006-1-git-send-email-vinicius.gomes@openbossa.org>
 <1297300704-30006-17-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297300704-30006-17-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Feb 09, 2011 at 10:18:16PM -0300, ext Vinicius Costa Gomes wrote:
> From: Anderson Briglia <anderson.briglia@openbossa.org>
> 
> This patch includes support for generating and sending the random value
> used to produce the confirmation value.
> 
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/smp.c           |   93 ++++++++++++++++++++++++++++++++++-------
>  2 files changed, 79 insertions(+), 15 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index ceea46d..359dd1b 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -294,6 +294,7 @@ struct l2cap_conn {
>  	__u8		pres[7];
>  	__u8		prnd[16];
>  	__u8		pcnf[16];
> +	__u8		tk[16];
>  
>  	struct l2cap_chan_list chan_list;
>  };
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 89e08fe..438226a0 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -203,6 +203,9 @@ static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
>  	rp->resp_key_dist = 0x00;
>  	rp->auth_req &= 0x05;
>  
> +	/* Just works */
> +	memset(conn->tk, 0, sizeof(conn->tk));
> +
>  	conn->pres[0] = SMP_CMD_PAIRING_RSP;
>  	memcpy(&conn->pres[1], rp, sizeof(*rp));
>  
> @@ -213,53 +216,113 @@ static void smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
>  {
>  	struct smp_cmd_pairing *rp = (void *) skb->data;
>  	struct smp_cmd_pairing_confirm cp;
> +	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
> +	int ret;
> +	u8 res[16];
>  
>  	BT_DBG("conn %p", conn);
>  
> -	memset(&cp, 0, sizeof(cp));
> +	/* Just works */
> +	memset(conn->tk, 0, sizeof(conn->tk));
>  
>  	conn->pres[0] = SMP_CMD_PAIRING_RSP;
>  	memcpy(&conn->pres[1], rp, sizeof(*rp));
>  	skb_pull(skb, sizeof(*rp));
>  
> +	ret = smp_rand(conn->prnd);
> +	if (ret)
> +		return;
> +
> +	ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->pres, 0,
> +			conn->src, 0, conn->dst, res);
> +	if (ret)
> +		return;
> +
> +	swap128(res, cp.confirm_val);
> +
>  	smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
>  }
>  
>  static void smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
>  {
> +	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
> +
>  	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
>  
> -	if (conn->hcon->out) {
> -		struct smp_cmd_pairing_random random;
> +	memcpy(conn->pcnf, skb->data, 16);
> +	skb_pull(skb, 16);

Use sizeof().

>  
> -		memset(&random, 0, sizeof(random));
> +	if (conn->hcon->out) {
> +		u8 random[16];
>  
> -		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(random),
> -								&random);
> +		swap128(conn->prnd, random);
> +		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, 16, random);

Ditto

>  	} else {
> -		struct smp_cmd_pairing_confirm confirm;
> +		struct smp_cmd_pairing_confirm cp;
> +		int ret;
> +		u8 res[16];
>  
> -		memset(&confirm, 0, sizeof(confirm));
> +		ret = smp_rand(conn->prnd);
> +		if (ret)
> +			return;
>  
> -		smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(confirm),
> -								&confirm);
> +		ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->pres,
> +					0, conn->dst, 0, conn->src, res);
> +		if (ret)
> +			return;
> +
> +		swap128(res, cp.confirm_val);
> +
> +		smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
>  	}
>  }
>  
>  static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
>  {
> -	struct smp_cmd_pairing_random cp;
> +	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
> +	int ret;
> +	u8 key[16], res[16], random[16], confirm[16], buf[128];
> +
> +	swap128(skb->data, random);
> +	skb_pull(skb, 16);

Ditto

>
> +
> +	if (conn->hcon->out)
> +		ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->pres, 0,
> +				conn->src, 0, conn->dst, res);
> +	else
> +		ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->pres, 0,
> +				conn->dst, 0, conn->src, res);
> +	if (ret)
> +		return;
>  
>  	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
>  
> -	skb_pull(skb, sizeof(cp));
> +	swap128(res, confirm);
> +
> +	if (memcmp(conn->pcnf, confirm, 16) != 0) {

Ditto

> +		struct smp_cmd_pairing_fail cp;
> +
> +		BT_ERR("Pairing failed (confirmation values mismatch)");
> +		cp.reason = SMP_CONFIRM_FAILED;
> +		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(cp), &cp);
> +		return;
> +	}
>  
>  	if (conn->hcon->out) {
> -		/* FIXME: start encryption */
> +		smp_s1(tfm, conn->tk, random, conn->prnd, key);
> +
> +		hex_dump_to_buffer(key, sizeof(key), 16, 1, buf, sizeof(buf), 0);
> +		BT_DBG("key %s", buf);
>  	} else {
> -		memset(&cp, 0, sizeof(cp));
> +		u8 r[16];
> +
> +		swap128(conn->prnd, r);
> +		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, 16, r);

Ditto

> +
> +		smp_s1(tfm, conn->tk, conn->prnd, random, key);
>  
> -		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(cp), &cp);
> +		hex_dump_to_buffer(key, sizeof(key), 16, 1, buf, sizeof(buf), 0);
> +		BT_DBG("key %s", buf);
>  	}
>  }


-- 
Ville
