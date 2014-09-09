Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <9F464B28-533C-4677-8F8D-01A6199A1F36@holtmann.org>
References: <1410224591-5402-1-git-send-email-armansito@chromium.org>
	<1410224591-5402-3-git-send-email-armansito@chromium.org>
	<9F464B28-533C-4677-8F8D-01A6199A1F36@holtmann.org>
Date: Tue, 9 Sep 2014 08:04:31 -0700
Message-ID: <CAHrH25RbBpWLFJ=Sqz+tbgfoGv++RRNo-czsPTOe3kLdR9ob9Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/7] shared/gatt-client: Implement bt_gatt_client_register_notify.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


>> +     for (i = 0; i < service->num_chrcs; i++) {
>> +             free((bt_gatt_descriptor_t *) service->chrcs[i].chrc.descs);
>
> I must have overlooked these before, but that casting for free() should not be needed at all.
>

Without the cast the code will generate a compiler warning, since
|descs| is declared as "const bt_descriptor_t *". I'd rather keep it
as const since external code will access it but I need the cast to
avoid the warning. I could cast it to void* if that makes it shorter.


>> +
>> +     be16 = htons(uuid16);
>> +     memcpy(rhs_uuid + 2, &be16, sizeof(be16));
>
> You might away with that the be16 and rhs_uuid are properly aligned here. However that is a dangerous game and I would rather see that you use put_be16() here.
>

Makes sense. FYI, I took this straight from bt_uuid16_to_uuid128 in lib/uuid.c.

-Arman
