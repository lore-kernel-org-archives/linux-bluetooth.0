Return-Path: <cyrus@holtmann.org>
Message-ID: <55284425.5010403@hurleysoftware.com>
Date: Fri, 10 Apr 2015 17:44:05 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 Frederic Danis <frederic.danis@linux.intel.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/7] Bluetooth: btbcm: Add bcm_set_baudrate()
References: <1428673066-1349-1-git-send-email-frederic.danis@linux.intel.com> <1428673066-1349-7-git-send-email-frederic.danis@linux.intel.com> <2CB8E093-5FFF-4A9D-A7C0-07F684DDFED4@holtmann.org>
In-Reply-To: <2CB8E093-5FFF-4A9D-A7C0-07F684DDFED4@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/10/2015 04:19 PM, Marcel Holtmann wrote:
> Hi Fred,
> 
>> Add vendor specific command to change controller device speed.
>>
>> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
>> ---
>> drivers/bluetooth/hci_bcm.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 71 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index 25c9883..7308cf4 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -24,6 +24,7 @@
>> #include <linux/kernel.h>
>> #include <linux/errno.h>
>> #include <linux/skbuff.h>
>> +#include <linux/tty.h>
>>
>> #include <net/bluetooth/bluetooth.h>
>> #include <net/bluetooth/hci_core.h>
>> @@ -31,11 +32,80 @@
>> #include "btbcm.h"
>> #include "hci_uart.h"
>>
>> +#define BCM43XX_CLOCK_48 1
>> +#define BCM43XX_CLOCK_24 2
>> +
>> struct bcm_data {
>> 	struct sk_buff *rx_skb;
>> 	struct sk_buff_head txq;
>> };
>>
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
> 
> Also curious is when we fallback to default baudrate, do we have to change the clock back to 24?
> 
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
> This part seems a bit duplicated. I actually wonder if we should change __hci_cmd_sync to also handle command complete events and just extract the error/status for us.

So the hci sends command complete at the old line rate?


> I have done it that way in userspace and the command complete return response parameters are guaranteed to have status as their first parameter. So it is doable. Do you mind looking into that.
