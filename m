Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH] btusb: fix zero BD address problem during stress test
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <f0afbe5b5ac3434492d18002e875a019@SC-EXCH04.marvell.com>
Date: Wed, 7 Dec 2016 10:07:41 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cathy Luo <cluo@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>
Message-Id: <1B176E2E-C681-468B-90A1-B26AB5B0D91A@holtmann.org>
References: <1476795449-20592-1-git-send-email-akarwar@marvell.com>
 <a23725dc02bb48deb00e5f9c8043bc3c@SC-EXCH04.marvell.com>
 <077FBE27-DA84-4F11-BC69-F38184CE6B40@holtmann.org>
 <3926ae98e84248eaa53999e4d466b189@SC-EXCH04.marvell.com>
 <0175091F-6B2E-49CE-B099-FC6D35C9C1BF@holtmann.org>
 <f0afbe5b5ac3434492d18002e875a019@SC-EXCH04.marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

>>>>>>>> From: Amitkumar Karwar [mailto:akarwar@marvell.com]
>>>>>>>> Sent: Tuesday, October 18, 2016 6:27 PM
>>>>>>>> To: linux-bluetooth@vger.kernel.org
>>>>>>>> Cc: marcel@holtmann.org; linux-kernel@vger.kernel.org; Cathy
>>> Luo;
>>>>>>>> Nishant Sarmukadam; Ganapathi Bhat; Amitkumar Karwar
>>>>>>>> Subject: [PATCH] btusb: fix zero BD address problem during
>>> stress
>>>>>>>> test
>>>>>>>> 
>>>>>>>> From: Ganapathi Bhat <gbhat@marvell.com>
>>>>>>>> 
>>>>>>>> We came across a corner case issue during reboot stress test
>> in
>>>>>> which
>>>>>>>> hciconfig shows BD address is all zero. Reason is we don't get
>>>>>>>> response for HCI RESET command during initialization
>>>>>>>> 
>>>>>>>> The issue is tracked to a race where USB subsystem calls
>>>>>>>> btusb_intr_complete() to deliver a data(NOOP frame) received
>> on
>>>>>>>> interrupt endpoint. HCI_RUNNING flag is not yet set by
>>>>>>>> bluetooth subsystem. So we ignore that frame and return.
>>>>>>>> 
>>>>>>>> As we missed to resubmit the buffer to interrupt endpoint in
>>> this
>>>>>>>> case, we don't get response for BT reset command downloaded
>>> after
>>>>>> this.
>>>>>>>> 
>>>>>>>> This patch handles the corner case to resolve zero BD address
>>>>>> problem.
>>>>>>>> 
>>>>>>>> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
>>>>>>>> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
>>>>>>>> ---
>>>>>>>> drivers/bluetooth/btusb.c | 5 +----
>>>>>>>> 1 file changed, 1 insertion(+), 4 deletions(-)
>>>>>>>> 
>>>>>>>> diff --git a/drivers/bluetooth/btusb.c
>>>>>>>> b/drivers/bluetooth/btusb.c index 811f9b9..b5596ac 100644
>>>>>>>> --- a/drivers/bluetooth/btusb.c
>>>>>>>> +++ b/drivers/bluetooth/btusb.c
>>>>>>>> @@ -607,10 +607,7 @@ static void btusb_intr_complete(struct
>> urb
>>>>>> *urb)
>>>>>>>> 	BT_DBG("%s urb %p status %d count %d", hdev->name, urb,
>>> urb-
>>>>>>>>> status,
>>>>>>>> 	       urb->actual_length);
>>>>>>>> 
>>>>>>>> -	if (!test_bit(HCI_RUNNING, &hdev->flags))
>>>>>>>> -		return;
>>>>>>>> -
>>>>>>>> -	if (urb->status == 0) {
>>>>>>>> +	if (urb->status == 0 && test_bit(HCI_RUNNING, &hdev-
>>>>> flags)) {
>>>>>>>> 		hdev->stat.byte_rx += urb->actual_length;
>>>>>>>> 
>>>>>>>> 		if (btusb_recv_intr(data, urb->transfer_buffer,
>>>>>>> 
>>>>>>> Did you get a chance to check this?
>>>>>>> Please let us know if you have any review comments.
>>>>>> 
>>>>>> can you explain how this is correct and show me the HCI traces
>>>>>> for this.
>>>>>> 
>>>>> 
>>>>> I suppose HCI trace means hcidump logs here. As device hasn't yet
>>>> initialized, hcidump won't show anything.
>>>>> We had added debug info in btusb driver to trace the data
>> received
>>>>> on
>>>> all USB endpoints and also checked usbmon logs.
>>>> 
>>>> use btmon and it will show it.
>>>> 
>>>>> Here is the sequence of events we observed in a corner case while
>>>> running stress test.
>>>>> 1) Inside btusb_open() call ------ Thread 1
>>>>> 2) btusb_submit_intr_urb() submits the URB for receiving data on
>>>>> interrupt endpoint ---- Thread 1
>>>>> 3) btusb_intr_complete() gets called to deliver NOP frame from
>> HCI
>>>>> controller ---- Thread 2
>>>>> 4) HCI_RUNNING isn't set yet. So we return from
>>>>> btusb_intr_complete() without resubmitting the buffer --- Thread
>> 2
>>>>> 5) Exit btusb_open() ---- Thread 1
>>>>> 6) "set_bit(HCI_RUNNING, &hdev->flags)" done by bluetooth core
>>>>> ---- Thread 1
>>>>> 
>>>>> Later HCI_RESET command gets timedout, as we haven't re-submitted
>>>> buffer for interrupt endpoint in step (4) above.
>>>>> 
>>>>> Please find attached logs. usbmon log shows first frame received
>>>>> on
>>>> interrupt endpoint is NOP(Search for Marvell in log).
>>>>> 
>>>>> Here is what bluetooth spec says about NOP frame.
>>>>> 
>>>>> "To indicate to the Host that the Controller is ready to receive
>>> HCI
>>>>> command packets, the Controller generates a Command Status event
>>>>> with Status 0x00 and Command_Opcode 0x0000, and the
>>>> Num_HCI_Command_Packets
>>>>> event parameter is set to 1 or more. Command_Opcode, 0x0000 is a
>>> NOP
>>>> (No Operation)”
>>>> 
>>>> So I wonder if we need to remove the HCI_RUNNING logic from the
>>>> drivers. It is only left in a few USB drivers and I removed the
>> rest
>>>> and moved it into the core. I am not in favour of papering over
>> this
>>>> issue. I need to understand what is wrong. And actually HCI_RUNNING
>>>> needs to be taken away from the drivers. So the question is if
>>> btusb.c
>>>> still needs it or if that is just a leftover. Meaning is it
>>> protecting
>>>> anything?
>>>> 
>>> 
>>> I can see HCI_RUNNING check being used at below places in btusb.c
>>> 
>>> 1) btusb_intr_complete
>>> 2) btusb_bulk_complete
>>> 3) btusb_isoc_complete
>>> 4) btusb_tx_complete
>>> 5) btusb_isoc_tx_complete
>>> 6) btusb_bcm_set_diag
>>> 7) btusb_resume
>>> 
>>> I think, it can be removed from (1), (2) and (3), as we already have
>>> below check inside hci_recv_frame()
>>> 
>>>        if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
>>>                      && !test_bit(HCI_INIT, &hdev->flags))) {
>>>                kfree_skb(skb);
>>>                return -ENXIO;
>>>        }
>>> 
>>> For (4) and (5), it's just used to decide if we should update "hdev-
>>>> stat" or not.
>>> 
>> 
>> Please guide on how should we fix this issue. We observe timeout for
>> HCI_RESET command sometimes when system is booted. This happens due to
>> missing urb_submitt() when first frame(NOP) received on INT endpoint is
>> ignored. Below change would also help.
>> 
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1318,12 +1318,13 @@ static int hci_dev_do_open(struct hci_dev
>> *hdev)
>>                goto done;
>>        }
>> 
>> +       set_bit(HCI_RUNNING, &hdev->flags);
>>        if (hdev->open(hdev)) {
>> +               clear_bit(HCI_RUNNING, &hdev->flags);
>>                ret = -EIO;
>>                goto done;
>>        }
>> 
>> -       set_bit(HCI_RUNNING, &hdev->flags);
>>        hci_sock_dev_event(hdev, HCI_DEV_OPEN);
> 
> How can we proceed on this? I'm not much familiar with btusb driver, so not sure if HCI_RUNNING logic can be completely removed.
> Meanwhile could you accept proposed fix in this patch for the potential issue we spotted during stress tests.
> 
> The change doesn't have any side-effects. During teardown, race between btusb_close() and btusb_intr_complete() is appropriately taken care of with the help of BTUSB_INTR_RUNNING flag.

so what is the downside of just replacing all HCI_RUNNING with the appropriate BTUSB_INTR_RUNNING, BTUSB_BULK_RUNNING etc.?

Regards

Marcel
