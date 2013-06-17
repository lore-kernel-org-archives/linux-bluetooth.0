Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130613083240.GB15607@x220>
References: <1369906016-17006-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1369906016-17006-3-git-send-email-mikel.astiz.oss@gmail.com>
	<20130613083240.GB15607@x220>
Date: Mon, 17 Jun 2013 08:50:12 +0200
Message-ID: <CANT-zCUVvfM5CAT3WjZCNL6aq9AA422kzTC83bLXMyA1+1m4Ag@mail.gmail.com>
Subject: Re: [RFC v2 2/2] Bluetooth: Use MITM protection when responding LM
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Timo Mueller <timo.mueller@bmw-carit.de>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Jun 13, 2013 at 10:32 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Thu, May 30, 2013, Mikel Astiz wrote:
>> A MITM protected SSP associaton model can be used for pairing if both
>> local and remote IO capabilities are set to something other than
>> NoInputNoOutput, regardless of the bonding type (dedicated or general).
>>
>> With these IO capabilities a MITM protected SSP association model has
>> been used by the Kernel if we are initiating the pairing process
>> (initiating LM).
>>
>> When responding to a pairing request (remote device is the initiating
>> LM) the pairing should also be proteced against MITM attacks, as
>> proposed in this patch.
>>
>> Signed-off-by: Timo Mueller <timo.mueller@bmw-carit.de>
>> Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
>> ---
>>  net/bluetooth/hci_event.c | 21 +++++++++------------
>>  1 file changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 777a040..ca59623 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -3024,22 +3024,19 @@ unlock:
>>
>>  static u8 hci_get_auth_req(struct hci_conn *conn)
>>  {
>> -     /* If remote requests dedicated bonding follow that lead */
>> -     if ((conn->remote_auth & ~0x01) == HCI_AT_DEDICATED_BONDING) {
>> -             /* If both remote and local IO capabilities allow MITM
>> -              * protection then require it, otherwise don't */
>> -             if (conn->remote_cap == SMP_IO_NO_INPUT_OUTPUT ||
>> -                 conn->io_capability == SMP_IO_NO_INPUT_OUTPUT)
>> -                     return 0x02;
>> -             else
>> -                     return 0x03;
>> -     }
>> -
>>       /* If remote requests no-bonding follow that lead */
>>       if ((conn->remote_auth & ~0x01) == HCI_AT_NO_BONDING)
>>               return conn->remote_auth | (conn->auth_type & 0x01);
>>
>> -     return conn->auth_type;
>> +     /* If both remote and local IO capabilities allow MITM protection
>> +      * then require it
>> +      */
>> +     if (conn->remote_cap != SMP_IO_NO_INPUT_OUTPUT &&
>> +         conn->io_capability != SMP_IO_NO_INPUT_OUTPUT)
>> +             return conn->remote_auth | 0x01;
>> +
>> +     /* No MITM protection possible due to lacking capabilities */
>> +     return conn->remote_auth & ~0x01;
>>  }
>>
>>  static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
>
> Did you test this with acting as pairing initiator too? What worries me
> a bit is the partial removal of reliance on conn->auth_type. It'd also
> be important to verify that this doesn't cause issues with GAP test
> cases using the BITE.

We can double check all the tests we can think of, but unfortunately
we have no access to the BITE.

Regarding the reliance on conn->auth_type, I believe it boils down to
whether the same policy (i.e. use MITM protection when capabilities
allow it) should also be applied to outgoing general bondings. This
patch would affect both incoming and outgoing pairing procedures.

IMO it doesn't make much sense to introduce such a policy for incoming
ones only, based on the intuition that two BlueZ ends would always use
MITM protection as a consequence of the responding end enforcing it.

This seems to suggest a management socket command to enforce MITM
protection and otherwise leave the current behavior. Any thoughts on
this?

As a reminder, the motivation behind this change is that IVI use-cases
require disallowing just-works pairing. MITM protection should always
be used and the pairing will fail (rejected in userland) if the IO
capabilities don't allow it.

Cheers,
Mikel
