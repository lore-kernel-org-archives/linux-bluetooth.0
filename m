Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <C36CBB88-DD0E-41AC-96C6-2A5A63D68F18@holtmann.org>
References: <1362508671-6460-1-git-send-email-johan.hedberg@gmail.com>
	<C36CBB88-DD0E-41AC-96C6-2A5A63D68F18@holtmann.org>
Date: Tue, 5 Mar 2013 17:04:40 -0300
Message-ID: <CACJA=fXFu9Cw5bcu7TkpEgsu42DQJ-RKNdPzOG9-bn5xq1tt5Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Bluetooth: Add asynchronous request support
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel/Johan,

On Tue, Mar 5, 2013 at 4:31 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Johan,
>
>> Here's a v3 of the patch set with Marcel's feedback taken into account.
>>
>> Johan
>>
>> ----------------------------------------------------------------
>> Johan Hedberg (11):
>>      Bluetooth: Rename hci_request to hci_req_sync
>>      Bluetooth: Fix __hci_request() handling of empty requests
>>      Bluetooth: Split HCI init sequence into three stages
>>      Bluetooth: Add initial skeleton for asynchronous HCI requests
>>      Bluetooth: Refactor HCI command skb creation
>>      Bluetooth: Introduce new hci_req_add function
>>      Bluetooth: Fix stand-alone HCI command handling
>>      Bluetooth: Add request cmd_complete and cmd_status functions
>>      Bluetooth: Use async requests internally in hci_req_sync
>>      Bluetooth: Remove unused hdev->init_last_cmd
>>      Bluetooth: Remove empty HCI event handlers
>>
>> include/net/bluetooth/bluetooth.h |   10 +
>> include/net/bluetooth/hci_core.h  |   15 +-
>> net/bluetooth/hci_core.c          |  668 +++++++++++++++++++++++++++++++------
>> net/bluetooth/hci_event.c         |  504 +---------------------------
>> net/bluetooth/hci_sock.c          |    5 +
>> 5 files changed, 603 insertions(+), 599 deletions(-)
>
> I am fine with this patch set now.
>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>
> It would be still good if someone else does a sanity read through and extra testing with this patch set before we push it into bluetooth-next.

I have been reviewing all patch set Johan has sent and I have no
comments so far.

I'm already working on discovery patches so we use this new HCI
request framework to enable/disable LE scanning. If something come up
during testing, I'll let you guys know.

Regards,

Andre
