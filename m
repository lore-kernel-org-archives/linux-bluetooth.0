Return-Path: <cyrus@holtmann.org>
Message-ID: <4F1095F1.40801@codeaurora.org>
Date: Fri, 13 Jan 2012 12:37:05 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/8] Bluetooth: Add structures for the new LTK exchange
 messages
References: <1326483580-11243-1-git-send-email-vinicius.gomes@openbossa.org> <1326483580-11243-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1326483580-11243-2-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On 1/13/2012 11:39 AM, Vinicius Costa Gomes wrote:
> This defines two new messages, one event that will inform
> userspace that a new Long Term Key was exchanged and one that
> will allow userspace to load LTKs into the kernel.
>
> Acked-by: Marcel Holtmann<marcel@holtmann.org>
> Signed-off-by: Vinicius Costa Gomes<vinicius.gomes@openbossa.org>
> ---
>   include/net/bluetooth/mgmt.h |   22 ++++++++++++++++++++++
>   1 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index be65d34..994b551 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -288,6 +288,22 @@ struct mgmt_cp_unblock_device {
>   	bdaddr_t bdaddr;
>   } __packed;
>
> +struct mgmt_ltk_info {
> +	struct mgmt_addr_info addr;
> +	__u8 authenticated;
> +	__u8 master;
> +	__u8 enc_size;
> +	__le16 ediv;
> +	__u8 rand[8];
> +	__u8 val[16];
> +} __packed;
> +
> +#define MGMT_OP_LOAD_LONG_TERM_KEYS	0x0026
> +struct mgmt_cp_load_long_term_keys {
> +	__u16 key_count;
> +	struct mgmt_ltk_info keys[0];
> +} __packed;
> +

I think all multi-octet values should be going over the MGMT interface 
in "network order", so shouldn't key_count here be __le16 ?




>   #define MGMT_EV_CMD_COMPLETE		0x0001
>   struct mgmt_ev_cmd_complete {
>   	__le16 opcode;
> @@ -388,3 +404,9 @@ struct mgmt_ev_device_blocked {
>   struct mgmt_ev_device_unblocked {
>   	bdaddr_t bdaddr;
>   } __packed;
> +
> +#define MGMT_EV_NEW_LONG_TERM_KEY	0x0016
> +struct mgmt_ev_new_long_term_key {
> +	__u8 store_hint;
> +	struct mgmt_ltk_info key;
> +} __packed;


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
