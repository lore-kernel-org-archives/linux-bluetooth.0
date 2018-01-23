Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Bluetooth: btintel: Use boot parameter from firmware file
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1516671224.15252.6.camel@linux.intel.com>
Date: Tue, 23 Jan 2018 13:02:17 +0100
Cc: linux-bluetooth@vger.kernel.org, amit.k.bag@intel.com,
        tedd.an@intel.com
Message-Id: <C08E4B04-ACB7-42F2-8ACB-3C437785A1A0@holtmann.org>
References: <1516671224.15252.6.camel@linux.intel.com>
To: Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> Each RAM SKU has a different boot parameter which is used in
> HCI_Intel_Reset command after downloading the firmware and
> it is embedded in the firmware data. In order to support multiple
> SKU, instead of using a static value per SKU, driver can read
> the boot parameter from the firmware data and use it.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  drivers/bluetooth/btintel.c   | 21 +++++++++++++++++++++
>  drivers/bluetooth/btintel.h   | 21 +++++++++++++++++++++
>  drivers/bluetooth/btusb.c     | 31 +++++++++++++++++++++++--------
>  drivers/bluetooth/hci_intel.c | 31 +++++++++++++++++++++++--------
>  4 files changed, 88 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 07f00e4..236baf1 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -569,6 +569,27 @@ struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
>  }
>  EXPORT_SYMBOL_GPL(btintel_regmap_init);
>  
> +int btintel_send_intel_reset(struct hci_dev *hdev, u8 type, u8 opt,
> +			     u32 boot_param)
> +{
> +	struct sk_buff *skb;
> +	struct intel_reset params = { 0x00, 0x01, 0x00, 0x00, 0x00 };
> +
> +	params.reset_type = type;
> +	params.boot_option = opt;
> +	params.boot_param = boot_param;

this combination makes no sense. memset the param or just assign all values, but such an struct initializer is a bad idea.

And also proper endianness handling please.

> +
> +	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(params), &params,
> +			     HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btintel_send_intel_reset);
> +
>  MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
>  MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
>  MODULE_VERSION(VERSION);
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 1e8955a..08afb61 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -69,6 +69,19 @@ struct intel_secure_send_result {
>  	__u8     status;
>  } __packed;
>  
> +struct intel_wr_boot_params {
> +	__u32    boot_param;
> +	__u8     reserved[3];
> +} __packed;
> +
> +struct intel_reset {
> +	__u8     reset_type;
> +	__u8     patch_enable;
> +	__u8     ddc_reload;
> +	__u8     boot_option;;
> +	__u32    boot_param;
> +} __packed;
> +
>  #if IS_ENABLED(CONFIG_BT_INTEL)
>  
>  int btintel_check_bdaddr(struct hci_dev *hdev);
> @@ -89,6 +102,8 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver);
>  
>  struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
>  				   u16 opcode_write);
> +int btintel_send_intel_reset(struct hci_dev *hdev, u8 type, u8 opt,
> +			     u32 boot_param);
>  
>  #else
>  
> @@ -165,4 +180,10 @@ static inline struct regmap *btintel_regmap_init(struct hci_dev *hdev,
>  {
>  	return ERR_PTR(-EINVAL);
>  }
> +
> +static inline int btintel_send_intel_reset(struct hci_dev *hdev, u8 type,
> +					   u8 opt, u32 reset_param)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 29977eb..e78fb41 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2009,8 +2009,6 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  static int btusb_setup_intel_new(struct hci_dev *hdev)
>  {
> -	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
> -					  0x00, 0x08, 0x04, 0x00 };
>  	struct btusb_data *data = hci_get_drvdata(hdev);
>  	struct sk_buff *skb;
>  	struct intel_version ver;
> @@ -2018,6 +2016,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>  	const struct firmware *fw;
>  	const u8 *fw_ptr;
>  	u32 frag_len;
> +	u32 boot_param;
>  	char fwname[64];
>  	ktime_t calltime, delta, rettime;
>  	unsigned long long duration;
> @@ -2025,6 +2024,8 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>  
>  	BT_DBG("%s", hdev->name);
>  
> +	boot_param = 0x0;
> +
>  	calltime = ktime_get();
>  
>  	/* Read the Intel version information to determine if the device
> @@ -2267,6 +2268,20 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>  	while (fw_ptr - fw->data < fw->size) {
>  		struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
>  
> +		/* Each SKU has a different reset parameter to use in the
> +		 * HCI_Intel_Reset command and it is embedded in the firmware
> +		 * data. So, instead of using static value per SKU, check
> +		 * the firmware data and save it for later use.
> +		 */
> +		if (cmd->opcode == 0xfc0e) {
> +			struct intel_wr_boot_params *boot_params =
> +					(void *)(fw_ptr + sizeof(*cmd));

In this case it might be simpler to just use get_unaligned_le32 and comment that the first 32-bit value is the boot params and the other 3 octets are reserved.

> +
> +			boot_param = boot_params->boot_param;
> +			bt_dev_dbg(hdev, "%s: boot_param=0x%x", __func__,

No the __func__ stuff please. That is already present in dynamic debug if you want it to be printed.

> +				   boot_param);
> +		}
> +
>  		frag_len += sizeof(*cmd) + cmd->plen;
>  
>  		/* The parameter length of the secure send command requires
> @@ -2341,12 +2356,12 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>  
>  	set_bit(BTUSB_BOOTING, &data->flags);
>  
> -	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(reset_param), reset_param,
> -			     HCI_INIT_TIMEOUT);
> -	if (IS_ERR(skb))
> -		return PTR_ERR(skb);
> -
> -	kfree_skb(skb);
> +	err = btintel_send_intel_reset(hdev, 0x00, 0x01, boot_param);
> +	if (err < 0) {
> +		BT_ERR("%s: Failed to send Intel Reset (%d)",
> +		       hdev->name, err);
> +		goto done;
> +	}
>  
>  	/* The bootloader will not indicate when the device is ready. This
>  	 * is done by the operational firmware sending bootup notification.
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index a3a4ea8..95314a9 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -540,8 +540,6 @@ static int intel_set_baudrate(struct hci_uart *hu, unsigned int speed)
>  
>  static int intel_setup(struct hci_uart *hu)
>  {
> -	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
> -					  0x00, 0x08, 0x04, 0x00 };
>  	struct intel_data *intel = hu->priv;
>  	struct hci_dev *hdev = hu->hdev;
>  	struct sk_buff *skb;
> @@ -552,6 +550,7 @@ static int intel_setup(struct hci_uart *hu)
>  	const u8 *fw_ptr;
>  	char fwname[64];
>  	u32 frag_len;
> +	u32 boot_param;
>  	ktime_t calltime, delta, rettime;
>  	unsigned long long duration;
>  	unsigned int init_speed, oper_speed;
> @@ -563,6 +562,8 @@ static int intel_setup(struct hci_uart *hu)
>  	hu->hdev->set_diag = btintel_set_diag;
>  	hu->hdev->set_bdaddr = btintel_set_bdaddr;
>  
> +	boot_param = 0x0;
> +

I prefer using 0x00000000 here and also adding a comment why zero is used as default.

>  	calltime = ktime_get();
>  
>  	if (hu->init_speed)
> @@ -822,6 +823,20 @@ static int intel_setup(struct hci_uart *hu)
>  	while (fw_ptr - fw->data < fw->size) {
>  		struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
>  
> +		/* Each SKU has a different reset parameter to use in the
> +		 * HCI_Intel_Reset command and it is embedded in the firmware
> +		 * data. So, instead of using static value per SKU, check
> +		 * the firmware data and save it for later use.
> +		 */
> +		if (cmd->opcode == 0xfc0e) {
> +			struct intel_wr_boot_params *boot_params =
> +					(void *)(fw_ptr + sizeof(*cmd));
> +

Same as above.

> +			boot_param = boot_params->boot_param;
> +			bt_dev_dbg(hdev, "%s: boot_param=0x%x", __func__,
> +				   boot_param);
> +		}
> +
>  		frag_len += sizeof(*cmd) + cmd->plen;
>  
>  		bt_dev_dbg(hdev, "Patching %td/%zu", (fw_ptr - fw->data),
> @@ -911,12 +926,12 @@ static int intel_setup(struct hci_uart *hu)
>  
>  	set_bit(STATE_BOOTING, &intel->flags);
>  
> -	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(reset_param), reset_param,
> -			     HCI_CMD_TIMEOUT);
> -	if (IS_ERR(skb))
> -		return PTR_ERR(skb);
> -
> -	kfree_skb(skb);
> +	err = btintel_send_intel_reset(hdev, 0x00, 0x01, boot_param);
> +	if (err < 0) {
> +		BT_ERR("%s: Failed to send Intel Reset (%d)",
> +		       hdev->name, err);
> +		goto done;
> +	}
>  

I would also have converted the current into using btintel_send_intel_reset() first and then handle the boot param extraction. So turned this into two patches. One is really just refactoring into a common function and does not need to change any functional behavior.

Regards

Marcel

