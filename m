Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <33E8F9C2-CFF0-4555-94B9-0F1D0166472A@holtmann.org>
References: <1403743975-31114-1-git-send-email-andre.guedes@openbossa.org>
 <1403743975-31114-3-git-send-email-andre.guedes@openbossa.org> <33E8F9C2-CFF0-4555-94B9-0F1D0166472A@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
Date: Mon, 30 Jun 2014 19:36:41 -0300
Message-ID: <CACJA=fWOw96FspKRYMGjE6WP2T887VRW1dDmVQYu0hC7KkP=hg@mail.gmail.com>
Subject: Re: [RFC v2 3/4] Bluetooth: Enable new LE meta event
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jun 26, 2014 at 3:57 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> The Bluetooth 4.1 introduces a new LE meta event called "LE Remote
>> Connection Parameter Request" event. In order to the controller sends
>> this event to host, we should enable it during controller initialization.
>>
>> Therefore, this patch enables that event in case the controller supports
>> Bluetooth 4.1 or upper version.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> include/net/bluetooth/bluetooth.h | 1 +
>> net/bluetooth/hci_core.c          | 7 +++++++
>> 2 files changed, 8 insertions(+)
>>
>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>> index 373000d..85dbc03 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -38,6 +38,7 @@
>> #define BLUETOOTH_VER_1_1     1
>> #define BLUETOOTH_VER_1_2     2
>> #define BLUETOOTH_VER_2_0     3
>> +#define BLUETOOTH_VER_4_1    7
>>
>> /* Reserv for core and drivers use */
>> #define BT_SKB_RESERVE        8
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 9852449..a8b9d70 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1461,6 +1461,13 @@ static void hci_setup_event_mask(struct hci_request *req)
>>       if (lmp_le_capable(hdev)) {
>>               memset(events, 0, sizeof(events));
>>               events[0] = 0x1f;
>> +
>> +             /* If Bluetooth 4.1 or upper version, enable LE Remote
>> +              * Connection Parameter Request Event.
>> +              */
>> +             if (hdev->hci_ver >= BLUETOOTH_VER_4_1)
>> +                     events[0] = events[0] | 0x20;
>> +
>
> we only fall back to Bluetooth version check in case we can not feature masks to determine if something is supported or not. Use the LE features mask to figure out if we support this or not.

Ok, I'll fix it.

Thanks,

Andre
