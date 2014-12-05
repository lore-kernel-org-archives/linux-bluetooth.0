Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [RFC 1/3] Bluetooth: Refactor Intel read version command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20141203170928.5f55df90@tedd-test>
Date: Fri, 5 Dec 2014 12:16:15 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <8319DC41-AB56-4D32-9A87-CCE3B96C4552@holtmann.org>
References: <20141203170928.5f55df90@tedd-test>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch refactors the routine that read the device firmware version
> with Intel_Read_Version command.
> This command and event are common to all Intel Bluetooth device.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btusb.c | 68
> +++++++++++++++++++++++++++-------------------- 1 file changed, 39
> insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 31dd24a..d88faab 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1490,13 +1490,40 @@ static int btusb_check_bdaddr_intel(struct
> hci_dev *hdev) return 0;
> }
> 
> +static int btusb_setup_intel_read_fw_ver(struct hci_dev *hdev,
> +					 struct intel_version *ver)
> +{
> +	struct sk_buff *skb;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s reading Intel fw version command failed
> (%ld)",
> +		       hdev->name, PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->len != sizeof(*ver)) {
> +		BT_ERR("%s Intel version event length mismatch",
> hdev->name);
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	memcpy(ver, skb->data, sizeof(*ver));
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +
> static int btusb_setup_intel(struct hci_dev *hdev)
> {
> 	struct sk_buff *skb;
> 	const struct firmware *fw;
> 	const u8 *fw_ptr;
> 	int disable_patch;
> -	struct intel_version *ver;
> +	struct intel_version ver;
> +	int err;
> 
> 	const u8 mfg_enable[] = { 0x01, 0x00 };
> 	const u8 mfg_disable[] = { 0x00, 0x00 };
> @@ -1527,41 +1554,25 @@ static int btusb_setup_intel(struct hci_dev
> *hdev)
> 	 * The returned information are hardware variant and revision
> plus
> 	 * firmware variant, revision and build number.
> 	 */
> -	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
> -	if (IS_ERR(skb)) {
> -		BT_ERR("%s reading Intel fw version command failed
> (%ld)",
> -		       hdev->name, PTR_ERR(skb));
> -		return PTR_ERR(skb);
> -	}
> -
> -	if (skb->len != sizeof(*ver)) {
> -		BT_ERR("%s Intel version event length mismatch",
> hdev->name);
> -		kfree_skb(skb);
> -		return -EIO;
> -	}
> -
> -	ver = (struct intel_version *)skb->data;
> -	if (ver->status) {
> -		BT_ERR("%s Intel fw version event failed (%02x)",
> hdev->name,
> -		       ver->status);
> -		kfree_skb(skb);
> -		return -bt_to_errno(ver->status);
> +	err = btusb_setup_intel_read_fw_ver(hdev, &ver);
> +	if (err < 0) {
> +		BT_ERR("%s: failed to read fw version (%d)",
> hdev->name, err);
> +		return err;
> 	}
> 
> 	BT_INFO("%s: read Intel version:
> %02x%02x%02x%02x%02x%02x%02x%02x%02x",
> -		hdev->name, ver->hw_platform, ver->hw_variant,
> -		ver->hw_revision, ver->fw_variant,  ver->fw_revision,
> -		ver->fw_build_num, ver->fw_build_ww, ver->fw_build_yy,
> -		ver->fw_patch_num);
> +		hdev->name, ver.hw_platform, ver.hw_variant,
> +		ver.hw_revision, ver.fw_variant,  ver.fw_revision,
> +		ver.fw_build_num, ver.fw_build_ww, ver.fw_build_yy,
> +		ver.fw_patch_num);
> 
> 	/* fw_patch_num indicates the version of patch the device
> currently
> 	 * have. If there is no patch data in the device, it is always
> 0x00.
> 	 * So, if it is other than 0x00, no need to patch the deivce
> again. */
> -	if (ver->fw_patch_num) {
> +	if (ver.fw_patch_num) {
> 		BT_INFO("%s: Intel device is already patched. patch
> num: %02x",
> -			hdev->name, ver->fw_patch_num);
> -		kfree_skb(skb);
> +			hdev->name, ver.fw_patch_num);
> 		btusb_check_bdaddr_intel(hdev);
> 		return 0;
> 	}
> @@ -1572,9 +1583,8 @@ static int btusb_setup_intel(struct hci_dev *hdev)
> 	 * If no patch file is found, allow the device to operate
> without
> 	 * a patch.
> 	 */
> -	fw = btusb_setup_intel_get_fw(hdev, ver);
> +	fw = btusb_setup_intel_get_fw(hdev, &ver);
> 	if (!fw) {
> -		kfree_skb(skb);
> 		btusb_check_bdaddr_intel(hdev);
> 		return 0;
> 	}

I went through the code and looked at the end result. I do not like it.

My thinking is that what you actually are looking for is to change btusb_setup_intel_get_fw to run the Intel version command and make all the calls and printouts by itself and then load the right firmware. This means the input to that command only be hdev and with your second patch then the firmware suffix.

However we do not to talk a bit about that actually. Since the newer models load complete firmware, the only thing that matters there is the hw_ details. All the sw_ fields are irrelevant. They are only important for ROM patching, but not for a full firmware download. So maybe instead of a firmware filename suffix, we just use an enum to inform about the type of firmware we are looking for.

Regards

Marcel

