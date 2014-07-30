Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <968A3D86-D36A-432B-AB2F-1269D55B2BC9@holtmann.org>
References: <1406664949-25196-1-git-send-email-armansito@chromium.org>
	<B1DE8040-EA3D-4B9B-9649-033A8FB49F46@holtmann.org>
	<CAHrH25QOoRJjziR6K1rh3s5HAvKEaX62+LWB022G5E1eZ_WppA@mail.gmail.com>
	<968A3D86-D36A-432B-AB2F-1269D55B2BC9@holtmann.org>
Date: Wed, 30 Jul 2014 15:22:45 -0700
Message-ID: <CAHrH25THe4ULijjLmGvT0EYuJ32H7V1xv01LGJu-Y89ydti0HA@mail.gmail.com>
Subject: Re: [PATCH] shared/gatt: Use iterator based discovery result structure.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Sent v1 with the changes.

-Arman

On Wed, Jul 30, 2014 at 3:17 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Arman,
>
>>>> +struct result_ptrs {
>>>> +     struct bt_gatt_result *head;
>>>> +     struct bt_gatt_result *tail;
>>>> +};
>>>> +
>>>> +struct discovery_op {
>>>> +     struct bt_att *att;
>>>> +     uint16_t end_handle;
>>>> +     int ref_count;
>>>> +     bt_uuid_t uuid;
>>>> +     struct result_ptrs result;
>>>
>>> Does this nested struct give you any benefit. Why not just include head and tail pointers directly.
>>>
>>
>> I initially thought that I would reuse the result ptrs but I didn't so
>> it's not that necessary any more.
>>
>>
>>> I was actually thinking that struct bt_gatt_result will keep the tail pointer all by itself. That way it is self-contained.
>>
>> I'd rather have the head and tail pointers inside discovery_op. It's a
>> bit weird for each "link" (i.e. struct bt_gatt_result) to have a tail
>> pointer, which the iterator itself won't ever use later.
>
> then go for putting them in discovery_op. We can optimize things later since these are all internal details.
>
> Regards
>
> Marcel
>
