Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH] btusb: fix zero BD address problem during stress test
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3926ae98e84248eaa53999e4d466b189@SC-EXCH04.marvell.com>
Date: Wed, 23 Nov 2016 09:16:04 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cathy Luo <cluo@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>
Message-Id: <0175091F-6B2E-49CE-B099-FC6D35C9C1BF@holtmann.org>
References: <1476795449-20592-1-git-send-email-akarwar@marvell.com>
 <a23725dc02bb48deb00e5f9c8043bc3c@SC-EXCH04.marvell.com>
 <077FBE27-DA84-4F11-BC69-F38184CE6B40@holtmann.org>
 <3926ae98e84248eaa53999e4d466b189@SC-EXCH04.marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

>>>> From: Amitkumar Karwar [mailto:akarwar@marvell.com]
>>>> Sent: Tuesday, October 18, 2016 6:27 PM
>>>> To: linux-bluetooth@vger.kernel.org
>>>> Cc: marcel@holtmann.org; linux-kernel@vger.kernel.org; Cathy Luo;
>>>> Nishant Sarmukadam; Ganapathi Bhat; Amitkumar Karwar
>>>> Subject: [PATCH] btusb: fix zero BD address problem during stress
>>>> test
>>>> 
>>>> From: Ganapathi Bhat <gbhat@marvell.com>
>>>> 
>>>> We came across a corner case issue during reboot stress test in
>> which
>>>> hciconfig shows BD address is all zero. Reason is we don't get
>>>> response for HCI RESET command during initialization
>>>> 
>>>> The issue is tracked to a race where USB subsystem calls
>>>> btusb_intr_complete() to deliver a data(NOOP frame) received on
>>>> interrupt endpoint. HCI_RUNNING flag is not yet set by bluetooth
>>>> subsystem. So we ignore that frame and return.
>>>> 
>>>> As we missed to resubmit the buffer to interrupt endpoint in this
>>>> case, we don't get response for BT reset command downloaded after
>> this.
>>>> 
>>>> This patch handles the corner case to resolve zero BD address
>> problem.
>>>> 
>>>> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
>>>> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
>>>> ---
>>>> drivers/bluetooth/btusb.c | 5 +----
>>>> 1 file changed, 1 insertion(+), 4 deletions(-)
>>>> 
>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>> index 811f9b9..b5596ac 100644
>>>> --- a/drivers/bluetooth/btusb.c
>>>> +++ b/drivers/bluetooth/btusb.c
>>>> @@ -607,10 +607,7 @@ static void btusb_intr_complete(struct urb
>> *urb)
>>>> 	BT_DBG("%s urb %p status %d count %d", hdev->name, urb, urb-
>>>>> status,
>>>> 	       urb->actual_length);
>>>> 
>>>> -	if (!test_bit(HCI_RUNNING, &hdev->flags))
>>>> -		return;
>>>> -
>>>> -	if (urb->status == 0) {
>>>> +	if (urb->status == 0 && test_bit(HCI_RUNNING, &hdev->flags)) {
>>>> 		hdev->stat.byte_rx += urb->actual_length;
>>>> 
>>>> 		if (btusb_recv_intr(data, urb->transfer_buffer,
>>> 
>>> Did you get a chance to check this?
>>> Please let us know if you have any review comments.
>> 
>> can you explain how this is correct and show me the HCI traces for
>> this.
>> 
> 
> I suppose HCI trace means hcidump logs here. As device hasn't yet initialized, hcidump won't show anything.
> We had added debug info in btusb driver to trace the data received on all USB endpoints and also checked usbmon logs.

use btmon and it will show it.

> Here is the sequence of events we observed in a corner case while running stress test.
> 1) Inside btusb_open() call ------ Thread 1
> 2) btusb_submit_intr_urb() submits the URB for receiving data on interrupt endpoint ---- Thread 1
> 3) btusb_intr_complete() gets called to deliver NOP frame from HCI controller ---- Thread 2
> 4) HCI_RUNNING isn't set yet. So we return from btusb_intr_complete() without resubmitting the buffer --- Thread 2
> 5) Exit btusb_open() ---- Thread 1
> 6) "set_bit(HCI_RUNNING, &hdev->flags)" done by bluetooth core ---- Thread 1
> 
> Later HCI_RESET command gets timedout, as we haven't re-submitted buffer for interrupt endpoint in step (4) above.
> 
> Please find attached logs. usbmon log shows first frame received on interrupt endpoint is NOP(Search for Marvell in log).
> 
> Here is what bluetooth spec says about NOP frame.
> 
> "To indicate to the Host that the Controller is ready to receive HCI command packets,
> the Controller generates a Command Status event with Status 0x00 and
> Command_Opcode 0x0000, and the Num_HCI_Command_Packets event
> parameter is set to 1 or more. Command_Opcode, 0x0000 is a NOP (No Operation)”

So I wonder if we need to remove the HCI_RUNNING logic from the drivers. It is only left in a few USB drivers and I removed the rest and moved it into the core. I am not in favour of papering over this issue. I need to understand what is wrong. And actually HCI_RUNNING needs to be taken away from the drivers. So the question is if btusb.c still needs it or if that is just a leftover. Meaning is it protecting anything?

Regards

Marcel
