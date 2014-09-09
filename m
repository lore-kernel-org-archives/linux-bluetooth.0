Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <B69C7DE3-C748-4553-A0F5-C8AB1E2B4150@holtmann.org>
References: <1410224591-5402-1-git-send-email-armansito@chromium.org>
	<1410224591-5402-3-git-send-email-armansito@chromium.org>
	<9F464B28-533C-4677-8F8D-01A6199A1F36@holtmann.org>
	<CAHrH25RbBpWLFJ=Sqz+tbgfoGv++RRNo-czsPTOe3kLdR9ob9Q@mail.gmail.com>
	<B69C7DE3-C748-4553-A0F5-C8AB1E2B4150@holtmann.org>
Date: Tue, 9 Sep 2014 08:52:11 -0700
Message-ID: <CAHrH25Qd5XN9vFAQPoNMVz+7VB8-n2XUXnN3-r5f4XsC=jh=5w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/7] shared/gatt-client: Implement bt_gatt_client_register_notify.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


>> Without the cast the code will generate a compiler warning, since
>> |descs| is declared as "const bt_descriptor_t *". I'd rather keep it
>> as const since external code will access it but I need the cast to
>> avoid the warning. I could cast it to void* if that makes it shorter.
>
> ouch. We should not be freeing const pointers. If we allocate the pointer, then it should not be const.
>

Yeah, my idea here was that the pointer is allocated internally by
bt_gatt_client and exposed externally as a const pointer. I put the
const there mainly to make it explicit that individual
bt_gatt_descriptor_t entries should not be modified and because I
wanted to avoid yet another nested iterator.

Now that I think of it, I can work around this by keeping the pointer
inside bt_gatt_characteristic_t const and have that point to an
internal non-const parameter in struct chrc_data. This should be OK
since the whole point of struct chrc_data here is to encapsulate
internal variables that should not be accessed or modified externally.

-Arman
