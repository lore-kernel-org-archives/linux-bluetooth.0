Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Oct 2010 11:03:56 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH 3/6] Bluetooth: Implement the first SMP commands
Message-ID: <20101025130356.GA8862@vigoh>
References: <linux-bluetooth@vger.kernel.org>
 <1287791820-22693-4-git-send-email-anderson.briglia@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287791820-22693-4-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Anderson Briglia <anderson.briglia@openbossa.org> [2010-10-22 19:56:57 -0400]:

> From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> 
> These simple commands will allow the SMP procedure to be started
> and terminated with a not supported error. This is the first step
> toward something useful.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/l2cap.c |  117 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 117 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 1ac44f4..ba87c84 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -54,6 +54,7 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>  #include <net/bluetooth/l2cap.h>
> +#include <net/bluetooth/smp.h>
>  
>  #define VERSION "2.15"
>  
> @@ -307,6 +308,85 @@ static void l2cap_chan_del(struct sock *sk, int err)
>  	}
>  }
>  
> +static struct sk_buff *smp_build_cmd(struct l2cap_conn *conn, u8 code,
> +							u16 dlen, void *data)

Call this l2cap_smp_build_cmd()

> +{
> +	struct sk_buff *skb;
> +	struct l2cap_hdr *lh;
> +	int len;
> +
> +	len = L2CAP_HDR_SIZE + 1 + dlen;
> +
> +	if (len > conn->mtu)
> +		return NULL;
> +
> +	skb = bt_skb_alloc(len, GFP_ATOMIC);
> +	if (!skb)
> +		return NULL;
> +
> +	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
> +	lh->len = cpu_to_le16(1 + dlen);

cpu_to_le16(len - L2CAP_HDR_SIZE) here

> +	lh->cid = cpu_to_le16(L2CAP_CID_SMP);
> +
> +	memcpy(skb_put(skb, 1), &code, 1);
> +
> +	memcpy(skb_put(skb, dlen), data, dlen);
> +
> +	return skb;
> +}
> +
> +static inline void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)

and this l2cap_smp_send_cmd.

> +{
> +	struct sk_buff *skb = smp_build_cmd(conn, code, len, data);
> +
> +	BT_DBG("code 0x%2.2x", code);
> +
> +	if (!skb)
> +		return;
> +
> +	hci_send_acl(conn->hcon, skb, 0);
> +}
> +
> +static int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
> +{


l2cap_smp_conn_security() here.

> +	__u8 authreq;
> +
> +	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, conn->hcon, sec_level);
> +
> +	switch (sec_level) {
> +	case BT_SECURITY_MEDIUM:
> +		/* Encrypted, no MITM protection */
> +		authreq = 0x01;
> +		break;
> +
> +	case BT_SECURITY_HIGH:
> +		/* Bonding, MITM protection */
> +		authreq = 0x05;
> +		break;
> +
> +	case BT_SECURITY_LOW:
> +	default:
> +		return 1;
> +	}
> +
> +	if (conn->hcon->link_mode & HCI_LM_MASTER) {
> +		struct smp_cmd_pairing cp;
> +		cp.io_capability = 0x00;
> +		cp.oob_flag = 0x00;
> +		cp.max_key_size = 16;
> +		cp.init_key_dist = 0x00;
> +		cp.resp_key_dist = 0x00;
> +		cp.auth_req = authreq;
> +		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
> +	} else {
> +		struct smp_cmd_security_req cp;
> +		cp.auth_req = authreq;
> +		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
> +	}
> +
> +	return 0;
> +}
> +
>  /* Service level security */
>  static inline int l2cap_check_security(struct sock *sk)
>  {
> @@ -4562,6 +4642,43 @@ done:
>  	return 0;
>  }
>  
> +static inline void smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)

l2cap_smp_sig_channel()

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
