Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25RoN85p45gv9gg3Kcn+QhK-qfeek3GPaZNMmMXfUVsFwg@mail.gmail.com>
References: <1424927610-26226-1-git-send-email-armansito@chromium.org>
	<1424927610-26226-13-git-send-email-armansito@chromium.org>
	<CABBYNZJcAAfKmjA9P3oVbHH5evriwNJBmK=zzNCRBfcXQQDSGg@mail.gmail.com>
	<CAHrH25RoN85p45gv9gg3Kcn+QhK-qfeek3GPaZNMmMXfUVsFwg@mail.gmail.com>
Date: Fri, 27 Feb 2015 12:54:04 +0200
Message-ID: <CABBYNZL1pnz742vhVXNV7eHf_8EVymtZHOoJBXS_+tFRdYQX5g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 12/17] core/gatt: Add btd_gatt_database_notify function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Thu, Feb 26, 2015 at 10:49 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz,
>
>> On Thu, Feb 26, 2015 at 12:51 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>> Hi Arman,
>>
>> On Thu, Feb 26, 2015 at 7:13 AM, Arman Uguray <armansito@chromium.org> wrote:
>>> This patch add the btd_gatt_database_notify function to database's
>>> public API. This allows upper layers to send out notifications
>>> and indications to all connected devices that have configured the
>>> specified CCC descriptor.
>>> ---
>>>  src/gatt-database.c | 4 ++--
>>>  src/gatt-database.h | 5 +++++
>>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/src/gatt-database.c b/src/gatt-database.c
>>> index ebfcf2d..d75b971 100644
>>> --- a/src/gatt-database.c
>>> +++ b/src/gatt-database.c
>>> @@ -737,7 +737,7 @@ static void send_notification_to_device(void *data, void *user_data)
>>>                                                         NULL, NULL);
>>>  }
>>>
>>> -static void send_notification_to_devices(struct btd_gatt_database *database,
>>> +void btd_gatt_database_notify(struct btd_gatt_database *database,
>>>                                         uint16_t handle, const uint8_t *value,
>>>                                         uint16_t len, uint16_t ccc_handle,
>>>                                         bool indicate)
>>> @@ -781,7 +781,7 @@ static void send_service_changed(struct btd_gatt_database *database,
>>>         put_le16(start, value);
>>>         put_le16(end, value + 2);
>>>
>>> -       send_notification_to_devices(database, handle, value, sizeof(value),
>>> +       btd_gatt_database_notify(database, handle, value, sizeof(value),
>>>                                                         ccc_handle, true);
>>>  }
>>>
>>> diff --git a/src/gatt-database.h b/src/gatt-database.h
>>> index 163b601..2a89ad6 100644
>>> --- a/src/gatt-database.h
>>> +++ b/src/gatt-database.h
>>> @@ -34,3 +34,8 @@ btd_gatt_database_add_ccc(struct btd_gatt_database *database,
>>>                                 btd_gatt_database_ccc_write_t write_callback,
>>>                                 void *user_data,
>>>                                 btd_gatt_database_destroy_t destroy);
>>> +
>>> +void btd_gatt_database_notify(struct btd_gatt_database *database,
>>> +                                       uint16_t handle, const uint8_t *value,
>>> +                                       uint16_t len, uint16_t ccc_handle,
>>> +                                       bool indicate);
>>> --
>>> 2.2.0.rc0.207.ga3a616c
>>
>> I think we should make gatt_db notify about database changes directly
>> so anyone interested in attribute value changes can subscribe to it.
>>
>
> So, after our discussion on IRC, will you be implementing this or
> should I? If you give me a description of the kind of API you're
> thinking about and how things should fit together, then I can have a
> go at it, unless you've started working on it already.

Im planning to continue this today, along with some other modification
like g_dbus_client_new_full so we don't break the API.

>
>>
>>
>> --
>> Luiz Augusto von Dentz
>
> Thanks!
> Arman



-- 
Luiz Augusto von Dentz
