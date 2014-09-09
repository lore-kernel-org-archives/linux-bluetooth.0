Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH BlueZ 2/7] shared/gatt-client: Implement bt_gatt_client_register_notify.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25RbBpWLFJ=Sqz+tbgfoGv++RRNo-czsPTOe3kLdR9ob9Q@mail.gmail.com>
Date: Tue, 9 Sep 2014 08:23:43 -0700
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <B69C7DE3-C748-4553-A0F5-C8AB1E2B4150@holtmann.org>
References: <1410224591-5402-1-git-send-email-armansito@chromium.org> <1410224591-5402-3-git-send-email-armansito@chromium.org> <9F464B28-533C-4677-8F8D-01A6199A1F36@holtmann.org> <CAHrH25RbBpWLFJ=Sqz+tbgfoGv++RRNo-czsPTOe3kLdR9ob9Q@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>>> +     for (i = 0; i < service->num_chrcs; i++) {
>>> +             free((bt_gatt_descriptor_t *) service->chrcs[i].chrc.descs);
>> 
>> I must have overlooked these before, but that casting for free() should not be needed at all.
>> 
> 
> Without the cast the code will generate a compiler warning, since
> |descs| is declared as "const bt_descriptor_t *". I'd rather keep it
> as const since external code will access it but I need the cast to
> avoid the warning. I could cast it to void* if that makes it shorter.

ouch. We should not be freeing const pointers. If we allocate the pointer, then it should not be const.

>>> +
>>> +     be16 = htons(uuid16);
>>> +     memcpy(rhs_uuid + 2, &be16, sizeof(be16));
>> 
>> You might away with that the be16 and rhs_uuid are properly aligned here. However that is a dangerous game and I would rather see that you use put_be16() here.
>> 
> 
> Makes sense. FYI, I took this straight from bt_uuid16_to_uuid128 in lib/uuid.c.

Not everything in lib/uuid.c is a good example ;)

Regards

Marcel

