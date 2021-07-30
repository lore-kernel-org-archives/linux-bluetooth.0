Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D72C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jul 2021 06:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA65760F6B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jul 2021 06:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhG3GkI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jul 2021 02:40:08 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59212 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbhG3GkH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jul 2021 02:40:07 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id DCF16CED27;
        Fri, 30 Jul 2021 08:40:01 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v5 05/11] Bluetooth: btintel: Fix the first HCI command
 not work with ROM device
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <05fd097e82b5c50ceaba584f36b6f8855792fc69.camel@gmail.com>
Date:   Fri, 30 Jul 2021 08:40:01 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C26294D2-5DD7-42B8-BFE4-D358B4BF5D66@holtmann.org>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
 <20210729183600.281586-6-hj.tedd.an@gmail.com>
 <02BA95EC-D6F9-40DA-BAC3-6C935A8DB0C4@holtmann.org>
 <05fd097e82b5c50ceaba584f36b6f8855792fc69.camel@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

>>> The some legacy ROM controllers have a bug with the first HCI command
>>> sent to it returning number of completed commands as zero, which would
>>> stall the command processing in the Bluetooth core.
>>> 
>>> As a workaround, send HCI Rest command first which will reset the
>>> controller to fix the issue.
>>> 
>>> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
>>> ---
>>> drivers/bluetooth/btintel.c | 21 +++++++++++++++++++++
>>> drivers/bluetooth/btintel.h |  1 +
>>> drivers/bluetooth/btusb.c   | 16 ++++++++++++++--
>>> 3 files changed, 36 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
>>> index bf0ad05b80fe..65ecf2ae9a10 100644
>>> --- a/drivers/bluetooth/btintel.c
>>> +++ b/drivers/bluetooth/btintel.c
>>> @@ -1659,6 +1659,7 @@ static int btintel_legacy_rom_setup(struct hci_dev *hdev,
>>> 
>>> int btintel_setup_combined(struct hci_dev *hdev)
>>> {
>>> +	struct btintel_data *intel = hci_get_priv(hdev);
>>> 	const u8 param[1] = { 0xFF };
>>> 	struct intel_version ver;
>>> 	struct intel_version_tlv ver_tlv;
>>> @@ -1667,6 +1668,26 @@ int btintel_setup_combined(struct hci_dev *hdev)
>>> 
>>> 	BT_DBG("%s", hdev->name);
>>> 
>>> +	/* The some controllers have a bug with the first HCI command sent to it
>>> +	 * returning number of completed commands as zero. This would stall the
>>> +	 * command processing in the Bluetooth core.
>>> +	 *
>>> +	 * As a workaround, send HCI Reset command first which will reset the
>>> +	 * number of completed commands and allow normal command processing
>>> +	 * from now on.
>>> +	 */
>>> +	if (test_bit(INTEL_BROKEN_READ_VERSION, &intel->flags)) {
>>> +		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
>>> +				     HCI_INIT_TIMEOUT);
>>> +		if (IS_ERR(skb)) {
>>> +			bt_dev_err(hdev,
>>> +				   "sending initial HCI reset failed (%ld)",
>>> +				   PTR_ERR(skb));
>>> +			return PTR_ERR(skb);
>>> +		}
>>> +		kfree_skb(skb);
>>> +	}
>>> +
>>> 	/* Starting from TyP device, the command parameter and response are
>>> 	 * changed even though the OCF for HCI_Intel_Read_Version command
>>> 	 * remains same. The legacy devices can handle even if the
>>> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
>>> index df7aa30142b4..29b678364a79 100644
>>> --- a/drivers/bluetooth/btintel.h
>>> +++ b/drivers/bluetooth/btintel.h
>>> @@ -143,6 +143,7 @@ struct intel_debug_features {
>>> #define INTEL_FIRMWARE_LOADED		2
>>> #define INTEL_FIRMWARE_FAILED		3
>>> #define INTEL_BOOTING			4
>>> +#define INTEL_BROKEN_READ_VERSION	5
>>> 
>>> struct btintel_data {
>>> 	unsigned long flags;
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index 8c54ab03ee63..a64473c525eb 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -62,6 +62,7 @@ static struct usb_driver btusb_driver;
>>> #define BTUSB_QCA_WCN6855	0x1000000
>>> #define BTUSB_INTEL_NEWGEN	0x2000000
>>> #define BTUSB_INTEL_COMBINED	0x4000000
>>> +#define BTUSB_INTEL_BROKEN_READ_VERSION 0x8000000
>>> 
>>> static const struct usb_device_id btusb_table[] = {
>>> 	/* Generic Bluetooth USB device */
>>> @@ -376,11 +377,14 @@ static const struct usb_device_id blacklist_table[] = {
>>> 						     BTUSB_WIDEBAND_SPEECH |
>>> 						     BTUSB_VALID_LE_STATES },
>>> 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
>>> -	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED },
>>> -	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED },
>>> +	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
>>> +						     BTUSB_INTEL_BROKEN_READ_VERSION },
>>> +	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
>>> +						     BTUSB_INTEL_BROKEN_READ_VERSION },
>>> 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW |
>>> 						     BTUSB_WIDEBAND_SPEECH },
>>> 	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
>>> +						     BTUSB_INTEL_BROKEN_READ_VERSION |
>>> 						     BTUSB_WIDEBAND_SPEECH },
>>> 	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW |
>>> 						     BTUSB_WIDEBAND_SPEECH |
>> 
>> can you check that all 3 have this problem? Don’t we ever produced a ROM where this is fixed?
> 
> It looks like the early version of ROM (WP2) causes the problem. StP and SdP don't have the problem.
> I will update accordingly.

then we should get away with having BTUSB_INTEL_COMBINED (which we can later rename back into BTUSB_INTEL) and one additional BTUSB_INTEL_BROKEN_INITIAL_NCMD. Everything else we can do internally in the Intel vendor specific handling.

> 
> WP2 - I only had mini-PCIe form factor card and it is broken.
> < HCI Command: Intel Read Version (0x3f|0x0005) plen 1                        #1 [hci0] 9.212217
>        Requested Type:
>          All Supported Types(0xff)
>> HCI Event: Command Complete (0x0e) plen 13                                      #2 [hci0] 9.213338
>      Intel Read Version (0x3f|0x0005) ncmd 0
>        Status: Success (0x00)
>        Hardware platform: 0x37
>        Hardware variant: 0x07
>        Hardware revision: 1.0
>        Firmware variant: 0x01
>        Firmware revision: 8.0
>        Firmware build: 2-3.2013
>        Firmware patch: 0
> 
> StP - OK. 
> < HCI Command: Intel Read Version (0x3f|0x0005) plen 1                      #3 [hci0] 108.053455
>        Requested Type:
>          All Supported Types(0xff)
>> HCI Event: Command Complete (0x0e) plen 13                                    #4 [hci0] 108.054034
>      Intel Read Version (0x3f|0x0005) ncmd 1
>        Status: Success (0x00)
>        Hardware platform: 0x37
>        Hardware variant: 0x08
>        Hardware revision: 1.0
>        Firmware variant: 0x01
>        Firmware revision: 1.0
>        Firmware build: 3-17.2014
>        Firmware patch: 0
> 
> SdP - OK.
> < HCI Command: Intel Read Version (0x3f|0x0005) plen 1                    #400 [hci0] 173.911992
>        Requested Type:
>          All Supported Types(0xff)
>> HCI Event: Command Complete (0x0e) plen 13                                  #401 [hci0] 173.912576
>      Intel Read Version (0x3f|0x0005) ncmd 1
>        Status: Success (0x00)
>        Hardware platform: 0x37
>        Hardware variant: 0x08
>        Hardware revision: 1.0
>        Firmware variant: 0x22
>        Firmware revision: 5.0
>        Firmware build: 25-20.2015
>        Firmware patch: 0

We should add a document in bluez/doc/intel-variants.txt that documents our own hardware and which variants and firmware combinations we have tested this with. It is good for revision history and if users complain or have slight variations of the SKUs.

Regards

Marcel

