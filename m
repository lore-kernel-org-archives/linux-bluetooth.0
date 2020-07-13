Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24F1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 19:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F57420738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 19:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGMTO0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:14:26 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59577 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMTO0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 15:14:26 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id CA56CCECCC;
        Mon, 13 Jul 2020 21:24:21 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 1/5] Bluetooth: btintel: Make controller version read
 generic
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200703071212.17046-1-kiran.k@intel.com>
Date:   Mon, 13 Jul 2020 21:14:23 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        kiraank@gmail.com, Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <21E18541-08DD-4340-9E58-212FA126ADFA@holtmann.org>
References: <20200703071212.17046-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Make controller read vesion function more generic to support different
> type of controllers.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> 
> Changes in v2: None
> Changes in v1:
> - Make controller read version function generic
> 
> drivers/bluetooth/btintel.c   | 36 ++++++++++++++----
> drivers/bluetooth/btintel.h   | 15 ++++++--
> drivers/bluetooth/btusb.c     | 71 +++++++++++++++++++++++------------
> drivers/bluetooth/hci_ag6xx.c | 12 +++++-
> drivers/bluetooth/hci_intel.c | 12 +++++-
> 5 files changed, 106 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 5fa5be3c5598..dea96c585ecb 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -204,9 +204,15 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
> }
> EXPORT_SYMBOL_GPL(btintel_hw_error);
> 
> -void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
> +void btintel_version_info(struct hci_dev *hdev, const struct btintel_version *version)
> {

so I am not fully on board with the new btintel_version struct and using it as union. Maybe it is better the function just returns allocated memory and a type indicator. I need to let this stew a little bit.

> 	const char *variant;
> +	const struct intel_version *ver;
> +
> +	if (version->is_tlv_supported)
> +		return;
> +
> +	ver = &version->intel_version;
> 
> 	switch (ver->fw_variant) {
> 	case 0x06:
> @@ -335,27 +341,41 @@ int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug)
> }
> EXPORT_SYMBOL_GPL(btintel_set_event_mask_mfg);
> 
> -int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
> +int btintel_read_version(struct hci_dev *hdev, struct btintel_version *version)
> {
> 	struct sk_buff *skb;

	const u8 param[1] = 0xff;

> +	u8 *data, param, status, check_tlv;
> +
> +	if (!version)
> +		return -EINVAL;
> 
> -	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
> +	param = 0xFF;
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc05, 1, &param, HCI_CMD_TIMEOUT);
> 	if (IS_ERR(skb)) {
> 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
> 			   PTR_ERR(skb));
> 		return PTR_ERR(skb);
> 	}
> 
> -	if (skb->len != sizeof(*ver)) {
> -		bt_dev_err(hdev, "Intel version event size mismatch");
> +	data = skb->data;
> +	status = *data;
> +	if (status) {
> +		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
> +			   status);
> 		kfree_skb(skb);
> -		return -EILSEQ;
> +		return -bt_to_errno(status);
> 	}
> 
> -	memcpy(ver, skb->data, sizeof(*ver));
> +	check_tlv = *(data + 1);

Lets not introduce the data variable since it is pointless. And even check_tlv variable seems not really needed.

> 
> +	if (skb->len == sizeof(version->intel_version) && check_tlv == 0x37) {
> +		memcpy(&version->intel_version, skb->data, sizeof(version->intel_version));
> +		version->is_tlv_supported = false;
> +	} else {
> +		version->is_tlv_supported = true;
> +	}
> 	kfree_skb(skb);
> -
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(btintel_read_version);
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 08e20606fb58..0865d2d4aca7 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -66,6 +66,13 @@ struct intel_debug_features {
> 	__u8    page1[16];
> } __packed;
> 
> +struct btintel_version {
> +	bool is_tlv_supported;
> +	union {
> +		struct intel_version intel_version; /* legacy version */
> +	};
> +} __packed;
> +
> #if IS_ENABLED(CONFIG_BT_INTEL)
> 
> int btintel_check_bdaddr(struct hci_dev *hdev);
> @@ -76,13 +83,13 @@ int btintel_set_diag(struct hci_dev *hdev, bool enable);
> int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable);
> void btintel_hw_error(struct hci_dev *hdev, u8 code);
> 
> -void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
> +void btintel_version_info(struct hci_dev *hdev, const struct btintel_version *version);

This might be better done like this:

void btintel_version_info(struct hci_dev *hdev, bool tlv_format, void *buf, u8 len);

Depending on from where this is called and if we have existing knowledge of the format, we can keep the current one and just add btintel_version_tlv(..

I do like the latter better, but I would have to look at the whole call-chain first.

> int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
> 			const void *param);
> int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name);
> int btintel_set_event_mask(struct hci_dev *hdev, bool debug);
> int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug);
> -int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver);
> +int btintel_read_version(struct hci_dev *hdev, struct btintel_version *version);

int btintel_read_version(struct hci_dev *hdev, u8 *buf, u8 *len, bool *tlv_format);

> struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
> 				   u16 opcode_write);
> @@ -133,7 +140,7 @@ static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
> }
> 
> static inline void btintel_version_info(struct hci_dev *hdev,
> -					struct intel_version *ver)
> +					struct btintel_version *version)
> {
> }
> 
> @@ -160,7 +167,7 @@ static inline int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug)
> }
> 
> static inline int btintel_read_version(struct hci_dev *hdev,
> -				       struct intel_version *ver)
> +				       struct btintel_version *version)
> {
> 	return -EOPNOTSUPP;
> }
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index faa863dd5d0a..d06c946f7810 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1938,6 +1938,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
> 	const u8 *fw_ptr;
> 	int disable_patch, err;
> 	struct intel_version ver;
> +	struct btintel_version version;
> 
> 	BT_DBG("%s", hdev->name);
> 
> @@ -1963,10 +1964,16 @@ static int btusb_setup_intel(struct hci_dev *hdev)
> 	 * The returned information are hardware variant and revision plus
> 	 * firmware variant, revision and build number.
> 	 */
> -	err = btintel_read_version(hdev, &ver);
> +	err = btintel_read_version(hdev, &version);
> 	if (err)
> 		return err;
> 
> +	if (version.is_tlv_supported) {
> +		bt_dev_err(hdev, "FW download in tlv format not supported");
> +		return -EOPNOTSUPP;
> +	}
> +	ver = version.intel_version;
> +
> 	bt_dev_info(hdev, "read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
> 		    ver.hw_platform, ver.hw_variant, ver.hw_revision,
> 		    ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
> @@ -2049,11 +2056,11 @@ static int btusb_setup_intel(struct hci_dev *hdev)
> 	/* Need build number for downloaded fw patches in
> 	 * every power-on boot
> 	 */
> -       err = btintel_read_version(hdev, &ver);
> -       if (err)
> -               return err;
> -       bt_dev_info(hdev, "Intel BT fw patch 0x%02x completed & activated",
> -		   ver.fw_patch_num);
> +	err = btintel_read_version(hdev, &version);
> +	if (err)
> +		return err;
> +	bt_dev_info(hdev, "Intel BT fw patch 0x%02x completed & activated",
> +		    version.intel_version.fw_patch_num);
> 
> 	goto complete;
> 
> @@ -2251,11 +2258,18 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
> 	return -EILSEQ;
> }
> 
> -static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
> -					     struct intel_boot_params *params,
> -					     char *fw_name, size_t len,
> -					     const char *suffix)
> +static bool btusb_setup_intel_new_get_fw_name(const struct btintel_version *version,
> +					      struct intel_boot_params *params,
> +					      char *fw_name, size_t len,
> +					      const char *suffix)

So either we convert the required fields out of the TLV into intel_version or we might have provide them as parameters or an actual separate struct.

> {
> +	const struct intel_version *ver;
> +
> +	if (version->is_tlv_supported)
> +		return false;
> +
> +	ver = &version->intel_version;
> +
> 	switch (ver->hw_variant) {
> 	case 0x0b:	/* SfP */
> 	case 0x0c:	/* WsP */
> @@ -2281,18 +2295,21 @@ static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
> }
> 
> static int btusb_intel_download_firmware(struct hci_dev *hdev,
> -					 struct intel_version *ver,
> +					 struct btintel_version *version,
> 					 struct intel_boot_params *params)
> {
> 	const struct firmware *fw;
> 	u32 boot_param;
> 	char fwname[64];
> 	int err;
> +	const struct intel_version *ver;
> 	struct btusb_data *data = hci_get_drvdata(hdev);
> 
> -	if (!ver || !params)
> +	if (!version || !params)
> 		return -EINVAL;
> 
> +	ver = &version->intel_version;
> +
> 	/* The hardware platform number has a fixed value of 0x37 and
> 	 * for now only accept this single value.
> 	 */
> @@ -2322,8 +2339,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
> 		return -EINVAL;
> 	}
> 
> -	btintel_version_info(hdev, ver);
> -

I don’t like just removing this here. We add the print outs for a reason.

> 	/* The firmware variant determines if the device is in bootloader
> 	 * mode or is running operational firmware. The value 0x06 identifies
> 	 * the bootloader and the value 0x23 identifies the operational
> @@ -2398,7 +2413,7 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
> 	 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
> 	 *
> 	 */
> -	err = btusb_setup_intel_new_get_fw_name(ver, params, fwname,
> +	err = btusb_setup_intel_new_get_fw_name(version, params, fwname,
> 						sizeof(fwname), "sfi");
> 	if (!err) {
> 		bt_dev_err(hdev, "Unsupported Intel firmware naming");
> @@ -2483,6 +2498,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 	unsigned long long duration;
> 	int err;
> 	struct intel_debug_features features;
> +	struct btintel_version version;
> 
> 	BT_DBG("%s", hdev->name);
> 
> @@ -2494,21 +2510,28 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 
> 	calltime = ktime_get();
> 
> -	/* Read the Intel version information to determine if the device
> -	 * is in bootloader mode or if it already has operational firmware
> -	 * loaded.
> +	/* Read controller version information and support of tlv format
> 	 */

I would leave the comment as is.

> -	err = btintel_read_version(hdev, &ver);
> +	err = btintel_read_version(hdev, &version);
> 	if (err) {
> -		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
> +		bt_dev_err(hdev, "Intel Read version new failed (%d)", err);

Don’t add random “new” parts in the existing messages.

> 		btintel_reset_to_bootloader(hdev);
> 		return err;
> 	}
> 
> -	err = btusb_intel_download_firmware(hdev, &ver, &params);
> +	if (version.is_tlv_supported) {
> +		bt_dev_err(hdev, "Firmware download in tlv format is not supported");
> +		return -EOPNOTSUPP;
> +	}

Do we need this twice?

> +
> +	btintel_version_info(hdev, &version);
> +
> +	err = btusb_intel_download_firmware(hdev, &version, &params);
> 	if (err)
> 		return err;
> 
> +	ver = version.intel_version;
> +
> 	/* controller is already having an operational firmware */
> 	if (ver.fw_variant == 0x23)
> 		goto finish;
> @@ -2562,7 +2585,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 
> 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
> 
> -	err = btusb_setup_intel_new_get_fw_name(&ver, &params, ddcname,
> +	err = btusb_setup_intel_new_get_fw_name(&version, &params, ddcname,
> 						sizeof(ddcname), "ddc");
> 
> 	if (!err) {
> @@ -2586,11 +2609,11 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
> 	btintel_set_debug_features(hdev, &features);
> 
> 	/* Read the Intel version information after loading the FW  */
> -	err = btintel_read_version(hdev, &ver);
> +	err = btintel_read_version(hdev, &version);
> 	if (err)
> 		return err;
> 
> -	btintel_version_info(hdev, &ver);
> +	btintel_version_info(hdev, &version);
> 
> finish:
> 	/* All Intel controllers that support the Microsoft vendor
> diff --git a/drivers/bluetooth/hci_ag6xx.c b/drivers/bluetooth/hci_ag6xx.c
> index 1f55df93e4ce..6f6a1e061972 100644
> --- a/drivers/bluetooth/hci_ag6xx.c
> +++ b/drivers/bluetooth/hci_ag6xx.c
> @@ -153,6 +153,7 @@ static int ag6xx_setup(struct hci_uart *hu)
> 	struct hci_dev *hdev = hu->hdev;
> 	struct sk_buff *skb;
> 	struct intel_version ver;
> +	struct btintel_version version;
> 	const struct firmware *fw;
> 	const u8 *fw_ptr;
> 	char fwname[64];
> @@ -166,11 +167,18 @@ static int ag6xx_setup(struct hci_uart *hu)
> 	if (err)
> 		return err;
> 
> -	err = btintel_read_version(hdev, &ver);
> +	err = btintel_read_version(hdev, &version);
> 	if (err)
> 		return err;
> 
> -	btintel_version_info(hdev, &ver);
> +	if (version.is_tlv_supported) {
> +		bt_dev_err(hdev, "Firmware download in tlv format over ag6xx is not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	btintel_version_info(hdev, &version);
> +
> +	ver = version.intel_version;
> 
> 	/* The hardware platform number has a fixed value of 0x37 and
> 	 * for now only accept this single value.
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index f1299da6eed8..f30cbc66d48f 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -532,6 +532,7 @@ static int intel_setup(struct hci_uart *hu)
> 	struct hci_dev *hdev = hu->hdev;
> 	struct sk_buff *skb;
> 	struct intel_version ver;
> +	struct btintel_version version;
> 	struct intel_boot_params params;
> 	struct list_head *p;
> 	const struct firmware *fw;
> @@ -584,10 +585,17 @@ static int intel_setup(struct hci_uart *hu)
> 	 * is in bootloader mode or if it already has operational firmware
> 	 * loaded.
> 	 */
> -	err = btintel_read_version(hdev, &ver);
> +	err = btintel_read_version(hdev, &version);
> 	if (err)
> 		return err;
> 
> +	if (version.is_tlv_supported) {
> +		/* firmware download in tlv format is not supported on UART transport */
> +		bt_dev_err(hdev, "Firmware download in tlv format is not supported");
> +		return -EOPNOTSUPP;
> +	}

So now I wonder if we really want to send that 0xff even on UART. So maybe btintel_read_version needs to get an extra bool parameter for requesting TLV or not.

> +	ver = version.intel_version;
> +
> 	/* The hardware platform number has a fixed value of 0x37 and
> 	 * for now only accept this single value.
> 	 */
> @@ -614,7 +622,7 @@ static int intel_setup(struct hci_uart *hu)
> 		return -EINVAL;
> 	}
> 
> -	btintel_version_info(hdev, &ver);
> +	btintel_version_info(hdev, &version);

I really think now that btintel_version_info and btintel_version_info_tlv are needed. If we don’t have this on UART, then we should try to change the UART code as less as possible.

Or we first need to unify the UART and USB code a lot more into btintel.c so that it is all handled there.

> 
> 	/* The firmware variant determines if the device is in bootloader
> 	 * mode or is running operational firmware. The value 0x06 identifies

Regards

Marcel

