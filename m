Return-Path: <david@lechnology.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_ll: add support for setting public
 address
To: Marcel Holtmann <marcel@holtmann.org>
Cc: devicetree <devicetree@vger.kernel.org>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1512701860-8321-1-git-send-email-david@lechnology.com>
 <1512701860-8321-2-git-send-email-david@lechnology.com>
 <8B6C3CFA-35C6-4A9B-90AB-22834B9AE2C4@holtmann.org>
From: David Lechner <david@lechnology.com>
Message-ID: <1a106ed6-1408-4d0b-9c9d-5a3058d6df2d@lechnology.com>
Date: Fri, 8 Dec 2017 13:21:17 -0600
MIME-Version: 1.0
In-Reply-To: <8B6C3CFA-35C6-4A9B-90AB-22834B9AE2C4@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 12/08/2017 02:07 AM, Marcel Holtmann wrote:
> Hi David,
> 
>> This adds support for setting the public address on Texas Instruments
>> Bluetooth chips using a vendor-specific command.
>>
>> This has been tested on a CC2560A. The TI wiki also indicates that this
>> command should work on TI WL17xx/WL18xx Bluetooth chips.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>
>> v2 changes:
>> * This is a new patch in v2
>>
>> drivers/bluetooth/hci_ll.c | 17 +++++++++++++++++
>> 1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
>> index 974a788..b732004 100644
>> --- a/drivers/bluetooth/hci_ll.c
>> +++ b/drivers/bluetooth/hci_ll.c
>> @@ -57,6 +57,7 @@
>> #include "hci_uart.h"
>>
>> /* Vendor-specific HCI commands */
>> +#define HCI_VS_WRITE_BD_ADDR			0xfc06
>> #define HCI_VS_UPDATE_UART_HCI_BAUDRATE		0xff36
>>
>> /* HCILL commands */
>> @@ -662,6 +663,20 @@ static int download_firmware(struct ll_device *lldev)
>> 	return err;
>> }
>>
>> +static int ll_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>> +{
>> +	bdaddr_t bdaddr_swapped;
>> +	struct sk_buff *skb;
>> +
>> +	baswap(&bdaddr_swapped, bdaddr);
>> +	skb = __hci_cmd_sync(hdev, HCI_VS_WRITE_BD_ADDR, sizeof(bdaddr_t),
>> +			     &bdaddr_swapped, HCI_INIT_TIMEOUT);
>> +	if (!IS_ERR(skb))
>> +		kfree_skb(skb);
>> +	
> 
> You have a trailing whitespace here.
> 
> Does the HCI command really expect the BD_ADDR in the swapped order. The caller of hdev->set_bdaddr while provide it in the same order as the HCI Read BD Address command and everything in HCI. So it seems odd that you have to swap it for the vendor command.
> 
> So have you actually tested this with btmgmt public-add <xx:xx..> and checked that the address comes out correctly. I think ll_set_bdaddr should function correctly for the mgmt interface. And if needed any other caller outside of mgmt has to do the swapping.
> 

I did test using btmgmt public-address 00:11:22:33:44:55, which is how I 
found out that the order needed to be swapped. Like you, I was 
surprised. I couldn't find any documentation from TI saying what the 
order is supposed to be, so I can only assume that because this works, 
it is indeed correct as-is.
