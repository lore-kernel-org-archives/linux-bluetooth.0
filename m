Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v5 3/6] Bluetooth: add hci_connect_le_scan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD0=r8wQByptKwMUrCG24OO8rhG8XYVN1ChcMyirMsQ1mC2FVA@mail.gmail.com>
Date: Wed, 29 Jul 2015 18:58:23 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <BF17F967-B84A-4B56-9594-03547254BAD7@holtmann.org>
References: <1438161714-4521-1-git-send-email-jpawlowski@google.com> <1438161714-4521-3-git-send-email-jpawlowski@google.com> <81394401-4C30-48AD-A6B5-6D8D4E21DD98@holtmann.org> <CAD0=r8zgGiVJMAXxiDPRZXZNZAUufQwMhGTOMgqancmYMn+9UQ@mail.gmail.com> <D5DC7730-4F59-494E-9361-D857FFAC8031@holtmann.org> <CAD0=r8wQByptKwMUrCG24OO8rhG8XYVN1ChcMyirMsQ1mC2FVA@mail.gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

>>>>> Currently, when trying to connect to already paired device that just
>>>>> rotated its RPA MAC address, old address would be used and connection
>>>>> would fail. In order to fix that, kernel must scan and receive
>>>>> advertisement with fresh RPA before connecting.
>>>>> 
>>>>> This patch adds hci_connect_le_scan with dependencies, new method that
>>>>> will be used to connect to remote LE devices. Instead of just sending
>>>>> connect request, it adds a device to whitelist. Later patches will make
>>>>> use of this whitelist to send conenct request when advertisement is
>>>>> received, and properly handle timeouts.
>>>>> 
>>>>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>>>>> ---
>>>>> include/net/bluetooth/hci_core.h |   5 ++
>>>>> net/bluetooth/hci_conn.c         | 170 +++++++++++++++++++++++++++++++++++++++
>>>>> net/bluetooth/hci_core.c         |  32 ++++++++
>>>>> 3 files changed, 207 insertions(+)
>>>>> 
>>>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>>>> index c8d2b5a..5d19794 100644
>>>>> --- a/include/net/bluetooth/hci_core.h
>>>>> +++ b/include/net/bluetooth/hci_core.h
>>>>> @@ -826,6 +826,9 @@ void hci_chan_del(struct hci_chan *chan);
>>>>> void hci_chan_list_flush(struct hci_conn *conn);
>>>>> struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
>>>>> 
>>>>> +struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
>>>>> +                                  u8 dst_type, u8 sec_level,
>>>>> +                                  u16 conn_timeout, u8 role);
>>>>> struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
>>>>>                             u8 dst_type, u8 sec_level, u16 conn_timeout,
>>>>>                             u8 role);
>>>>> @@ -991,6 +994,8 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev);
>>>>> struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
>>>>>                                               bdaddr_t *addr,
>>>>>                                               u8 addr_type);
>>>>> +struct hci_conn_params *hci_pend_le_explicit_connect_lookup(
>>>>> +                         struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
>>>> 
>>>> this is kinda violating the coding style. I wonder if we can shorten the function name or just go over 80 characters this time.
>>> 
>>> will rename it to hci_explicit_connect_lookup
>>>> 
>>>>> void hci_uuids_clear(struct hci_dev *hdev);
>>>>> 
>>>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>>>>> index 1ba8240..2a13214 100644
>>>>> --- a/net/bluetooth/hci_conn.c
>>>>> +++ b/net/bluetooth/hci_conn.c
>>>>> @@ -64,6 +64,36 @@ static void hci_le_create_connection_cancel(struct hci_conn *conn)
>>>>>     hci_send_cmd(conn->hdev, HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);
>>>>> }
>>>>> 
>>>>> +/* This function requires the caller holds hdev->lock */
>>>>> +static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
>>>>> +{
>>>>> +     struct hci_conn_params *params;
>>>>> +
>>>>> +     params = hci_pend_le_explicit_connect_lookup(conn->hdev, &conn->dst,
>>>>> +                                                  conn->dst_type);
>>>>> +     if (!params)
>>>>> +             return;
>>>>> +
>>>>> +     /* The connection attempt was doing scan for new RPA, and is
>>>>> +      * in scan phase. If params are not associated with any other
>>>>> +      * autoconnect action, remove them completely. If they are, just unmark
>>>>> +      * them as awaiting for connection, by clearing explicit_connect field.
>>>>> +      */
>>>>> +     if (params->auto_connect == HCI_AUTO_CONN_EXPLICIT)
>>>>> +             hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
>>>>> +     else
>>>>> +             params->explicit_connect = false;
>>>>> +}
>>>> 
>>>> What happens if we have two explicit connection requests here. I mean we can have two L2CAP socket trying to connect to two peripherals at the same time.
>>>> 
>>> 
>>> So right now if we have two sockets connecting to two different
>>> peripherals, you'll get same behavior as before, that is first request
>>> will succeed, second will fail (if they're triggered at same time and
>>> connection is not established before second is attempted). I'm willing
>>> to further improve this behavior in future.
>> 
>> 
>> essentially we just need to add both connect requests to the auto-connect list and it will sort itself out. Which means however we need to make sure we track this correct.
>> 
> 
> No, If you try again both sockets would use same conn object. call to
> connect on each socket will result in hci_connect_le_scan. First call
> to this method will create conn object, second call will re-use the
> old object for second socket. But now I found a bug - if one of
> sockets get closed, second will also get closed, because I don't keep
> count of sockets trying to connect. I'll fix that by changing
> explicit_connect from boolean to integer and increment it on each
> connect attempt.

that is for two L2CAP connection to the same device. That is something that we should consider as well. However isn't the hci_conn reference counting already taking care of that.

I was also worrying about one L2CAP connection to device a and another to device b. Both happening at the same time. Meaning whichever scanning sees first will connect first, but they will be connected both. It should work the same way as if you have two Add Device auto-connect devices and they are both available. They will both connect after each other.

Regards

Marcel

