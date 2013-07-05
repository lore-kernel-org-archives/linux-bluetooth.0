Return-Path: <cyrus@holtmann.org>
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>,
	Tedd Ho-Jeong An <tedd.an@intel.com>,
	<linux-bluetooth@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	"Grumbach\, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: autosuspend issues with the Intel Bluetooth device [8087:07dc]
References: <Pine.LNX.4.44L0.1307041024140.21341-100000@netrider.rowland.org>
Date: Fri, 05 Jul 2013 12:59:40 +0200
In-Reply-To: <Pine.LNX.4.44L0.1307041024140.21341-100000@netrider.rowland.org>
	(Alan Stern's message of "Thu, 4 Jul 2013 10:32:12 -0400 (EDT)")
Message-ID: <87obahjmqr.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Alan Stern <stern@rowland.harvard.edu> writes:
> On Thu, 4 Jul 2013, Bjørn Mork wrote:
>
>> > It may be that the device simply takes longer to resume than it should.  
>> > Or longer than btusb expects it to, which may not be the same thing.
>> 
>> Yes, that is what it looks like.  But the URBs are submitted as part of
>> the resume callback.  Shouldn't the device be alive and kicking when
>> this is called?  At least from the USB point of view, which is all the
>> driver can possibly know anything about? Is the problem that the
>> firmware finishes the USB resume before actually being ready to respond
>> to the HCI command?
>
> I don't know.  The USB spec gives devices 10 ms to recover during a 
> resume; after that they are supposed to be ready to operate normally.  
> This delay is already built into usbcore and it is visible in your 
> usbmon trace.
>
> There is one notable difference between your failure and success 
> traces.  Failure:
>
>> ffff88021ace62c0 3675041611 S Co:002:00 s 20 00 0000 0000 0003 3 = 011000
>> ffff88022228d140 3675041721 S Co:002:00 s 01 0b 0000 0001 0000 0
>> ffff88021ace62c0 3675042361 C Co:002:00 0 3 >
>> ffff88022228d140 3675042409 C Co:002:00 0 0
>> ffff88020c40f380 3675043359 C Ii:002:01 0 6 = 0f040101 010b
>> ffff88020c40f380 3675043429 S Ii:002:01 -115 64 <
>
> Success:
>
>> ffff88020c40f200 88163963 S Co:002:00 s 20 00 0000 0000 0003 3 = 011000
>> ffff88020c752980 88165215 C Ii:002:01 0 14 = 0e0c0101 10000600 05060200 0005
>> ffff88020c752980 88165281 S Ii:002:01 -115 64 <
>> ffff88020c40f200 88165327 C Co:002:00 0 3 >
>
> In the failure case, a Set-Interface request gets sent before the 
> interrupt URB completes.  Maybe that accounts for the unexpected 
> behavior.

Maybe.  But the device does send a message which translates as a valid
HCI message, so it looks like everything is OK up to and including the
USB layer.

I tried to figure out the exact meaning of that message, but that's not
straight forward unless you are familiar with the Bluetooth specs. Which
I'm certainly not.  What I did find out is only what the HCI debug code
also could tell me:

 0f - HCI_EV_CMD_STATUS
 04 - length: 4
 01 - status: 1
 01 - ncmds: 1
 010b - opcode: 0x0b01

Enabling the dynamic debugging in hci_core and hci_event makes this
clear, along with the fact that HCI core ignores this event:


Jul  5 12:27:21 nemi kernel: [44750.608222] btusb_tx_complete:574: hci1 urb ffff880231a10c00 status 0 count 3
Jul  5 12:27:21 nemi kernel: [44750.609223] btusb_intr_complete:281: hci1 urb ffff880231a109c0 status 0 count 6
Jul  5 12:27:21 nemi kernel: [44750.609297] hci_rx_work:3463: hci1
Jul  5 12:27:21 nemi kernel: [44750.609346] hci_rx_work:3492: hci1 Event packet
Jul  5 12:27:21 nemi kernel: [44750.609361] hci_cmd_status_evt:2418: hci1 opcode 0x0b01
Jul  5 12:27:21 nemi kernel: [44750.609371] hci_req_cmd_complete:3406: opcode 0x0b01 status 0x01
Jul  5 12:27:21 nemi kernel: [44750.609641] hci_dev_get:691: 1


The "hci_cmd_status_evt" message shows that we hit the default
do-nothing handler for events unknown to hci_event.c.  For some reason
this cancels the command timer:

	if (opcode != HCI_OP_NOP)
		del_timer(&hdev->cmd_timer);

But changing that only leads to the timer expiring ang logging

Jul  5 12:27:23 nemi kernel: [44752.532142] Bluetooth: hci1 command 0x1001 tx timeout
Jul  5 12:27:23 nemi kernel: [44752.532233] hci_cmd_work:3519: hci1 cmd_cnt 1 cmd queued 0

a few seconds later (0x1001 is HCI_OP_READ_LOCAL_VERSION, so that's the
command we're waiting for). Proper handling of the 0x0b01 event is most
likely required to continue here.

I do assume the device means to signal something by sending that 0x0b01
event, and based on the observed behaviour and existing code I guess
that something translates to "not ready yet - please resend last
command" or similar.  But I haven't been able to find any definition of
that event anywhere, so this is based on pure speculation.

Anyway, unless someone from the Bluetooth list shouts out, then I am
going to conclude that the device, USB core and btusb all behave
correctly, but that waking up this device (and likely other recent
devices) can fail because the HCI core fails to handle a link state
event it should handle.

I don't have any proposed fix, except ugly hacks to let the device have
some more time.  So I am hoping someone knowing Bluetooth will come up
with better ideas.



Bjørn
