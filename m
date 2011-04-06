Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Apr 2011 16:18:56 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [bluetooth-next 13/15] Bluetooth: Add support for Pairing
 features exchange
Message-ID: <20110406191856.GB2228@joana>
References: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
 <1302054716-24534-14-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1302054716-24534-14-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinícius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-04-05 22:51:54 -0300]:

> This patch implements a simple version of the SMP Pairing Features
> exchange procedure (Vol. 3 Part H, Section 2.3.5.1).
> 
> For now, everything that would cause a Pairing Method different of
> Just Works to be chosen is rejected.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |    1 +
>  net/bluetooth/smp.c       |  117 ++++++++++++++++++++++++--------------------
>  2 files changed, 65 insertions(+), 53 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index aa0d013..e40ce9a 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1555,6 +1555,7 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
>  				/* Encryption implies authentication */
>  				conn->link_mode |= HCI_LM_AUTH;
>  				conn->link_mode |= HCI_LM_ENCRYPT;
> +				conn->sec_level = conn->pending_sec_level;
>  			} else
>  				conn->link_mode &= ~HCI_LM_ENCRYPT;
>  		}
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 2724b70..b6f52ab 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -186,7 +186,30 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
>  	hci_send_acl(conn->hcon, skb, 0);
>  }
>  
> -static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
> +static __u8 seclevel_to_authreq(__u8 level)
> +{
> +	switch (level) {
> +	case BT_SECURITY_HIGH:
> +		/* Right now we don't support bonding */
> +		return SMP_AUTH_MITM;
> +
> +	default:
> +		return SMP_AUTH_NONE;
> +	}
> +}
> +
> +static void build_pairing_cmd(struct l2cap_conn *conn,
> +				struct smp_cmd_pairing *cmd, __u8 authreq)
> +{
> +	cmd->io_capability = SMP_IO_NO_INPUT_OUTPUT;
> +	cmd->oob_flag = SMP_OOB_NOT_PRESENT;
> +	cmd->max_key_size = 16;
> +	cmd->init_key_dist = 0x00;
> +	cmd->resp_key_dist = 0x00;
> +	cmd->auth_req = authreq;
> +}
> +

Separate the creation of build_pairing_cmd() in a new commit.

-- 
Gustavo F. Padovan
http://profusion.mobi
