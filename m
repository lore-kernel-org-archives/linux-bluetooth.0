Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Mar 2011 15:18:59 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v2 3/4] Bluetooth: Add read_local_oob_data management
 command
Message-ID: <20110317181859.GC2214@joana>
References: <1299000216-6570-1-git-send-email-szymon.janc@tieto.com>
 <1299000216-6570-4-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299000216-6570-4-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2011-03-01 18:23:35 +0100]:

> This patch adds a command to read local OOB data to the managment interface.
> The command maps directly to the Read Local OOB Data HCI command.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  include/net/bluetooth/hci.h      |    7 +++
>  include/net/bluetooth/hci_core.h |    2 +
>  include/net/bluetooth/mgmt.h     |    6 +++
>  net/bluetooth/hci_event.c        |   15 +++++++
>  net/bluetooth/mgmt.c             |   85 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 115 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index ec6acf2..20840dc 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -611,6 +611,13 @@ struct hci_cp_write_ssp_mode {
>  	__u8     mode;
>  } __packed;
>  
> +#define HCI_OP_READ_LOCAL_OOB_DATA		0x0c57
> +struct hci_rp_read_local_oob_data {
> +	__u8     status;
> +	__u8     hash[16];
> +	__u8     randomizer[16];
> +} __packed;
> +
>  #define HCI_OP_READ_INQ_RSP_TX_POWER	0x0c58
>  
>  #define HCI_OP_READ_LOCAL_VERSION	0x1001
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 441dadb..c8b7ee6 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -767,6 +767,8 @@ int mgmt_user_confirm_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status);
>  int mgmt_user_confirm_neg_reply_complete(u16 index, bdaddr_t *bdaddr,
>  								u8 status);
>  int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status);
> +int mgmt_read_local_oob_data_reply_complete(u16 index, u8 *hash, u8 *randomizer,
> +								u8 status);
>  
>  /* HCI info for socket */
>  #define hci_pi(sk) ((struct hci_pinfo *) sk)
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 5fabfa8..916b1c6 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -167,6 +167,12 @@ struct mgmt_rp_user_confirm_reply {
>  
>  #define MGMT_OP_USER_CONFIRM_NEG_REPLY	0x0016
>  
> +#define MGMT_OP_READ_LOCAL_OOB_DATA	0x0017
> +struct mgmt_rp_read_local_oob_data {
> +	__u8 hash[16];
> +	__u8 randomizer[16];
> +} __packed;
> +
>  #define MGMT_EV_CMD_COMPLETE		0x0001
>  struct mgmt_ev_cmd_complete {
>  	__le16 opcode;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 3fbfa50..4faab87 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -807,6 +807,17 @@ static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
>  								rp->status);
>  }
>  
> +static void hci_cc_read_local_oob_data_reply(struct hci_dev *hdev,
> +							struct sk_buff *skb)
> +{
> +	struct hci_rp_read_local_oob_data *rp = (void *) skb->data;
> +
> +	BT_DBG("%s status 0x%x", hdev->name, rp->status);
> +
> +	mgmt_read_local_oob_data_reply_complete(hdev->id, rp->hash,
> +						rp->randomizer, rp->status);
> +}
> +

This should be after hci_cc_pin_code_neg_reply() and not
hci_cc_user_confirm_reply().


-- 
Gustavo F. Padovan
http://profusion.mobi
