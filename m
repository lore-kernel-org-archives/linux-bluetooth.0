Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Mar 2011 15:26:26 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v2 4/4] Bluetooth: Add add/remove_remote_oob_data
 management commands
Message-ID: <20110317182626.GD2214@joana>
References: <1299000216-6570-1-git-send-email-szymon.janc@tieto.com>
 <1299000216-6570-5-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299000216-6570-5-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2011-03-01 18:23:36 +0100]:

> This patch adds commands to add and remove remote OOB data to the managment
> interface. Remote data is stored in kernel and used by corresponding HCI
> commands and events (also implemented in this patch) when needed.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  include/net/bluetooth/hci.h      |   19 +++++++++
>  include/net/bluetooth/hci_core.h |   16 ++++++++
>  include/net/bluetooth/mgmt.h     |   12 ++++++
>  net/bluetooth/hci_core.c         |   76 ++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_event.c        |   41 ++++++++++++++++++++-
>  net/bluetooth/mgmt.c             |   75 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 238 insertions(+), 1 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 20840dc..b37ed33 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -426,6 +426,20 @@ struct hci_rp_user_confirm_reply {
>  
>  #define HCI_OP_USER_CONFIRM_NEG_REPLY	0x042d
>  
> +
> +#define HCI_OP_REMOTE_OOB_DATA_REPLY	0x0430
> +struct hci_cp_remote_oob_data_reply {
> +	bdaddr_t bdaddr;
> +	__u8     hash[16];
> +	__u8     randomizer[16];
> +} __packed;
> +
> +#define HCI_OP_REMOTE_OOB_DATA_NEG_REPLY	0x0433
> +struct hci_cp_remote_oob_data_neg_reply {
> +	bdaddr_t bdaddr;
> +} __packed;
> +
> +
>  #define HCI_OP_IO_CAPABILITY_NEG_REPLY	0x0434
>  struct hci_cp_io_capability_neg_reply {
>  	bdaddr_t bdaddr;
> @@ -960,6 +974,11 @@ struct hci_ev_user_confirm_req {
>  	__le32		passkey;
>  } __packed;
>  
> +#define HCI_EV_REMOTE_OOB_DATA_REQUEST	0x35
> +struct hci_ev_remote_oob_data_request {
> +	bdaddr_t bdaddr;
> +} __packed;
> +
>  #define HCI_EV_SIMPLE_PAIR_COMPLETE	0x36
>  struct hci_ev_simple_pair_complete {
>  	__u8     status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index c8b7ee6..0f1e1d6 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -82,6 +82,13 @@ struct link_key {
>  	u8 pin_len;
>  };
>  
> +struct oob_data {
> +	struct list_head list;
> +	bdaddr_t bdaddr;
> +	u8 hash[16];
> +	u8 randomizer[16];
> +};
> +
>  #define NUM_REASSEMBLY 4
>  struct hci_dev {
>  	struct list_head list;
> @@ -169,6 +176,8 @@ struct hci_dev {
>  
>  	struct list_head	link_keys;
>  
> +	struct list_head	remote_oob_data;
> +
>  	struct hci_dev_stats	stat;
>  
>  	struct sk_buff_head	driver_init;
> @@ -505,6 +514,13 @@ int hci_add_link_key(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
>  						u8 *key, u8 type, u8 pin_len);
>  int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
>  
> +int hci_remote_oob_data_clear(struct hci_dev *hdev);
> +struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
> +							bdaddr_t *bdaddr);
> +int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
> +								u8 *randomizer);
> +int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
> +
>  void hci_del_off_timer(struct hci_dev *hdev);
>  
>  void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 916b1c6..ebe288c 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -173,6 +173,18 @@ struct mgmt_rp_read_local_oob_data {
>  	__u8 randomizer[16];
>  } __packed;
>  
> +#define MGMT_OP_ADD_REMOTE_OOB_DATA	0x0018
> +struct mgmt_cp_add_remote_oob_data {
> +	bdaddr_t bdaddr;
> +	__u8 hash[16];
> +	__u8 randomizer[16];
> +} __packed;
> +
> +#define MGMT_OP_REMOVE_REMOTE_OOB_DATA	0x0019
> +struct mgmt_cp_remove_remote_oob_data {
> +	bdaddr_t bdaddr;
> +} __packed;
> +
>  #define MGMT_EV_CMD_COMPLETE		0x0001
>  struct mgmt_ev_cmd_complete {
>  	__le16 opcode;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index b372fb8..a1d2263 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1077,6 +1077,79 @@ static void hci_cmd_timer(unsigned long arg)
>  	tasklet_schedule(&hdev->cmd_task);
>  }
>  
> +struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
> +							bdaddr_t *bdaddr)
> +{
> +	struct list_head *p;
> +
> +	list_for_each(p, &hdev->remote_oob_data) {
> +		struct oob_data *data;
> +
> +		data = list_entry(p, struct oob_data, list);

list_for_each_entry() here.

> +
> +		if (bacmp(bdaddr, &data->bdaddr) == 0)
> +			return data;
> +	}
> +
> +	return NULL;
> +}
> +
> +int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr)
> +{
> +	struct oob_data *data;
> +
> +	data = hci_find_remote_oob_data(hdev, bdaddr);
> +	if (!data)
> +		return -ENOENT;
> +
> +	BT_DBG("%s removing %s", hdev->name, batostr(bdaddr));
> +
> +	list_del(&data->list);
> +	kfree(data);
> +
> +	return 0;
> +}
> +
> +int hci_remote_oob_data_clear(struct hci_dev *hdev)
> +{
> +	struct list_head *p, *n;
> +
> +	list_for_each_safe(p, n, &hdev->remote_oob_data) {

list_for_each_entry_safe() here.


-- 
Gustavo F. Padovan
http://profusion.mobi
