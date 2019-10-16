Return-Path: <SRS0=8ZYm=YJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D231FA3728
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 18:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEBE21D7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 18:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436656AbfJPS55 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:57:57 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52260 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436617AbfJPS55 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Oct 2019 14:57:57 -0400
Received: from surfer-172-29-2-69-hotspot.internet-for-guests.com (p578ac27a.dip0.t-ipconnect.de [87.138.194.122])
        by mail.holtmann.org (Postfix) with ESMTPSA id A95AACECDD;
        Wed, 16 Oct 2019 21:06:53 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Trigger Intel FW download error
 recovery
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <EFE6F46E14A5F445949D76A8CAC2240058458264@PGSMSX105.gar.corp.intel.com>
Date:   Wed, 16 Oct 2019 20:57:54 +0200
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Hegde, Raghuram" <raghuram.hegde@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <ACF47453-9F0E-4ED3-BC39-1216A57574EA@holtmann.org>
References: <1569908947-10516-1-git-send-email-amit.k.bag@intel.com>
 <EFE6F46E14A5F445949D76A8CAC2240058458264@PGSMSX105.gar.corp.intel.com>
To:     "Bag, Amit K" <amit.k.bag@intel.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amit,

>> Sometimes during FW data download stage, in case of an error is encountered the controller device could not be recovered. To recover from such failures send Intel hard Reset to re-trigger FW download in following error scenarios:
>> 
>> 1. Intel Read version command error
>> 2. Firmware download timeout
>> 3. Failure in Intel Soft Reset for switching to operational FW 4. Boot timeout for switching to operaional FW
>> 
>> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
>> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
>> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
>> ---
>> drivers/bluetooth/btintel.c | 39 +++++++++++++++++++++++++++++++++++++++
>> drivers/bluetooth/btintel.h |  6 ++++++
>> drivers/bluetooth/btusb.c   | 20 ++++++++++++++++----
>> 3 files changed, 61 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c index bb99c8653aab..0154764ebdf8 100644
>> --- a/drivers/bluetooth/btintel.c
>> +++ b/drivers/bluetooth/btintel.c
>> @@ -709,6 +709,45 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,  }  EXPORT_SYMBOL_GPL(btintel_download_firmware);
>> 
>> +void btintel_reset_to_bootloader(struct hci_dev *hdev) {
>> +	/* Send Intel Reset command. This will result in
>> +	 * re-enumeration of BT controller.
>> +	 *
>> +	 * Intel Reset parameter description:
>> +	 * reset_param[0] => reset_type : 0x01 (Hard reset),
>> +					  0x00 (Soft reset)
>> +	 * reset_param[1] => patch_enable : 0x01 (Enable),
>> +	 *				    0x00 (Do not enable)
>> +	 * reset_param[2] => ddc_reload : 0x01 (Reload),
>> +	 *				  0x00 (Do not reload)
>> +	 * reset_param[3] => boot_option: 0x00 (Current image),
>> +					  0x01 (Specified boot address)
>> +	 * reset_param[4] to reset_param[7] => Boot address
>> +	 *
>> +	 */
>> +	static const u8 reset_param[] = { 0x01, 0x01, 0x01, 0x00,
>> +					0x00, 0x00, 0x00, 0x00 };
>> +	struct sk_buff *skb;
>> +
>> +	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(reset_param),
>> +			     reset_param, HCI_INIT_TIMEOUT);
>> +	if (IS_ERR(skb)) {
>> +		bt_dev_err(hdev, "FW download error recovery failed (%ld)",
>> +			   PTR_ERR(skb));
>> +		return;
>> +	}
>> +	bt_dev_info(hdev, "Intel reset sent to retry FW download");
>> +	kfree_skb(skb);
>> +	/* Current Intel BT controllers(ThP/JfP) hold the USB reset
>> +	 * lines for 2ms when it receives Intel Reset in bootloader mode.
>> +	 * Whereas, the upcoming Intel BT controllers will hold USB reset
>> +	 * for 150ms. To keep the delay generic, 150ms is chosen here.
>> +	 */
>> +	msleep(150);
>> +}
>> +EXPORT_SYMBOL_GPL(btintel_reset_to_bootloader);
>> +
>> MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");  MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);  MODULE_VERSION(VERSION); diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h index 3d846190f2bf..d2311156f778 100644
>> --- a/drivers/bluetooth/btintel.h
>> +++ b/drivers/bluetooth/btintel.h
>> @@ -87,6 +87,7 @@ int btintel_read_boot_params(struct hci_dev *hdev,
>> 			     struct intel_boot_params *params);  int btintel_download_firmware(struct hci_dev *dev, const struct firmware *fw,
>> 			      u32 *boot_param);
>> +void btintel_reset_to_bootloader(struct hci_dev *hdev);
>> #else
>> 
>> static inline int btintel_check_bdaddr(struct hci_dev *hdev) @@ -181,4 +182,9 @@ static inline int btintel_download_firmware(struct hci_dev *dev,  {
>> 	return -EOPNOTSUPP;
>> }
>> +
>> +static inline void btintel_reset_to_bootloader(struct hci_dev *hdev) {
>> +	return -EOPNOTSUPP;
>> +}
>> #endif
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c index 5d7bc3410104..47178af7f7fe 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -1846,8 +1846,11 @@ static int btusb_setup_intel(struct hci_dev *hdev)
>> 	 * firmware variant, revision and build number.
>> 	 */
>> 	err = btintel_read_version(hdev, &ver);
>> -	if (err)
>> +	if (err) {
>> +		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
>> +		btintel_reset_to_bootloader(hdev);
>> 		return err;
>> +	}
>> 
>> 	bt_dev_info(hdev, "read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
>> 		    ver.hw_platform, ver.hw_variant, ver.hw_revision, @@ -2326,9 +2329,13 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>> 
>> 	/* Start firmware downloading and get boot parameter */
>> 	err = btintel_download_firmware(hdev, fw, &boot_param);
>> -	if (err < 0)
>> +	if (err < 0) {
>> +		/* When FW download fails, send Intel Reset to retry
>> +		 * FW download.
>> +		 */
>> +		btintel_reset_to_bootloader(hdev);
>> 		goto done;
>> -
>> +	}
>> 	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
>> 
>> 	bt_dev_info(hdev, "Waiting for firmware download to complete"); @@ -2355,6 +2362,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>> 	if (err) {
>> 		bt_dev_err(hdev, "Firmware loading timeout");
>> 		err = -ETIMEDOUT;
>> +		btintel_reset_to_bootloader(hdev);
>> 		goto done;
>> 	}
>> 
>> @@ -2381,8 +2389,11 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>> 	set_bit(BTUSB_BOOTING, &data->flags);
>> 
>> 	err = btintel_send_intel_reset(hdev, boot_param);
>> -	if (err)
>> +	if (err) {
>> +		bt_dev_err(hdev, "Intel Soft Reset failed (%d)", err);
>> +		btintel_reset_to_bootloader(hdev);
>> 		return err;
>> +	}
>> 
>> 	/* The bootloader will not indicate when the device is ready. This
>> 	 * is done by the operational firmware sending bootup notification.
>> @@ -2404,6 +2415,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>> 
>> 	if (err) {
>> 		bt_dev_err(hdev, "Device boot timeout");
>> +		btintel_reset_to_bootloader(hdev);
>> 		return -ETIMEDOUT;
>> 	}
> 
> Anything pending on this patch to be merged. 

you have not addressed all my comments.

Regards

Marcel

