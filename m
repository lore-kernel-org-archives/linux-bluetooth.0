Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 1/2] Bluetooth: btintel: Add Device Configuration support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441380472-30636-1-git-send-email-loic.poulain@intel.com>
Date: Fri, 4 Sep 2015 08:36:43 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BE433F9D-8CEB-459D-B701-F65BAEB8129E@holtmann.org>
References: <1441380472-30636-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> btintel_ddc_send retrieves the ddc file and sends its content via DDC
> commands (opcode 0xfc8b).
> 
> The ddc file should contain one or more DDC structures.
> A DDC structure is composed of the folowing fields:
> field: | DDC LEN |    DDC ID    |   DDC VALUE   |
> size:  | 1 byte  |    2 bytes   |  DDC LEN - 2  |
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/btintel.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btintel.h |  6 ++++++
> 2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 048423f..6447fc9 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -22,6 +22,7 @@
>  */
> 
> #include <linux/module.h>
> +#include <linux/firmware.h>
> 
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> @@ -169,6 +170,51 @@ int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
> }
> EXPORT_SYMBOL_GPL(btintel_secure_send);
> 
> +int btintel_ddc_send(struct hci_dev *hdev, const char *ddc_name)
> +{

lets not name this btintel_ddc_send. The secure_send was named this way, because that is the name of the underlying HCI command. I think what you want here is btintel_load_ddc_config.


> +	const struct firmware *fw;
> +	struct sk_buff *skb;
> +	const u8 *fw_ptr;
> +	int err;
> +
> +	err = request_firmware_direct(&fw, ddc_name, &hdev->dev);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to load Intel DDC file %s (%d)",
> +			   ddc_name, err);
> +		return err;
> +	}
> +
> +	bt_dev_info(hdev, "Found Intel DDC parameters: %s", ddc_name);
> +
> +	fw_ptr = fw->data;
> +
> +	/* DDC file contains one or more DDC structure which has
> +	 * Length (1 byte), DDC ID (2 bytes), and DDC value (Length - 2).
> +	 */
> +	while (fw->size > fw_ptr - fw->data) {
> +		u8 cmd_plen = fw_ptr[0] + sizeof(u8);
> +
> +		skb = __hci_cmd_sync(hdev, 0xfc8b, cmd_plen, fw_ptr,
> +				     HCI_INIT_TIMEOUT);
> +		if (IS_ERR(skb)) {
> +			bt_dev_err(hdev, "Failed to send Intel_Write_DDC (%ld)",
> +				   PTR_ERR(skb));
> +			release_firmware(fw);
> +			return PTR_ERR(skb);
> +		}
> +
> +		fw_ptr += cmd_plen;
> +		kfree_skb(skb);
> +	}
> +
> +	release_firmware(fw);
> +
> +	bt_dev_info(hdev, "Applying Intel DDC parameters completed");
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btintel_ddc_send);
> +
> MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
> MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
> MODULE_VERSION(VERSION);
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index b278d14..85d2c29 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -78,6 +78,7 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code);
> void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
> int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
> 			const void *param);
> +int btintel_ddc_send(struct hci_dev *hdev, const char *ddc_name);
> 
> #else
> 
> @@ -105,4 +106,9 @@ static inline int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type,
> 	return -EOPNOTSUPP;
> }
> 
> +static inline int btintel_ddc_send(struct hci_dev *hdev, const char *ddc_name)
> +{
> +	return -EOPNOTSUPP
> +}

Regards

Marcel

