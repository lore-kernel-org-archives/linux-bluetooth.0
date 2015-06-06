Return-Path: <cyrus@holtmann.org>
Message-ID: <5572AC25.5020508@broadcom.com>
Date: Sat, 6 Jun 2015 10:15:33 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Ilya Faenson <ifaenson@broadcom.com>, <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 4/5] Broadcom Bluetooth protocol UART support
References: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com> <1433365304-16707-5-git-send-email-ifaenson@broadcom.com> <F9497027-7485-43C2-8D8D-8134798B300A@holtmann.org>
In-Reply-To: <F9497027-7485-43C2-8D8D-8134798B300A@holtmann.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/06/15 08:37, Marcel Holtmann wrote:
> Hi Ilya,
>
>> Merge of the Broadcom logic into the Intel's btbcm implementation.
>>
>> Signed-off-by: Ilya Faenson<ifaenson@broadcom.com>
>> ---
>> drivers/bluetooth/btbcm.c | 142 ++++++++++++++++++++++++++++++++++++----------
>> drivers/bluetooth/btbcm.h |  21 ++++++-
>> 2 files changed, 132 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>> index 728fce3..e1d5ad0 100644
>> --- a/drivers/bluetooth/btbcm.c
>> +++ b/drivers/bluetooth/btbcm.c
>> @@ -3,6 +3,7 @@
>>   *  Bluetooth support for Broadcom devices
>>   *
>>   *  Copyright (C) 2015  Intel Corporation
>> + *  Copyright (C) 2015  Broadcom Corporation
>>   *
>>   *
>>   *  This program is free software; you can redistribute it and/or modify
>> @@ -32,7 +33,8 @@
>>
>> #define VERSION "0.1"
>>
>> -#define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
>> +#define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00} })
>> +#define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43} })
>
> something funky is going on with your editor that insist on fixing this ;)
>
>>
>> int btbcm_check_bdaddr(struct hci_dev *hdev)
>> {
>> @@ -43,6 +45,7 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
>> 			     HCI_INIT_TIMEOUT);
>> 	if (IS_ERR(skb)) {
>> 		int err = PTR_ERR(skb);
>> +
>
> In this specific case, please do not fix it. I like to keep the simple error path sections small.
>
>> 		BT_ERR("%s: BCM: Reading device address failed (%d)",
>> 		       hdev->name, err);
>> 		return err;
>> @@ -56,10 +59,11 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
>>
>> 	bda = (struct hci_rp_read_bd_addr *)skb->data;
>>
>> -	/* The address 00:20:70:02:A0:00 indicates a BCM20702A0 controller
>> -	 * with no configured address.
>> +	/* Check if the address indicates a controller with no configured
>> +	 * address.
>> 	 */
>> -	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0)) {
>> +	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0) ||
>> +	    !bacmp(&bda->bdaddr, BDADDR_BCM4324B3)) {
>> 		BT_INFO("%s: BCM: Using default device address (%pMR)",
>> 			hdev->name,&bda->bdaddr);
>> 		set_bit(HCI_QUIRK_INVALID_BDADDR,&hdev->quirks);
>> @@ -89,21 +93,14 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>> }
>> EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
>>
>> -int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
>> +int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
>> {
>> 	const struct hci_command_hdr *cmd;
>> -	const struct firmware *fw;
>> 	const u8 *fw_ptr;
>> 	size_t fw_size;
>> 	struct sk_buff *skb;
>> 	u16 opcode;
>> -	int err;
>> -
>> -	err = request_firmware(&fw, firmware,&hdev->dev);
>> -	if (err<  0) {
>> -		BT_INFO("%s: BCM: Patch %s not found", hdev->name, firmware);
>> -		return err;
>> -	}
>> +	int err = 0;
>>
>> 	/* Start Download */
>> 	skb = __hci_cmd_sync(hdev, 0xfc2e, 0, NULL, HCI_INIT_TIMEOUT);
>> @@ -129,8 +126,7 @@ int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
>> 		fw_size -= sizeof(*cmd);
>>
>> 		if (fw_size<  cmd->plen) {
>> -			BT_ERR("%s: BCM: Patch %s is corrupted", hdev->name,
>> -			       firmware);
>> +			BT_ERR("%s: BCM: Patch is corrupted", hdev->name);
>> 			err = -EINVAL;
>> 			goto done;
>> 		}
>> @@ -156,7 +152,6 @@ int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
>> 	msleep(250);
>>
>> done:
>> -	release_firmware(fw);
>> 	return err;
>> }
>> EXPORT_SYMBOL(btbcm_patchram);
>> @@ -168,6 +163,7 @@ static int btbcm_reset(struct hci_dev *hdev)
>> 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
>> 	if (IS_ERR(skb)) {
>> 		int err = PTR_ERR(skb);
>> +
>> 		BT_ERR("%s: BCM: Reset failed (%d)", hdev->name, err);
>> 		return err;
>> 	}
>> @@ -242,9 +238,101 @@ static const struct {
>> 	const char *name;
>> } bcm_uart_subver_table[] = {
>> 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
>> +	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
>> +	{ 0x610c, "BCM4354_003.001.012.0306.0659"}, /* 003.001.012 */
>
> Please just BCM4354 here.
>
> And I have initial patches for the manifest file to map modalias to firmware names. That will then hopefully solve all of these and we can just update this easily from userspace. I will send patches as soon as I have cleaned them up a bit.

Hi Marcel,

Is using modalias sufficient. At least for our wifi chips it is not as 
new chip revisions with same modalias require different firmware. Same 
may be true for bt chips.

Regards,
Arend

> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
