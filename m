Return-Path: <cyrus@holtmann.org>
Message-ID: <4FB4B13D.1010302@tieto.com>
Date: Thu, 17 May 2012 10:05:17 +0200
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2] Bluetooth: Use hci_conn data to handle failed LE Connection
 Complete
References: <1337201737-5983-1-git-send-email-andrzej.kaczmarek@tieto.com>  <1337202331.5970.269.camel@aeonflux>  <CA+6KyKZ0vrPHoXXfWwJdiVLDR+59azRwWMhJbjndM+Aw_dKSwA@mail.gmail.com> <1337204910.5970.271.camel@aeonflux>
In-Reply-To: <1337204910.5970.271.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 16.05.2012 23:48, Marcel Holtmann wrote:
>>>>        hci_dev_lock(hdev);
>>>>
>>>> +     if (ev->status) {
>>>> +             conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
>>>> +             if (!conn)
>>>> +                     goto unlock;
>>>> +
>>>> +             mgmt_connect_failed(hdev,&conn->dst, conn->type,
>>>> +                                 conn->dst_type, ev->status);
>>>> +             hci_proto_connect_cfm(conn, ev->status);
>>>> +             conn->state = BT_CLOSED;
>>>> +             hci_conn_del(conn);
>>>> +             goto unlock;
>>>> +     }
>>>> +
>>>>        conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,&ev->bdaddr);
>>>>        if (!conn) {
>>>>                conn = hci_conn_add(hdev, LE_LINK,&ev->bdaddr);
>>>
>>> this change is wrong. We are now treating every single adapter as being
>>> broken. That is not acceptable.
>>
>> Why do you think these adapters are broken? As I explained in cover
>> letter for v1, spec does not require peer address to be provided in
>> Connection Complete which is reasonable since we can only have one
>> pending connection request. Also as Claudio and Andre noticed such
>> behaviour could be to simplify whitelist implementation - in case of
>> connection request using whitelist it does not make sense to include
>> specific peer address in event.
>
> what has whitelist behavior to do with this event in the failure case?

Just a sidenote on why some vendors may want to omit BD_ADDR and it does 
not make adapter broken. Not directly related to this scenario.

>>> We should only add a tweak if the BD_ADDR parameter is BDADDR_ANY and
>>> not as a general rule. In addition if we do this, we need to print a
>>> warning to dmesg to make this known.
>>
>> Perhaps we can just add warning in case BD_ADDR is not BDADDR_ANY and
>> we cannot find hci_conn for it - in such case most probably something
>> went wrong.
>
> What are the adapters from Broadcom, CSR, TI and ST are returning in a
> failure case? Are they all omitting the BD_ADDR value?

No, I noticed this on BCM and based on previous comments it seems that 
this is what BCM and ST(E) are doing while CSR and TI return BD_ADDR. 
Except that previously I was using ST-E chip which did return BD_ADDR so 
this is not even consistent per manufacturer.

As said before, omitted BD_ADDR seems to be fine from spec perspective 
so we should not require it to be present. Since we can have only one LE 
hci_conn in BT_CONNECT state it's reasonable to use it here. This is 
already in patch.

What could be indeed added to this patch is warning message in case 
BD_ADDR is not BDADDR_ANY and it does not match one stored in hci_conn 
(either adapter returns random BD_ADDR which is weird or something went 
wrong).

BR,
Andrzej
