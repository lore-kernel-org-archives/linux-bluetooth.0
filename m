Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] Bluetooth: btusb: ath3k: Decide firmware name before
 checking update status
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170824090629.13381-1-kai.heng.feng@canonical.com>
Date: Thu, 24 Aug 2017 11:14:27 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <C7E5F271-08C2-49E6-9543-AE1DEA355570@holtmann.org>
References: <20170824090629.13381-1-kai.heng.feng@canonical.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kai-Heng,

> Decide firmware name before checking patch update status. Firmware name is
> required for caching.
> 
> Also, version information in btusb_setup_qca() is being calculated twice,
> reduce it to one.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> drivers/bluetooth/ath3k.c | 10 +++----
> drivers/bluetooth/btusb.c | 72 +++++++++++++++++++++++------------------------
> 2 files changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index b793853ff05f..280849dba51e 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -409,11 +409,6 @@ static int ath3k_load_patch(struct usb_device *udev)
> 		return ret;
> 	}
> 
> -	if (fw_state & ATH3K_PATCH_UPDATE) {
> -		BT_DBG("Patch was already downloaded");
> -		return 0;
> -	}
> -
> 	ret = ath3k_get_version(udev, &fw_version);
> 	if (ret < 0) {
> 		BT_ERR("Can't get version to change to load ram patch err");
> @@ -423,6 +418,11 @@ static int ath3k_load_patch(struct usb_device *udev)
> 	snprintf(filename, ATH3K_NAME_LEN, "ar3k/AthrBT_0x%08x.dfu",
> 		 le32_to_cpu(fw_version.rom_version));
> 
> +	if (fw_state & ATH3K_PATCH_UPDATE) {
> +		BT_DBG("Patch was already downloaded");
> +		return 0;
> +	}
> +
> 	ret = request_firmware(&firmware, filename, &udev->dev);
> 	if (ret < 0) {
> 		BT_ERR("Patch file not found %s", filename);
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index fa24d693af24..732fe6c3e789 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1518,18 +1518,12 @@ static int btusb_setup_csr(struct hci_dev *hdev)
> }
> 
> static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
> -						       struct intel_version *ver)
> +						       const char *fwname,
> +						       const char *default_fwname)
> {
> 	const struct firmware *fw;
> -	char fwname[64];
> 	int ret;
> 
> -	snprintf(fwname, sizeof(fwname),
> -		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.bseq",
> -		 ver->hw_platform, ver->hw_variant, ver->hw_revision,
> -		 ver->fw_variant,  ver->fw_revision, ver->fw_build_num,
> -		 ver->fw_build_ww, ver->fw_build_yy);
> -
> 	ret = request_firmware(&fw, fwname, &hdev->dev);
> 	if (ret < 0) {
> 		if (ret == -EINVAL) {
> @@ -1544,11 +1538,9 @@ static const struct firmware *btusb_setup_intel_get_fw(struct hci_dev *hdev,
> 		/* If the correct firmware patch file is not found, use the
> 		 * default firmware patch file instead
> 		 */
> -		snprintf(fwname, sizeof(fwname), "intel/ibt-hw-%x.%x.bseq",
> -			 ver->hw_platform, ver->hw_variant);
> -		if (request_firmware(&fw, fwname, &hdev->dev) < 0) {
> +		if (request_firmware(&fw, default_fwname, &hdev->dev) < 0) {
> 			BT_ERR("%s failed to open default Intel fw file: %s",
> -			       hdev->name, fwname);
> +			       hdev->name, default_fwname);
> 			return NULL;
> 		}
> 	}
> @@ -1676,6 +1668,8 @@ static int btusb_setup_intel_patching(struct hci_dev *hdev,
> static int btusb_setup_intel(struct hci_dev *hdev)
> {
> 	struct sk_buff *skb;
> +	char fwname[64];
> +	char default_fwname[64];
> 	const struct firmware *fw;
> 	const u8 *fw_ptr;
> 	int disable_patch, err;
> @@ -1714,6 +1708,15 @@ static int btusb_setup_intel(struct hci_dev *hdev)
> 		ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
> 		ver.fw_build_ww, ver.fw_build_yy, ver.fw_patch_num);
> 
> +	snprintf(fwname, sizeof(fwname),
> +		 "intel/ibt-hw-%x.%x.%x-fw-%x.%x.%x.%x.%x.bseq",
> +		 ver.hw_platform, ver.hw_variant, ver.hw_revision,
> +		 ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
> +		 ver.fw_build_ww, ver.fw_build_yy);
> +
> +	snprintf(default_fwname, sizeof(default_fwname),
> +		"intel/ibt-hw-%x.%x.bseq", ver.hw_platform, ver.hw_variant);
> +

this doesn’t belong in this patch since it is about Intel hardware and not Qualcomm hardware. Split this out if it is needed.

Regards

Marcel
