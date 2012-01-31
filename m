Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327959331.1955.165.camel@aeonflux>
References: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
	<1327531949-29463-2-git-send-email-andre.guedes@openbossa.org>
	<1327959331.1955.165.camel@aeonflux>
Date: Tue, 31 Jan 2012 10:41:52 -0300
Message-ID: <CACJA=fWWnFA27QGGvoZKU1TrXWWS5jB0e62EaPyjH6DA0G1-xA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] Bluetooth: LE scan should send Discovering events
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jan 30, 2012 at 6:35 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> Send MGMT Discovering events once LE scan starts/stops so the
>> userspace can track when local adapters are discovering LE devices.
>>
>> This way, we also keep the same behavior of inquiry which sends MGMT
>> Discovering events once inquiry starts/stops even if it is triggered
>> by an external tool (e.g. hcitool).
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>>  include/net/bluetooth/hci_core.h |    1 +
>>  net/bluetooth/hci_core.c         |    2 ++
>>  net/bluetooth/hci_event.c        |    5 +++++
>>  3 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 25f449f..4e569d8 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -61,6 +61,7 @@ struct discovery_state {
>>               DISCOVERY_STOPPED,
>>               DISCOVERY_STARTING,
>>               DISCOVERY_INQUIRY,
>> +             DISCOVERY_LE_SCAN,
>>               DISCOVERY_RESOLVING,
>>               DISCOVERY_STOPPING,
>>       } state;
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 91166db..fd22035 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -361,6 +361,7 @@ bool hci_discovery_active(struct hci_dev *hdev)
>>       struct discovery_state *discov = &hdev->discovery;
>>
>>       if (discov->state == DISCOVERY_INQUIRY ||
>> +                                     discov->state == DISCOVERY_LE_SCAN ||
>>                                       discov->state == DISCOVERY_RESOLVING)
>>               return true;
>
> I think we need to start using a switch statement here.

Ok, then I'll have a code refactoring patch to handle this separately.

BR,

Andre
