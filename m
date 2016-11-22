Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH] btusb: fix zero BD address problem during stress test
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <a23725dc02bb48deb00e5f9c8043bc3c@SC-EXCH04.marvell.com>
Date: Tue, 22 Nov 2016 22:55:10 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cathy Luo <cluo@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>
Message-Id: <077FBE27-DA84-4F11-BC69-F38184CE6B40@holtmann.org>
References: <1476795449-20592-1-git-send-email-akarwar@marvell.com>
 <a23725dc02bb48deb00e5f9c8043bc3c@SC-EXCH04.marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

>> From: Amitkumar Karwar [mailto:akarwar@marvell.com]
>> Sent: Tuesday, October 18, 2016 6:27 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: marcel@holtmann.org; linux-kernel@vger.kernel.org; Cathy Luo;
>> Nishant Sarmukadam; Ganapathi Bhat; Amitkumar Karwar
>> Subject: [PATCH] btusb: fix zero BD address problem during stress test
>> 
>> From: Ganapathi Bhat <gbhat@marvell.com>
>> 
>> We came across a corner case issue during reboot stress test in which
>> hciconfig shows BD address is all zero. Reason is we don't get response
>> for HCI RESET command during initialization
>> 
>> The issue is tracked to a race where USB subsystem calls
>> btusb_intr_complete() to deliver a data(NOOP frame) received on
>> interrupt endpoint. HCI_RUNNING flag is not yet set by bluetooth
>> subsystem. So we ignore that frame and return.
>> 
>> As we missed to resubmit the buffer to interrupt endpoint in this case,
>> we don't get response for BT reset command downloaded after this.
>> 
>> This patch handles the corner case to resolve zero BD address problem.
>> 
>> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
>> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
>> ---
>> drivers/bluetooth/btusb.c | 5 +----
>> 1 file changed, 1 insertion(+), 4 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 811f9b9..b5596ac 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -607,10 +607,7 @@ static void btusb_intr_complete(struct urb *urb)
>> 	BT_DBG("%s urb %p status %d count %d", hdev->name, urb, urb-
>>> status,
>> 	       urb->actual_length);
>> 
>> -	if (!test_bit(HCI_RUNNING, &hdev->flags))
>> -		return;
>> -
>> -	if (urb->status == 0) {
>> +	if (urb->status == 0 && test_bit(HCI_RUNNING, &hdev->flags)) {
>> 		hdev->stat.byte_rx += urb->actual_length;
>> 
>> 		if (btusb_recv_intr(data, urb->transfer_buffer,
> 
> Did you get a chance to check this?
> Please let us know if you have any review comments.

can you explain how this is correct and show me the HCI traces for this.

Regards

Marcel
