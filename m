Return-Path: <SRS0=wWRn=YK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B266DFA372A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Oct 2019 08:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCC720869
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Oct 2019 08:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392968AbfJQIge convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Oct 2019 04:36:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:37727 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388788AbfJQIge (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Oct 2019 04:36:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 01:36:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,307,1566889200"; 
   d="scan'208";a="200323487"
Received: from pgsmsx104.gar.corp.intel.com ([10.221.44.91])
  by orsmga006.jf.intel.com with ESMTP; 17 Oct 2019 01:36:31 -0700
Received: from pgsmsx105.gar.corp.intel.com ([169.254.4.226]) by
 PGSMSX104.gar.corp.intel.com ([169.254.3.188]) with mapi id 14.03.0439.000;
 Thu, 17 Oct 2019 16:36:30 +0800
From:   "Bag, Amit K" <amit.k.bag@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Hegde, Raghuram" <raghuram.hegde@intel.com>
Subject: RE: [PATCH v3] Bluetooth: btusb: Trigger Intel FW download error
 recovery
Thread-Topic: [PATCH v3] Bluetooth: btusb: Trigger Intel FW download error
 recovery
Thread-Index: AQHVhLJKXxYTQGsv7EuvQlohVPZnv6dd8ToAgACPqxA=
Date:   Thu, 17 Oct 2019 08:36:30 +0000
Message-ID: <EFE6F46E14A5F445949D76A8CAC224005845C7BF@PGSMSX105.gar.corp.intel.com>
References: <1571292602-26274-1-git-send-email-amit.k.bag@intel.com>
 <3FCBAC52-CBED-4E6E-A638-B944975E0600@holtmann.org>
In-Reply-To: <3FCBAC52-CBED-4E6E-A638-B944975E0600@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGViOTYxZDktZWRiYS00NmU0LTgxZDUtNWFiNDQ5NWY4NmNlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiME9IcmdEZEtGeGkrUzBjUldudW1ucEdkQ0lSNWtVZkI3OHZLMml6NElkdlBIaFQ5c2t4NVhISnYySkVRdWFPVSJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

>> Sometimes during FW data download stage, in case of an error is 
>> encountered the controller device could not be recovered. To recover 
>> from such failures send Intel hard Reset to re-trigger FW download in 
>> following error scenarios:
>> 
>> 1. Intel Read version command error
>> 2. Firmware download timeout
>> 3. Failure in Intel Soft Reset for switching to operational FW 4. Boot 
>> timeout for switching to operaional FW
>> 
>> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
>> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
>> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
>> ---
>> drivers/bluetooth/btintel.c | 49 
>> +++++++++++++++++++++++++++++++++++++++++++++
>> drivers/bluetooth/btintel.h |  6 ++++++
>> drivers/bluetooth/btusb.c   | 20 ++++++++++++++----
>> 3 files changed, 71 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c 
>> index bb99c8653aab..a93aec22d3a6 100644
>> --- a/drivers/bluetooth/btintel.c
>> +++ b/drivers/bluetooth/btintel.c
>> @@ -709,6 +709,55 @@ int btintel_download_firmware(struct hci_dev 
>> *hdev, const struct firmware *fw, } 
>> EXPORT_SYMBOL_GPL(btintel_download_firmware);
>> 
>> +void btintel_reset_to_bootloader(struct hci_dev *hdev) {
>> +	const struct intel_reset params;
>> +	struct sk_buff *skb;
>> +	u32 boot_param;
>> +
>> +
>> +	boot_param = 0x00000000;
>> +
>> +	/* Send Intel Reset command. This will result in
>> +	 * re-enumeration of BT controller.
>> +	 *
>> +	 * Intel Reset parameter description:
>> +	 * reset_type :   0x00 (Soft reset),
>> +	 *		  0x01 (Hard reset)
>> +	 * patch_enable : 0x00 (Do not enable),
>> +	 *		  0x01 (Enable)
>> +	 * ddc_reload :   0x00 (Do not reload),
>> +	 *		  0x01 (Reload)
>> +	 * boot_option:   0x00 (Current image),
>> +	 *                0x01 (Specified boot address)
>> +	 * boot_param:    Boot address
>> +	 *
>> +	 */
>> +	params.reset_type = 0x01;
>> +	params.patch_enable = 0x01;
>> +	params.ddc_reload = 0x01;
>> +	params.boot_option = 0x00;
>> +	params.boot_param = cpu_to_le32(boot_param);
>
>params.boot_param = cpu_to_le32(0x00000000);
>
>> +
>> +	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(params),
>> +			     &params, HCI_INIT_TIMEOUT);
>> +	if (IS_ERR(skb)) {
>> +		bt_dev_err(hdev, "FW download error recovery failed (%ld)",
>> +			   PTR_ERR(skb));
>> +		return;
>> +	}
>> +	bt_dev_info(hdev, "Intel reset sent to retry FW download");
>> +	kfree_skb(skb);
>> +
>> +	/* Current Intel BT controllers(ThP/JfP) hold the USB reset
>> +	 * lines for 2ms when it receives Intel Reset in bootloader mode.
>> +	 * Whereas, the upcoming Intel BT controllers will hold USB reset
>> +	 * for 150ms. To keep the delay generic, 150ms is chosen here.
>> +	 */
>> +	msleep(150);
>> +}
>> +EXPORT_SYMBOL_GPL(btintel_reset_to_bootloader);
>> +
>> MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>"); 
>> MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " 
>> VERSION); MODULE_VERSION(VERSION); diff --git 
>> a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h index 
>> 3d846190f2bf..d2311156f778 100644
>> --- a/drivers/bluetooth/btintel.h
>> +++ b/drivers/bluetooth/btintel.h
>> @@ -87,6 +87,7 @@ int btintel_read_boot_params(struct hci_dev *hdev,
>> 			     struct intel_boot_params *params); int 
>> btintel_download_firmware(struct hci_dev *dev, const struct firmware *fw,
>> 			      u32 *boot_param);
>> +void btintel_reset_to_bootloader(struct hci_dev *hdev);
>> #else
>> 
>> static inline int btintel_check_bdaddr(struct hci_dev *hdev) @@ -181,4 
>> +182,9 @@ static inline int btintel_download_firmware(struct hci_dev 
>> *dev, {
>> 	return -EOPNOTSUPP;
>> }
>> +
>> +static inline void btintel_reset_to_bootloader(struct hci_dev *hdev) 
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> #endif
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c 
>> index 5d7bc3410104..47178af7f7fe 100644
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
>> 		    ver.hw_platform, ver.hw_variant, ver.hw_revision,
>
>I am bit confused on why you modify the read_version in the legacy Intel setup and not in the new one. Can we focus with this patch on setup_intel_new and you add support for legacy setup in a second patch if that is needed as well.
>
>> @@ -2326,9 +2329,13 @@ static int btusb_setup_intel_new(struct hci_dev 
>> *hdev)
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
>> 	bt_dev_info(hdev, "Waiting for firmware download to complete"); @@ 
>> -2355,6 +2362,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
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
>> @@ -2404,6 +2415,7 @@ static int btusb_setup_intel_new(struct hci_dev 
>> *hdev)
>> 
>> 	if (err) {
>> 		bt_dev_err(hdev, "Device boot timeout");
>> +		btintel_reset_to_bootloader(hdev);
>> 		return -ETIMEDOUT;
>> 	}

Sorry by mistake I modify the read_version in the legacy Intel setup. I corrected it in the patch v6 patch and also removed boot_param variable and directly assign the value as well. 

Regards,
Amit

