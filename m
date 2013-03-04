Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Mar 2013 23:16:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 04/11] Bluetooth: Add initial skeleton for asynchronous
 HCI requests
Message-ID: <20130304211603.GB6078@x220.P-661HNU-F1>
References: <1362391748-21653-1-git-send-email-johan.hedberg@gmail.com>
 <1362391748-21653-5-git-send-email-johan.hedberg@gmail.com>
 <6E0AA30F-51B6-4876-A77B-BD108357CFE7@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6E0AA30F-51B6-4876-A77B-BD108357CFE7@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Mar 04, 2013, Marcel Holtmann wrote:
> > +typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u16 last_cmd,
> > +				   u8 status);
> 
> I am now asking myself why would we use something like last_cmd here.
> I assume this is actually last_opcode and it is not really reliable.
> If two same opcodes are sent, then this is kinda useless.

I can't really think of any use case for having two same commands in a
request since typically the second one would overwrite the effect of the
first one. The code does (or at least should) support it though but
admittedly you're right that the complete callback API wouldn't right
now allow determining exactly which of the multiple commands with the
same opcode failed (but again, this is a quite wild theoretical
situation).

> Do we really need this? Or we might better copy in the failing skb?

The idea was that neither an opcode nor a status are alone enough for
the callback to know at what point the request failed. We could just
have the status, but then it's a bit strange for the callback to get a
failure status but not know which command failed.

We could add the failed skb (copied from hdev->sent_cmd) but then that's
not so friendly for the clients as they'd typically just want to dig out
the opcode for logging purposes.

Johan
