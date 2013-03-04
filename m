Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH 04/11] Bluetooth: Add initial skeleton for asynchronous HCI requests
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130304211603.GB6078@x220.P-661HNU-F1>
Date: Mon, 4 Mar 2013 13:54:01 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CFA5A876-CDAA-4DC4-B236-987AB9804B30@holtmann.org>
References: <1362391748-21653-1-git-send-email-johan.hedberg@gmail.com> <1362391748-21653-5-git-send-email-johan.hedberg@gmail.com> <6E0AA30F-51B6-4876-A77B-BD108357CFE7@holtmann.org> <20130304211603.GB6078@x220.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> +typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u16 last_cmd,
>>> +				   u8 status);
>> 
>> I am now asking myself why would we use something like last_cmd here.
>> I assume this is actually last_opcode and it is not really reliable.
>> If two same opcodes are sent, then this is kinda useless.
> 
> I can't really think of any use case for having two same commands in a
> request since typically the second one would overwrite the effect of the
> first one. The code does (or at least should) support it though but
> admittedly you're right that the complete callback API wouldn't right
> now allow determining exactly which of the multiple commands with the
> same opcode failed (but again, this is a quite wild theoretical
> situation).
> 
>> Do we really need this? Or we might better copy in the failing skb?
> 
> The idea was that neither an opcode nor a status are alone enough for
> the callback to know at what point the request failed. We could just
> have the status, but then it's a bit strange for the callback to get a
> failure status but not know which command failed.
> 
> We could add the failed skb (copied from hdev->sent_cmd) but then that's
> not so friendly for the clients as they'd typically just want to dig out
> the opcode for logging purposes.

fair enough. So lets leave it as is, but lets call the variable something more useful. Either we just call it opcode or if you want to keep the last_ then last_opcode.

And you might want to add a comment above on the semantics here. Since clearly when the status is 0x00, then the opcode should be 0x0000 since there is nothing that went wrong. That said, since the opcode is only useful for the case when one of the command failed, maybe we just re-order it to hdev, status and then opcode to ensure that it is the opcode of the failed command.

Regards

Marcel

