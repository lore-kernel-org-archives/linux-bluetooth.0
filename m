Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1291671832-13435-8-git-send-email-vinicius.gomes@openbossa.org>
References: <1291671832-13435-1-git-send-email-vinicius.gomes@openbossa.org>
	<1291671832-13435-8-git-send-email-vinicius.gomes@openbossa.org>
Date: Wed, 8 Dec 2010 11:18:37 +0530
Message-ID: <AANLkTikkMK6gXigQ49iMa25c2XZ1Dx9hp7DvWR=8_3XQ@mail.gmail.com>
Subject: Re: [RFC v2 7/9] Bluetooth: Add support for SMP confirmation checks
From: Koustuv Ghosh <koustuvg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 Hello Vinicus,
 regarding the below routine,
 is it not good to check the IO capabilities and authentication
rquirement of the remote device from the skb inside this routine and
based on that we can trigger JustWorks or PassKey paring method.
Though I know you are implementing  only JustWorks
 but I feel it will be good approach to parse the response and then
trigger the paring method.


  static void smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
  {
+       struct smp_cmd_pairing *rp = (void *) skb->data;
        struct smp_cmd_pairing_confirm cp;
 +       struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
 +       int ret;
 +       u8 k[16], res[16];

 -       BT_DBG("");
 +       /* Just Works */
 +       memset(k, 0, sizeof(k));
 +
 +       conn->pres[0] = SMP_CMD_PAIRING_RSP;
 +       memcpy(&conn->pres[1], rp, sizeof(*rp));
 +       skb_pull(skb, sizeof(*rp));

 -       memset(&cp, 0, sizeof(struct smp_cmd_pairing_confirm));
 +       ret = smp_rand(conn->prnd);
 +       if (ret)
 +               return;
 +
 +       ret = smp_c1(tfm, k, conn->prnd, conn->preq, conn->pres, 0,
 +                       conn->src, 0, conn->dst, res);
 +       if (ret)
 +               return;

        smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
  }

On Tue, Dec 7, 2010 at 3:13 AM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> This adds supports for verifying the confirmation value that the
> remote side has sent. This includes support for generating and sending
> the random value used to produce the confirmation value.
>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/l2cap.h |    5 ++
>  net/bluetooth/smp.c           |  121 ++++++++++++++++++++++++++++++++---------
>  2 files changed, 101 insertions(+), 25 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index a3cb1ab..bcda2aa 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -290,6 +290,11 @@ struct l2cap_conn {
>
>        __u8            disc_reason;
>
> +       __u8            preq[7];
> +       __u8            pres[7];
> +       __u8            prnd[16];
> +       __u8            pcnf[16];
> +
>        struct l2cap_chan_list chan_list;
>  };
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index b62160e..7d7e8ad 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -203,7 +203,9 @@ static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
>
>        BT_DBG("");
>
> -       skb_pull(skb, sizeof(struct smp_cmd_pairing));
> +       conn->preq[0] = SMP_CMD_PAIRING_REQ;
> +       memcpy(&conn->preq[1], rp, sizeof(*rp));
> +       skb_pull(skb, sizeof(*rp));
>
>        rp->io_capability = 0x00;
>        rp->oob_flag = 0x00;
> @@ -212,64 +214,125 @@ static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
>        rp->resp_key_dist = 0x00;
>        rp->auth_req &= 0x05;
>
> +       conn->pres[0] = SMP_CMD_PAIRING_RSP;
> +       memcpy(&conn->pres[1], rp, sizeof(rp));
> +
>        smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(*rp), rp);
>  }
>
>  static void smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
>  {
> +       struct smp_cmd_pairing *rp = (void *) skb->data;
>        struct smp_cmd_pairing_confirm cp;
> +       struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
> +       int ret;
> +       u8 k[16], res[16];
>
> -       BT_DBG("");
> +       /* Just Works */
> +       memset(k, 0, sizeof(k));
> +
> +       conn->pres[0] = SMP_CMD_PAIRING_RSP;
> +       memcpy(&conn->pres[1], rp, sizeof(*rp));
> +       skb_pull(skb, sizeof(*rp));
> +
> +       ret = smp_rand(conn->prnd);
> +       if (ret)
> +               return;
>
> -       memset(&cp, 0, sizeof(struct smp_cmd_pairing_confirm));
> +       ret = smp_c1(tfm, k, conn->prnd, conn->preq, conn->pres, 0,
> +                       conn->src, 0, conn->dst, res);
> +       if (ret)
> +               return;
> +
> +       swap128(res, cp.confirm_val);
>
>        smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
>  }
>
>  static void smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
>  {
> +       struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
> +
>        BT_DBG("");
>
> -       if (conn->hcon->out) {
> -               struct smp_cmd_pairing_random random;
> +       memcpy(conn->pcnf, skb->data, 16);
> +       skb_pull(skb, 16);
>
> -               BT_DBG("master");
> +       if (conn->hcon->out) {
> +               u8 random[16];
>
> -               memset(&random, 0, sizeof(struct smp_cmd_pairing_random));
> +               swap128(conn->prnd, random);
>
> -               smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(random),
> -                                                               &random);
> +               smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, 16, random);
>        } else {
> -               struct smp_cmd_pairing_confirm confirm;
> +               struct smp_cmd_pairing_confirm cp;
> +               int ret;
> +               u8 k[16], res[16];
> +
> +               /* Just Works */
> +               memset(k, 0, sizeof(k));
>
> -               BT_DBG("slave");
> +               ret = smp_rand(conn->prnd);
> +               if (ret)
> +                       return;
>
> -               memset(&confirm, 0, sizeof(struct smp_cmd_pairing_confirm));
> +               ret = smp_c1(tfm, k, conn->prnd, conn->preq, conn->pres, 0,
> +                               conn->dst, 0, conn->src, res);
> +               if (ret)
> +                       return;
>
> -               smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(confirm),
> -                                                               &confirm);
> +               swap128(res, cp.confirm_val);
> +
> +               smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
>        }
>  }
>
>  static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
>  {
> -       struct smp_cmd_pairing_random cp;
> +       struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
> +       int ret;
> +       u8 k[16], key[16], res[16], random[16], confirm[16], buf[128];
> +
> +       swap128(skb->data, random);
> +       skb_pull(skb, 16);
> +
> +       memset(k, 0, sizeof(k));
> +
> +       if (conn->hcon->out)
> +               ret = smp_c1(tfm, k, random, conn->preq, conn->pres, 0,
> +                               conn->src, 0, conn->dst, res);
> +       else
> +               ret = smp_c1(tfm, k, random, conn->preq, conn->pres, 0,
> +                               conn->dst, 0, conn->src, res);
> +       if (ret)
> +               return;
>
> -       BT_DBG("");
> +       swap128(res, confirm);
>
> -       skb_pull(skb, sizeof(struct smp_cmd_pairing_random));
> +       if (memcmp(conn->pcnf, confirm, 16) != 0) {
> +               struct smp_cmd_pairing_fail cp;
>
> -       /* FIXME: check if random matches */
> +               BT_ERR("Pairing failed (confirmation values mismatch)");
> +               cp.reason = SMP_CONFIRM_FAILED;
> +               smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(cp), &cp);
> +               return;
> +       }
>
>        if (conn->hcon->out) {
> -               BT_DBG("master");
> -               /* FIXME: start encryption */
> +               smp_s1(tfm, k, random, conn->prnd, key);
> +
> +               hex_dump_to_buffer(key, sizeof(key), 16, 1, buf, sizeof(buf), 0);
> +               BT_DBG("key %s", buf);
>        } else {
> -               BT_DBG("slave");
> +               u8 r[16];
>
> -               memset(&cp, 0, sizeof(struct smp_cmd_pairing_random));
> +               swap128(conn->prnd, r);
> +               smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, 16, r);
>
> -               smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(cp), &cp);
> +               smp_s1(tfm, k, conn->prnd, random, key);
> +
> +               hex_dump_to_buffer(key, sizeof(key), 16, 1, buf, sizeof(buf), 0);
> +               BT_DBG("key %s", buf);
>        }
>  }
>
> @@ -280,8 +343,9 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
>
>        BT_DBG("");
>
> -       skb_pull(skb, sizeof(struct smp_cmd_security_req));
> -       memset(&cp, 0, sizeof(struct smp_cmd_pairing));
> +       skb_pull(skb, sizeof(*rp));
> +
> +       memset(&cp, 0, sizeof(cp));
>
>        cp.io_capability = 0x00;
>        cp.oob_flag = 0x00;
> @@ -290,6 +354,9 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
>        cp.resp_key_dist = 0x00;
>        cp.auth_req = rp->auth_req & 0x05;
>
> +       conn->preq[0] = SMP_CMD_PAIRING_REQ;
> +       memcpy(&conn->preq[1], &cp, sizeof(cp));
> +
>        smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
>  }
>
> @@ -323,6 +390,10 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
>                cp.init_key_dist = 0x00;
>                cp.resp_key_dist = 0x00;
>                cp.auth_req = authreq;
> +
> +               conn->preq[0] = SMP_CMD_PAIRING_REQ;
> +               memcpy(&conn->preq[1], &cp, sizeof(cp));
> +
>                smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
>        } else {
>                struct smp_cmd_security_req cp;
> --
> 1.7.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
