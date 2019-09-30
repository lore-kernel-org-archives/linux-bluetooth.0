Return-Path: <SRS0=G1Nt=XZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9835DC32792
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 11:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD512190F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 11:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfI3LNT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Sep 2019 07:13:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:34563 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729870AbfI3LNS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Sep 2019 07:13:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 04:13:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,567,1559545200"; 
   d="scan'208";a="392034027"
Received: from pgsmsx114.gar.corp.intel.com ([10.108.55.203])
  by fmsmga006.fm.intel.com with ESMTP; 30 Sep 2019 04:13:17 -0700
Received: from pgsmsx105.gar.corp.intel.com ([169.254.4.30]) by
 pgsmsx114.gar.corp.intel.com ([169.254.4.250]) with mapi id 14.03.0439.000;
 Mon, 30 Sep 2019 19:13:16 +0800
From:   "Bag, Amit K" <amit.k.bag@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Hegde, Raghuram" <raghuram.hegde@intel.com>
Subject: RE: [PATCH] Bluetooth: btusb: Trigger Intel FW download error
 recovery
Thread-Topic: [PATCH] Bluetooth: btusb: Trigger Intel FW download error
 recovery
Thread-Index: AQHVdDZ8SxjBrsJBVUGWo2sTd/IkjKc+jbWAgACTsUCABGcogIAAh00A
Date:   Mon, 30 Sep 2019 11:13:16 +0000
Message-ID: <EFE6F46E14A5F445949D76A8CAC224005844E059@PGSMSX105.gar.corp.intel.com>
References: <1569480202-10560-1-git-send-email-amit.k.bag@intel.com>
 <BE2BC36F-DD17-4773-B38B-AE4129EB3437@holtmann.org>
 <EFE6F46E14A5F445949D76A8CAC224005844D981@PGSMSX105.gar.corp.intel.com>
 <F15D9D95-0A5F-43E9-AA56-D7FFE0E5EAB9@holtmann.org>
In-Reply-To: <F15D9D95-0A5F-43E9-AA56-D7FFE0E5EAB9@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjBhMjg0NTItNmZiMi00NGU4LWFiYWEtZDI0NzBlMWQwMzU0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNFg5M1BkcnBZOFRkN1dKbDhWaHoycGxUOTg2MTQwRlRSUmhmb3E4MGZWTjRja0s1NXdLTW1hdW5PVk5QdXl0biJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

>Hi Amit,
>
>>>> Sometimes during FW data download stage, in case of an error is 
>>>> encountered the controller device could not be recovered. To recover 
>>>> from such failures send Intel hard Reset to re-trigger FW download 
>>>> in following error scenarios:
>>>> 
>>>> 1. Intel Read version command error
>>>> 2. Firmware download timeout
>>>> 3. Failure in Intel Soft Reset for switching to operational FW 4. 
>>>> Boot timeout for switching to operaional FW
>>>> 
>>>> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
>>>> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
>>>> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
>>>> ---
>>>> drivers/bluetooth/btintel.c | 39
>>>> +++++++++++++++++++++++++++++++++++++++
>>>> drivers/bluetooth/btintel.h |  6 ++++++
>>>> drivers/bluetooth/btusb.c   | 20 ++++++++++++++++----
>>>> 3 files changed, 61 insertions(+), 4 deletions(-)
>>>> 
>>>> diff --git a/drivers/bluetooth/btintel.c 
>>>> b/drivers/bluetooth/btintel.c index bb99c8653aab..fdec9c53b48d 
>>>> 100644
>>>> --- a/drivers/bluetooth/btintel.c
>>>> +++ b/drivers/bluetooth/btintel.c
>>>> @@ -709,6 +709,45 @@ int btintel_download_firmware(struct hci_dev 
>>>> *hdev, const struct firmware *fw, } 
>>>> EXPORT_SYMBOL_GPL(btintel_download_firmware);
>>>> 
>>>> +void btintel_retry_fw_download(struct hci_dev *hdev) {
>>>> +	/* Send Intel Reset command. This will result in
>>>> +	 * re-enumeration of BT controller.
>>>> +	 *
>>>> +	 * Intel Reset parameter description:
>>>> +	 * reset_param[0] => reset_type : 0x01 (Hard reset),
>>>> +					  0x00 (Soft reset)
>>>> +	 * reset_param[1] => patch_enable : 0x01 (Enable),
>>>> +	 *				    0x00 (Do not enable)
>>>> +	 * reset_param[2] => ddc_reload : 0x01 (Reload),
>>>> +	 *				  0x00 (Do not reload)
>>>> +	 * reset_param[3] => boot_option: 0x00 (Current image),
>>>> +					  0x01 (Specified boot address)
>>>> +	 * reset_param[4] to reset_param[7] => Boot address
>>>> +	 *
>>>> +	 */
>>>> +	static const u8 reset_param[] = { 0x01, 0x01, 0x01, 0x00,
>>>> +					0x00, 0x00, 0x00, 0x00 };
>> 
>> pplease use intel_reset structure and add the comments when assigning the fields.
>> 
>>>> +	struct sk_buff *skb;
>>>> +
>>>> +	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(reset_param),
>>>> +				reset_param, HCI_INIT_TIMEOUT);
>> 
>> pplease align the second line according to the coding style.
>> 
>>>> +	if (IS_ERR(skb)) {
>>>> +		bt_dev_err(hdev, "FW download error recovery failed (%ld)",
>>>> +				PTR_ERR(skb));
>> 
>> SSame as above.
>> 
>>>> +		return;
>>>> +	}
>>>> +	bt_dev_info(hdev, "Intel reset sent to retry FW download");
>>>> +	kfree_skb(skb);
>> 
>> EExtra empty line here.
>> 
>>>> +	/* Current Intel BT controllers(ThP/JfP) hold the USB reset
>>>> +	 * lines for 2ms when it receives Intel Reset in bootloader mode.
>>>> +	 * Whereas, the upcoming Intel BT controllers will hold USB reset
>>>> +	 * for 150ms. To keep the delay generic, 150ms is chosen here.
>>>> +	 */
>>>> +	msleep(150);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(btintel_retry_fw_download);
>>>> +
>> 
>> II do not like the name here. Using btintel_reset_to_bootloader would be better. Since the function itself is not going to do the firmware retry. It will just drop you back into boot loader.
>> 
>> HHowever the more important question is what happens if you send this command. Is the device re-enumerating on USB? Or after the 150ms we just have to redo the firmware download.
>> 
>>>> MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>"); 
>>>> MODULE_DESCRIPTION("Bluetooth support for Intel devices ver "
>>>> VERSION); MODULE_VERSION(VERSION); diff --git 
>>>> a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h index
>>>> 3d846190f2bf..d04d3c7cb513 100644
>>>> --- a/drivers/bluetooth/btintel.h
>>>> +++ b/drivers/bluetooth/btintel.h
>>>> @@ -87,6 +87,7 @@ int btintel_read_boot_params(struct hci_dev *hdev,
>>>> 			     struct intel_boot_params *params); int 
>>>> btintel_download_firmware(struct hci_dev *dev, const struct firmware *fw,
>>>> 			      u32 *boot_param);
>>>> +void btintel_retry_fw_download(struct hci_dev *hdev);
>>>> #else
>>>> 
>>>> static inline int btintel_check_bdaddr(struct hci_dev *hdev) @@ 
>>>> -181,4
>>>> +182,9 @@ static inline int btintel_download_firmware(struct hci_dev
>>>> *dev, {
>>>> 	return -EOPNOTSUPP;
>>>> }
>>>> +
>>>> +static inline void btintel_retry_fw_download(struct hci_dev *hdev) {
>>>> +	return -EOPNOTSUPP;
>>>> +}
>>>> #endif
>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c 
>>>> index a9c35ebb30f8..7a763bd856ba 100644
>>>> --- a/drivers/bluetooth/btusb.c
>>>> +++ b/drivers/bluetooth/btusb.c
>>>> @@ -1846,8 +1846,11 @@ static int btusb_setup_intel(struct hci_dev *hdev)
>>>> 	 * firmware variant, revision and build number.
>>>> 	 */
>>>> 	err = btintel_read_version(hdev, &ver);
>>>> -	if (err)
>>>> +	if (err) {
>>>> +		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
>>>> +		btintel_retry_fw_download(hdev);
>>>> 		return err;
>>>> +	}
>>>> 
>>>> 	bt_dev_info(hdev, "read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
>>>> 		    ver.hw_platform, ver.hw_variant, ver.hw_revision, @@ -2326,9
>>>> +2329,13 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>>>> 
>>>> 	/* Start firmware downloading and get boot parameter */
>>>> 	err = btintel_download_firmware(hdev, fw, &boot_param);
>>>> -	if (err < 0)
>>>> +	if (err < 0) {
>>>> +		/* When FW download fails, send Intel Reset to retry
>>>> +		 * FW download.
>>>> +		 */
>>>> +		btintel_retry_fw_download(hdev);
>>>> 		goto done;
>>> 
>>> Is this actually going to work? If you jump to done, then you end up sending intel soft reset and then waiting for the device to boot. If you are lucky it times out, if not, then you end up loading DCC now.
>>> 
>>> If the device re-enumerates on USB, then we need an extra jump point to just release the firmware memory and then just exit hdev->setup. If are suppose to just retry, then we need to actually start over.
>>> 
>>> So have you actually tested this by randomly failing each step in the firmware download process.
>>> 
>> We send hard reset which will re-emumerates BT USB device and  initialize usb driver. 
>> We have tested all the scenario and its working fine.
>
>that is fine. However when this happens we should try to exit without sending any further commands. So we will need a separate exit path then.

This happens during firmware download when controller is in bootloader mode. When there is error during firmware download BT driver will not send any further command and since driver is not initialized bluez stack also will not send any commands at all. Only way to recover from this error is to power cycle the machine. Instead of complete power cycle we introduce this recovery mechanism  by sending hard reset command which will only power cycle the BT chip not the complete machine.
