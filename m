Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Andre Guedes <andre.guedes@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v2 9/9] Bluetooth: Support LE-Only discovery procedure
Date: Sun, 27 Nov 2011 06:44:27 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B02641649D@DNCE02.ent.ti.com>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
 <1322265226-6404-10-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1322265226-6404-10-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Andre, 

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Andre Guedes
> Sent: Saturday, November 26, 2011 1:54 AM
> To: linux-bluetooth@vger.kernel.org
> Subject: [PATCH v2 9/9] Bluetooth: Support LE-Only discovery procedure
> 
> This patch adds support for LE-Only discovery procedure through
> management interface.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |   25 ++++++++++++++++++++++---
>  net/bluetooth/mgmt.c      |   31 ++++++++++++++++++++++++++++---
>  2 files changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index b09b5cc..1a51381 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -964,9 +964,6 @@ static void hci_cc_le_set_scan_enable(struct
> hci_dev *hdev,
> 
>  	BT_DBG("%s status 0x%x", hdev->name, status);
> 
> -	if (status)
> -		return;
> -
>  	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
>  	if (!cp)
>  		return;
> @@ -974,17 +971,39 @@ static void hci_cc_le_set_scan_enable(struct
> hci_dev *hdev,
>  	if (cp->enable == 0x01) {
>  		hci_req_complete(hdev, HCI_OP_LE_SET_SCAN_ENABLE, status);
> 
> +		if (status) {
> +			hci_dev_lock(hdev);
> +			mgmt_start_discovery_failed(hdev, status);
> +			hci_dev_unlock(hdev);
> +			return;
> +		}
> +
>  		set_bit(HCI_LE_SCAN, &hdev->dev_flags);
> 
>  		del_timer(&hdev->adv_timer);
> 
>  		hci_dev_lock(hdev);
> +
>  		hci_adv_entries_clear(hdev);
> +
> +		mgmt_discovering(hdev, 1);
> +
>  		hci_dev_unlock(hdev);
>  	} else if (cp->enable == 0x00) {
> +		if (status) {
> +			hci_dev_lock(hdev);
> +			mgmt_stop_discovery_failed(hdev, status);
> +			hci_dev_unlock(hdev);
> +			return;
> +		}
> +
>  		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
> 
>  		mod_timer(&hdev->adv_timer, jiffies + ADV_CLEAR_TIMEOUT);
> +
> +		hci_dev_lock(hdev);
> +		mgmt_discovering(hdev, 0);
> +		hci_dev_unlock(hdev);
>  	}
>  }
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 6a74955..e7e224a 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -33,7 +33,16 @@
>  #define MGMT_VERSION	0
>  #define MGMT_REVISION	1
> 
> -#define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
> +/*
> + * These LE scan and inquiry parameters were chosen according to LE
> General
> + * Discovery Procedure specification.
> + */
> +#define LE_SCAN_TYPE			0x01
> +#define LE_SCAN_WIN			0x12
> +#define LE_SCAN_INT			0x12
> +#define LE_SCAN_TIMEOUT_LE_ONLY		10240	/*
> TGAP(gen_disc_scan_min) */
> +
> +#define INQUIRY_LEN_BREDR		0x08	/* TGAP(100) */
> 
>  struct pending_cmd {
>  	struct list_head list;
> @@ -1824,6 +1833,7 @@ static int start_discovery(struct sock *sk, u16
> index,
>  						unsigned char *data, u16 len)
>  {
>  	struct mgmt_cp_start_discovery *cp = (void *) data;
> +	unsigned long discov_type = cp->type;
>  	struct pending_cmd *cmd;
>  	struct hci_dev *hdev;
>  	int err;
> @@ -1853,7 +1863,16 @@ static int start_discovery(struct sock *sk, u16
> index,
>  		goto failed;
>  	}
> 
> -	err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
> +	if (test_bit(MGMT_ADDR_BREDR, &discov_type))
> +		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
> +	else if (test_bit(MGMT_ADDR_LE_PUBLIC, &discov_type) &&
> +				test_bit(MGMT_ADDR_LE_RANDOM, &discov_type))
> +		err =  hci_do_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
> +					LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
> +	else
> +		err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
> +						MGMT_STATUS_NOT_SUPPORTED);
> +
>  	if (err < 0)
>  		mgmt_pending_remove(cmd);
> 
> @@ -1885,7 +1904,13 @@ static int stop_discovery(struct sock *sk, u16
> index)
>  		goto failed;
>  	}
> 
> -	err = hci_cancel_inquiry(hdev);
> +	if (test_bit(HCI_INQUIRY, &hdev->flags))
> +		err = hci_cancel_inquiry(hdev);
> +	else if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> +		err = hci_cancel_le_scan(hdev);
> +	else
> +		err = -EPERM;
> +
>  	if (err < 0)
>  		mgmt_pending_remove(cmd);
> 
> --
> 1.7.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Do we really need this kind of functionality ? The GAP spec defines how a single mode/dual mode devices should search for devices. In addition, the kernel has all the knowledge required to decide which of the GAP spec device discovery procedures to use, so why bother the bluetoothd with decisions of such kind ? Why create an option for mistake ? If a device is BR/EDR only, mgmt_start_discovery will start discovery of BR/EDR devices. If it is a single mode LE device, the mgmt_start_discovery will start a discovery for LE devices only. If the device is dual mode (BR/EDR/LE) then the mgmt_start_discovery command will do the interleaved scanning as the spec defines. Adding such complexity and allowing the selection of scan methods breaks the meaning of the spec. Why do we need to allow the user to scan for LE devices while in BR/EDR only mode, and return an error ? Why should the user even be aware of such an option ? I thought the whole idea behind the mgmtops (as opposite to hciops) was to encapsulate some logic into basic operations and procedures, and prevent the 1:1 reflection of hci commands. In this case, device discovery is opaque to the user - it will discover the devices as the spec defines, without any irrelevant errors and without too much understanding from the upper layers.

Thanks,
Chen Ganir.
