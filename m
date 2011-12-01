Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Dec 2011 23:11:35 +0900
From: Gustavo Padovan <padovan@profusion.mobi>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH-v5 5/6] Bluetooth: Add MITM mechanism to LE-SMP
Message-ID: <20111201141135.GE2894@joana>
References: <1322065718-11570-1-git-send-email-bgix@codeaurora.org>
 <1322065718-11570-6-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322065718-11570-6-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

* Brian Gix <bgix@codeaurora.org> [2011-11-23 08:28:37 -0800]:

> To achive Man-In-The-Middle (MITM) level security with Low Energy,
> we have to enable User Passkey Comparison.  This commit modifies the
> hard-coded JUST-WORKS pairing mechanism to support query via the MGMT
> interface of Passkey comparison and User Confirmation.
> 
> Signed-off-by: Brian Gix <bgix@codeaurora.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  include/net/bluetooth/smp.h      |    3 +
>  net/bluetooth/smp.c              |  228 ++++++++++++++++++++++++++++++++++----
>  3 files changed, 210 insertions(+), 22 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e7b2e25..4aa417c 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -312,6 +312,7 @@ struct hci_conn {
>  	struct hci_dev	*hdev;
>  	void		*l2cap_data;
>  	void		*sco_data;
> +	void		*smp_conn;
>  
>  	struct hci_conn	*link;
>  
> diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
> index 15b97d5..43b6c49 100644
> --- a/include/net/bluetooth/smp.h
> +++ b/include/net/bluetooth/smp.h
> @@ -124,6 +124,8 @@ struct smp_chan {
>  	u8		pcnf[16]; /* SMP Pairing Confirm */
>  	u8		tk[16]; /* SMP Temporary Key */
>  	u8		smp_key_size;
> +	u8		smp_tk_valid;
> +	u8		smp_cfm_pending;

Those two could be converted in a bitfield, you are using them as boolean.

>  	struct crypto_blkcipher	*tfm;
>  	struct work_struct confirm;
>  	struct work_struct random;
> @@ -134,6 +136,7 @@ struct smp_chan {
>  int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level);
>  int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb);
>  int smp_distribute_keys(struct l2cap_conn *conn, __u8 force);
> +int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey);
>  
>  void smp_chan_destroy(struct l2cap_conn *conn);
>  
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 0b96737..e1df0a2 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -23,6 +23,7 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>  #include <net/bluetooth/l2cap.h>
> +#include <net/bluetooth/mgmt.h>
>  #include <net/bluetooth/smp.h>
>  #include <linux/crypto.h>
>  #include <linux/scatterlist.h>
> @@ -188,24 +189,46 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
>  					msecs_to_jiffies(SMP_TIMEOUT));
>  }
>  
> +static __u8 authreq_to_seclevel(__u8 authreq)
> +{
> +	if (authreq & SMP_AUTH_MITM)
> +		return BT_SECURITY_HIGH;
> +	else
> +		return BT_SECURITY_MEDIUM;
> +}
> +
> +static __u8 seclevel_to_authreq(__u8 sec_level)
> +{
> +	switch (sec_level) {
> +	case BT_SECURITY_HIGH:
> +		return SMP_AUTH_MITM | SMP_AUTH_BONDING;
> +	case BT_SECURITY_MEDIUM:
> +		return SMP_AUTH_BONDING;
> +	default:
> +		return SMP_AUTH_NONE;
> +	}
> +}
> +
>  static void build_pairing_cmd(struct l2cap_conn *conn,
>  				struct smp_cmd_pairing *req,
>  				struct smp_cmd_pairing *rsp,
>  				__u8 authreq)
>  {
> -	u8 dist_keys;
> +	u8 all_keys = 0;
> +	u8 dist_keys = 0;
>  
> -	dist_keys = 0;
>  	if (test_bit(HCI_PAIRABLE, &conn->hcon->hdev->flags)) {
>  		dist_keys = SMP_DIST_ENC_KEY;
>  		authreq |= SMP_AUTH_BONDING;
> +	} else {
> +		authreq &= ~SMP_AUTH_BONDING;
>  	}
>  
>  	if (rsp == NULL) {
>  		req->io_capability = conn->hcon->io_capability;
>  		req->oob_flag = SMP_OOB_NOT_PRESENT;
>  		req->max_key_size = SMP_MAX_ENC_KEY_SIZE;
> -		req->init_key_dist = dist_keys;
> +		req->init_key_dist = all_keys;
>  		req->resp_key_dist = dist_keys;
>  		req->auth_req = authreq;
>  		return;
> @@ -214,7 +237,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
>  	rsp->io_capability = conn->hcon->io_capability;
>  	rsp->oob_flag = SMP_OOB_NOT_PRESENT;
>  	rsp->max_key_size = SMP_MAX_ENC_KEY_SIZE;
> -	rsp->init_key_dist = req->init_key_dist & dist_keys;
> +	rsp->init_key_dist = req->init_key_dist & all_keys;

all_keys is always zero. What's the purpose of create it?

	Gustavo
