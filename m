Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140324085808.GA26197@t440s.lan>
References: <1395413930-18292-1-git-send-email-claudio.takahasi@openbossa.org>
	<1395429403-493-1-git-send-email-claudio.takahasi@openbossa.org>
	<1395429403-493-3-git-send-email-claudio.takahasi@openbossa.org>
	<20140324085808.GA26197@t440s.lan>
Date: Mon, 24 Mar 2014 08:52:49 -0300
Message-ID: <CAKT1EBdcZ3L0fPBEhyWGoqfNLunxWDQAH-KXdx=nVzNuwTXjiw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v7 02/10] gatt: Add write callback to
 btd_gatt_add_char helper
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Mon, Mar 24, 2014 at 5:58 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Fri, Mar 21, 2014, Claudio Takahasi wrote:
>> This patch adds a function callback for write operations. When a remote
>> device writes to a given attribute, the core calls the specified write
>> callback informing the attribute server the new characteristic value.
>> ---
>>  src/gatt-dbus.c |  2 +-
>>  src/gatt.c      |  7 ++++---
>>  src/gatt.h      | 13 ++++++++++++-
>>  3 files changed, 17 insertions(+), 5 deletions(-)
>
> I've applied the first patch but your change to the header file in this
> patch is strange:
>
>> +/*
>> + * Callbacks from this type are called once the value from the attribute was
>> + * written.
>> + * @err:     error in -errno format.
>> + * @user_data:       user_data passed in btd_attr_write_t callback
>> + */
>> +typedef void (*btd_attr_write_t) (struct btd_attribute *attr,
>> +                                     const uint8_t *value, size_t len);
>
> There's neither an err parameter nor a user_data parameter in this
> callback, so I'm wondering what your code comment refers to? :)
>
> Johan


It belongs to another patch that introduces Write Request handling:
asynchronous support.
It is a leftover issue of my approach of re-creating all the patches
based on the code that I have.

I will send another patchset moving this comment to the right patch.

Regards,
Claudio
