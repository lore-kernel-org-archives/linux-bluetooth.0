Return-Path: <cyrus@holtmann.org>
Message-ID: <55535B6B.9080509@linux.intel.com>
Date: Wed, 13 May 2015 16:10:51 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/5] Bluetooth: btbcm: Add BCM4324B3 UART device
References: <1431008699-6419-1-git-send-email-frederic.danis@linux.intel.com> <1431008699-6419-2-git-send-email-frederic.danis@linux.intel.com> <332D4EB4-3FCB-4CE4-9BF1-6156FA267227@holtmann.org>
In-Reply-To: <332D4EB4-3FCB-4CE4-9BF1-6156FA267227@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 07/05/2015 18:19, Marcel Holtmann wrote:
> Hi Fred,
>
> you might want to add a commit message. I dislike patches without commit messages. Explain what you are doing and why.

OK

>> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
>> ---
>> drivers/bluetooth/btbcm.c | 7 +++++++
>> 1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>> index 5635d6d..b258454 100644
>> --- a/drivers/bluetooth/btbcm.c
>> +++ b/drivers/bluetooth/btbcm.c
>> @@ -33,6 +33,7 @@
>> #define VERSION "0.1"
>>
>> #define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
>> +#define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
>
> So you have hardware that comes up with this default address? No matter what hardware you pick?

On a t100, before firmware upload I get a random address, changing at 
each reboot. After firmware upload, I always get this address which 
seems to be hard-coded in firmware file.

>>
>> int btbcm_check_bdaddr(struct hci_dev *hdev)
>> {
>> @@ -71,6 +72,10 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
>> 		BT_INFO("%s: BCM: Using default device address (%pMR)",
>> 			hdev->name, &bda->bdaddr);
>> 		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
>> +	} else if (!bacmp(&bda->bdaddr, BDADDR_BCM4324B3)) {
>
>> +		BT_INFO("%s: BCM: Using default device address (%pMR)",
>> +			hdev->name, &bda->bdaddr);
>> +		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
>
> Just check for !bacmp || !bacmp instead of else if. No need to duplicate the error message and the quirk setting.

OK

>> 	}
>>
>> 	kfree_skb(skb);
>> @@ -251,6 +256,7 @@ static const struct {
>> 	const char *name;
>> } bcm_uart_subver_table[] = {
>> 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
>> +	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
>> 	{ }
>
> Please also send userspace patches for adding this entry to the table.

OK, I will send a patch for monitor/packet.c.

>> };
>>
>> @@ -305,6 +311,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
>>
>> 	switch ((rev & 0xf000) >> 12) {
>> 	case 0:
>> +	case 3:
>> 		for (i = 0; bcm_uart_subver_table[i].name; i++) {
>> 			if (subver == bcm_uart_subver_table[i].subver) {
>> 				hw_name = bcm_uart_subver_table[i].name;

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation
