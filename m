Return-Path: <cyrus@holtmann.org>
Message-ID: <5540EB21.80704@linux.intel.com>
Date: Wed, 29 Apr 2015 16:30:57 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/7] Bluetooth: btbcm: Add bcm_set_baudrate()
References: <1428673066-1349-1-git-send-email-frederic.danis@linux.intel.com> <1428673066-1349-7-git-send-email-frederic.danis@linux.intel.com> <2CB8E093-5FFF-4A9D-A7C0-07F684DDFED4@holtmann.org>
In-Reply-To: <2CB8E093-5FFF-4A9D-A7C0-07F684DDFED4@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 10/04/2015 22:19, Marcel Holtmann wrote:
<snip>
>> +static int bcm_set_clock(struct hci_uart *hu, unsigned char clock)
>> +{
>> +	struct hci_dev *hdev = hu->hdev;
>> +	struct sk_buff *skb;
>> +
>> +	BT_DBG("%s: Set Controller clock (%d)", hdev->name, clock);
>> +
>> +	skb = __hci_cmd_sync(hdev, 0xfc45, 1, &clock, HCI_INIT_TIMEOUT);
>> +	if (IS_ERR(skb)) {
>> +		BT_ERR("%s: failed to write update clock command (%ld)",
>> +		       hdev->name, PTR_ERR(skb));
>> +		return PTR_ERR(skb);
>> +	}
>> +
>> +	if (skb->data[0]) {
>> +		u8 evt_status = skb->data[0];
>> +
>> +		BT_ERR("%s: write update clock event failed (%02x)",
>> +		       hdev->name, evt_status);
>> +		kfree_skb(skb);
>> +		return -bt_to_errno(evt_status);
>> +	}
>> +
>> +	kfree_skb(skb);
>> +
>> +	return 0;
>> +}
>> +
>> +struct hci_cp_bcm_set_speed {
>> +	__le16   dummy;
>> +	__le32   speed;
>> +} __packed;
>> +
>> +static int bcm_set_baudrate(struct hci_uart *hu, int speed)
>> +{
>> +	struct hci_dev *hdev = hu->hdev;
>> +	struct sk_buff *skb;
>> +	struct hci_cp_bcm_set_speed param = { 0, cpu_to_le32(speed) };
>> +
>> +	if (speed > 3000000 && bcm_set_clock(hu, BCM43XX_CLOCK_48))
>> +		return -EINVAL;
>
> Please just fold this in to this function. I prefer if you can read the changes like a sequence of actions that have to happen.

OK, I will move bcm_set_clock code to bcm_set_baudrate

> Also curious is when we fallback to default baudrate, do we have to change the clock back to 24?

Currently, controller speed is set back to default baudrate by firmware 
loading. hci_bcm do not set it explicitly.

>> +
>> +	BT_DBG("%s: Set Controller UART speed to %d bit/s", hdev->name, speed);
>> +
>> +	skb = __hci_cmd_sync(hdev, 0xfc18, sizeof(param), &param,
>> +			     HCI_INIT_TIMEOUT);
>> +	if (IS_ERR(skb)) {
>> +		BT_ERR("%s: failed to write update baudrate command (%ld)",
>> +		       hdev->name, PTR_ERR(skb));
>> +		return PTR_ERR(skb);
>> +	}
>> +
>> +	if (skb->data[0]) {
>> +		u8 evt_status = skb->data[0];
>
> This part seems a bit duplicated. I actually wonder if we should change __hci_cmd_sync to also handle command complete events and just extract the error/status for us. I have done it that way in userspace and the command complete return response parameters are guaranteed to have status as their first parameter. So it is doable. Do you mind looking into that.

OK, I will send a patch adding a status parameter to __hci_cmd_sync.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

