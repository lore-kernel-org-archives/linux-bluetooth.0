Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <FFFBE407-5596-4302-9219-FA462620CBF7@holtmann.org>
References: <1436791005-2894-1-git-send-email-jpawlowski@google.com>
	<FFFBE407-5596-4302-9219-FA462620CBF7@holtmann.org>
Date: Thu, 30 Jul 2015 14:15:20 +0200
Message-ID: <CAD0=r8wVRCuL0pOQBHW9-RVyhOTkT3mb3276M-AH6MWRhTT96A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix Add Device response status
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 30, 2015 at 1:54 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jakub,
>
>> Make sure that MGMT_STATUS_INVALID_PARAMS is returned when non identity
>> address is passed to ADD_DEVICE. Right now MGMT_STATUS_FAILED is
>> returned, which might be misleading.
>>
>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>> ---
>> net/bluetooth/mgmt.c | 7 +++++++
>> 1 file changed, 7 insertions(+)
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 7998fb2..47462bf 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -6226,6 +6226,13 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
>>       else
>>               auto_conn = HCI_AUTO_CONN_REPORT;
>>
>> +     /* Allow only identity addresses */
>> +     if (!hci_is_identity_address(&cp->addr.bdaddr, addr_type)) {
>> +             err = cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
>> +             mgmt_pending_remove(cmd);
>> +             goto unlock;
>> +     }
>> +
>
> did we loose this patch or is it no longer needed?
>
It's no longer needed, it was squashed with other patch.
Thanks,
Jakub
> Regards
>
> Marcel
>
