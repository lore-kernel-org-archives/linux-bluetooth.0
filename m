Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Dec 2011 12:16:08 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/8] Bluetooth: Add structures for the new LTK exchange
 messages
Message-ID: <20111212151608.GA10459@samus>
References: <1323218892-15785-1-git-send-email-vinicius.gomes@openbossa.org>
 <1323218892-15785-2-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323218892-15785-2-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 21:48 Tue 06 Dec, Vinicius Costa Gomes wrote:
> This defines two in the kernel side of BlueZ two new messages, one
> event that will inform userspace that a new Long Term Key was
> exchanged and one that will allow userspace to load LTKs into
> the kernel.
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/mgmt.h |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 3b68806..0f100fa9 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -264,6 +264,21 @@ struct mgmt_cp_user_passkey_neg_reply {
>  	bdaddr_t bdaddr;
>  } __packed;
>  
> +struct mgmt_ltk_info {
> +	bdaddr_t bdaddr;
> +	__u8 pin_len;
> +	__u8 enc_size;
> +	__le16 ediv;
> +	__u8 rand[8];
> +	__u8 val[16];
> +} __packed;

As per a discussion on IRC right now, I will change this to include
authenticated/unauthenticated information and remove pin_len.

Please ignore this series.

> +
> +#define MGMT_OP_LOAD_LONG_TERM_KEYS	0x0023
> +struct mgmt_cp_load_long_term_keys {
> +	__u16 key_count;
> +	struct mgmt_ltk_info keys[0];
> +} __packed;
> +
>  #define MGMT_EV_CMD_COMPLETE		0x0001
>  struct mgmt_ev_cmd_complete {
>  	__le16 opcode;
> @@ -363,3 +378,9 @@ struct mgmt_ev_device_unblocked {
>  struct mgmt_ev_user_passkey_request {
>  	bdaddr_t bdaddr;
>  } __packed;
> +
> +#define MGMT_EV_NEW_LONG_TERM_KEY	0x0018
> +struct mgmt_ev_new_long_term_key {
> +	__u8 store_hint;
> +	struct mgmt_ltk_info key;
> +} __packed;
> -- 
> 1.7.8
> 

Cheers,
-- 
Vinicius
