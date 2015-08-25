Return-Path: <cyrus@holtmann.org>
Message-ID: <55DC87EB.2050104@intel.com>
Date: Tue, 25 Aug 2015 17:21:15 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Bluetooth: hci_intel: Add Intel baudrate configuration
 support
References: <1440165583-23245-1-git-send-email-loic.poulain@intel.com> <5D898BFA-B6C2-47DC-9DC4-DB3EDECA2E23@holtmann.org> <55DC2ABE.7090107@intel.com> <FC07D45C-7D4E-466A-A16B-B7DE84CF01B3@holtmann.org>
In-Reply-To: <FC07D45C-7D4E-466A-A16B-B7DE84CF01B3@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>



On 25/08/2015 16:52, Marcel Holtmann wrote:
> Hi Loic,
>
>>>> +
>>>> +	set_bit(STATE_SPEED_CHANGING, &intel->flags);
>>>> +
>>>> +	skb = __hci_cmd_sync(hdev, 0xfc06, 1, &intel_speed, HCI_INIT_TIMEOUT);
>>>> +	if (IS_ERR(skb)) {
>>>> +		BT_ERR("%s: Changing Intel speed failed (%ld)",
>>>> +		       hdev->name, PTR_ERR(skb));
>>>> +		clear_bit(STATE_SPEED_CHANGING, &intel->flags);
>>>> +		return PTR_ERR(skb);
>>>> +	}
>>>
>>> I think this approach is wrong. It is not that the controller sends no HCI Command Complete. It is just that it sends it later and we have to change the baud rate in between.
>>>
>>> This is different from the case where the controller swallows the HCI Command Complete event altogether. So instead of trying to hack around this, why not just insert the HCI command into the queue like the QCA guys did. We have no chance of checking that it worked anyway.
>>
>> I sent the speed command with hci_cmd_sync so that it pass through the hci core and can be monitored (btmon/hcidump). But I'm ok for directly enqueueing the packet.
>
> lets enqueue in manually first. And then we need to add a __hci_cmd_send that just sends a packet without waiting for its command status/complete. Then we fix the Intel driver and the Qualcomm driver.
>
>>>> +
>>>> +	kfree_skb(skb);
>>>> +
>>>> +	/* wait 100ms to change baudrate on controller side */
>>>> +	msleep(100);
>>>> +
>>>> +	clear_bit(STATE_SPEED_CHANGING, &intel->flags);
>>>
>>> If we just inject the command into the local queue and wakeup the processing, then the speed change state tracking for sending should go away. However we could keep it for waiting for the HCI Command Complete that indicates the success. And then continue. The msleep would then not be needed.
>>
>> I also use this flag to ignore incoming data during speed transition.
>> It avoids to retrieve unexpected/corrupted data.
>> I agree that we should manage the response, however it requires some play with CTS/RTS and hci_uart_set_baudrate. I will keep it simple for now, having the same solution as QCA.
>
> We are required to change UART settings anyway. At least that is what I remember from the vendor specification here. If we get corrupted data, then that is pretty bad.

Sure, but the question is how do you know that command has been fully 
transmitted on the UART PHY (from hci_intel)?

-- 
Intel Open Source Technology Center
http://oss.intel.com/
