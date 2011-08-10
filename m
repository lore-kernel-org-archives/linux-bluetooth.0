Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 09/16] Bluetooth: Prepare for full support discovery
 procedures
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Aug 2011 06:48:10 -0700
In-Reply-To: <1311623405-31108-10-git-send-email-andre.guedes@openbossa.org>
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
	 <1311623405-31108-10-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1312984092.3373.116.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch prepares start_discovery() to support LE-Only and BR/EDR/LE
> devices discovery procedures (BR/EDR devices are already supported).
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci.h      |    1 +
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/mgmt.c             |   37 ++++++++++++++++++++++++++++++++++++-
>  3 files changed, 38 insertions(+), 1 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index be30aab..653daec 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -202,6 +202,7 @@ enum {
>  
>  #define LMP_EV4		0x01
>  #define LMP_EV5		0x02
> +#define LMP_NO_BREDR	0x20
>  #define LMP_LE		0x40
>  
>  #define LMP_SNIFF_SUBR	0x02
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 1ff59f2..0d2e703 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -597,6 +597,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>  #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
>  #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
>  #define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
> +#define lmp_bredr_capable(dev)     (!((dev)->features[4] & LMP_NO_BREDR))

I don't think this is a good idea. You keep forgetting if you actually
have LE switched on or not.

I think we should keep it like this and just keep a global hci_dev state
which discovery procedure to use. Depending on if the device is just
really LE-Only, it is dual-stack, but LE got switched off (we will need
this eventually for testing) or it is just only BR/EDR.

>  #define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
>  
>  /* ----- Extended LMP capabilities ----- */
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index bbb0daa..dcfb466 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -32,6 +32,15 @@
>  #define MGMT_VERSION	0
>  #define MGMT_REVISION	1
>  
> +enum bt_device_type {
> +	BREDR_ONLY,
> +	LE_ONLY,
> +	BREDR_LE,
> +	UNKNOWN,
> +};

What is this for? We essentially have a local device capabilities and an
operation mode. They are both different. We do not have a device type.

> +
> +#define BREDR_ONLY_INQ_LENGTH 0x08 /* TGAP(100) */
> +
>  struct pending_cmd {
>  	struct list_head list;
>  	__u16 opcode;
> @@ -1628,10 +1637,23 @@ static int do_inquiry(struct hci_dev *hdev, __u8 inq_length)
>  	return hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
>  }
>  
> +static int get_device_type(struct hci_dev *hdev)
> +{
> +	if (lmp_bredr_capable(hdev) && lmp_host_le_capable(hdev))
> +		return BREDR_LE;
> +	else if (lmp_host_le_capable(hdev))
> +		return LE_ONLY;
> +	else if (lmp_bredr_capable(hdev))
> +		return BREDR_ONLY;
> +	else
> +		return UNKNOWN;
> +}
> +
>  static int start_discovery(struct sock *sk, u16 index)
>  {
>  	struct pending_cmd *cmd;
>  	struct hci_dev *hdev;
> +	int dev_type;
>  	int err;
>  
>  	BT_DBG("hci%u", index);
> @@ -1654,7 +1676,20 @@ static int start_discovery(struct sock *sk, u16 index)
>  		goto failed;
>  	}
>  
> -	err = do_inquiry(hdev, 0x08);
> +	dev_type = get_device_type(hdev);
> +
> +	switch (dev_type) {
> +	case BREDR_ONLY:
> +		err = do_inquiry(hdev, BREDR_ONLY_INQ_LENGTH);
> +		break;
> +	case LE_ONLY:
> +	case BREDR_LE:
> +		err = -ENOSYS;
> +		break;
> +	default:
> +		err = -EINVAL;
> +	}
> +
>  	if (err < 0)
>  		mgmt_pending_remove(cmd);
>  

As I said, device type is fundamentally wrong approach. You need to go
for operation mode here.

Regards

Marcel


