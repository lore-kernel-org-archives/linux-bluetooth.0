Return-Path: <cyrus@holtmann.org>
Message-ID: <55703D8F.6010602@intel.com>
Date: Thu, 04 Jun 2015 13:59:11 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: tedd.an@intel.com
CC: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: btusb: Fix Intel controller hang after shutdown
References: <1432218957-3400-1-git-send-email-loic.poulain@intel.com> <69A96222-5518-4341-9F0B-32F3CEACCC35@holtmann.org>
In-Reply-To: <69A96222-5518-4341-9F0B-32F3CEACCC35@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi tedd,

On 21/05/2015 21:56, Marcel Holtmann wrote:
> Hi Tedd,
>
>> The vendor command (0xfc3f) in btusb_shutdown_intel causes an internal
>> reset with old firmware. After that, upcoming HCI command will hang due
>> to a controller bug with the first HCI command sent to it.
>> The workaround is to send HCI Reset command first which will reset the
>> number of completed commands.
>>
>> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
>> ---
>> v2: Send HCI reset from shutdown instead of using HCI_QUIRK_RESET_ON_CLOSE
>> drivers/bluetooth/btusb.c | 13 +++++++++++++
>> 1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index d21f3b4..589f30c 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -2705,6 +2705,19 @@ static int btusb_shutdown_intel(struct hci_dev *hdev)
>> 	}
>> 	kfree_skb(skb);
>>
>> +	/* The 0xfc3f command causes an internal reset with old firmware.
>> +	 * In order to avoid the Bug with the first HCI command, we have
>> +	 * to send a HCI reset which will reset the number of completed
>> +	 * command.
>> +	 */
>> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
>> +	if (IS_ERR(skb)) {
>> +		BT_ERR("%s: Shutdown HCI reset command failed (%ld)",
>> +			hdev->name, PTR_ERR(skb));
>> +		return PTR_ERR(skb);
>> +	}
>> +	kfree_skb(skb);
>> +
> please test this change and see if it still has the desired effect. ACK or NACK the patch based on your testing.
>
> Regards
>
> Marcel
>

Any chance you test this patch?

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/
