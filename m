Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ED3C64E8A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 05:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2722087D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 05:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgLAFrJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 00:47:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44616 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgLAFrJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 00:47:09 -0500
Received: from [103.229.218.199] (helo=[10.1.1.106])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1kjyUd-00052q-2y; Tue, 01 Dec 2020 05:46:27 +0000
Subject: Re: [PATCH] Bluetooth: btusb: Add a parameter to load fw forcibly for
 Intel BT
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
References: <20201130052753.111742-1-hui.wang@canonical.com>
 <116CA1BC-A38E-4622-99D7-91C7DF6EA463@holtmann.org>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <efdddc31-bf46-42e6-8edd-710835ed3f4b@canonical.com>
Date:   Tue, 1 Dec 2020 13:46:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <116CA1BC-A38E-4622-99D7-91C7DF6EA463@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 12/1/20 1:05 AM, Marcel Holtmann wrote:
> Hi Hui,
>
>> On the machines with Intel new BT module, if users run reboot, the BT
>> driver will not load the firmware from rootfs during boot since it is
>> already in operational mode. This will confuse the users if users
>> update the BT firmware and expect the updated firmware to fix some
>> problems.
>>
>> Let the driver print a message to tell users the firmware is not
>> loaded and add a module parameter to let driver forcibly load the
>> firmware from rootfs. After users read this message, they could set
>> this parameter to load the firmware forcibly.
>>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>> drivers/bluetooth/btusb.c | 13 ++++++++++++-
>> 1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 1005b6e8ff74..d4fceedd354b 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -32,6 +32,7 @@ static bool force_scofix;
>> static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
>>
>> static bool reset = true;
>> +static bool force_load_fw;
>>
>> static struct usb_driver btusb_driver;
>>
>> @@ -2589,8 +2590,15 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>> 		return err;
>>
>> 	/* controller is already having an operational firmware */
>> -	if (ver.fw_variant == 0x23)
>> +	if (ver.fw_variant == 0x23) {
>> +		if (force_load_fw) {
>> +			btintel_reset_to_bootloader(hdev);
>> +			force_load_fw = false;
>> +			return -EAGAIN;
>> +		}
>> +		bt_dev_info(hdev, "already in operational mode, not load fw. Set force_load_fw=1 to load fw forcibly");
>> 		goto finish;
>> +	}
> I don’t like this approach. I rather do this in a more generic way that resets the controller and puts it into boot loader support if support. We can use the experimental mgmt setting for this.
OK, got it, will investigate it. Thanks.
>
> Regards
>
> Marcel
>
