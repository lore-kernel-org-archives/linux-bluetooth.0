Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25Qpctiu72k7rNz5ccWhPeZoqjn1MM-BULuTVVN1sp6Bzg@mail.gmail.com>
References: <1414513123-5689-1-git-send-email-luiz.dentz@gmail.com>
	<1414513123-5689-5-git-send-email-luiz.dentz@gmail.com>
	<CAHrH25Qpctiu72k7rNz5ccWhPeZoqjn1MM-BULuTVVN1sp6Bzg@mail.gmail.com>
Date: Wed, 29 Oct 2014 10:50:04 +0200
Message-ID: <CABBYNZ+HQNf=MOxPffwnXpyj2pWQGZGvq84_uuxEgz2K3NRixw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] shared/gatt-db: Add gatt_db_attribute_get_permissions
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Oct 29, 2014 at 12:12 AM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz,
>
> On Tue, Oct 28, 2014 at 9:18 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> ---
>>  src/shared/gatt-db.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>> index 9a3f864..f43cac3 100644
>> --- a/src/shared/gatt-db.c
>> +++ b/src/shared/gatt-db.c
>> @@ -879,7 +879,12 @@ bool gatt_db_attribute_get_service_uuid(struct gatt_db_attribute *attrib,
>>  bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
>>                                                         uint32_t *permissions)
>>  {
>> -       return false;
>> +       if (!attrib || !permissions)
>> +               return false;
>
> So, based on my understanding, android/gatt treats an attribute
> permission value of "0" as "this is a declaration attribute since we
> didn't explicitly set it". Hence, returning 0 here will break things
> in the android code once it starts using the gatt_db_attribute_*
> functions.

The check here is for the permissions pointer passed to the function
to receive the value, if it is NULL it is probably a misuse of the
API.

> That said, I don't like this logic one bit in the first place. Instead
> of having "0" mean "anything goes" and having a special define for "no
> permissions" (such as GATT_PERM_NONE from android/gatt and
> BT_GATT_PERM from shared/att-types), we should just treat 0 to mean no
> permissions. I.e. we should define BT_GATT_PERM_NONE as 0, and have
> gatt_db_add_service, _add_characteristic, etc. explicitly set at least
> the BT_GATT_PERM_READ permission on the declaration attributes.

I guess you are confusing this code with some ideas I have in the past
about doing the permissions check in the db itself, this is no longer
the case since Vinicius pointed out this wouldn't be possible with the
current design of the db and I remember you also agreeing that the
permissions should be checked in the server or somewhere else, not
sure why you got the impression this would do anything with the
permissions, it just read what permissions have been attached to the
attribute nothing else.

> In short we should unify the permission story for shared/gatt and
> android/gatt sooner then later.

That I guess is bt_gatt_server business since that is per connection
it should check what permissions the db has stored and perform the
necessary checks, so the defines and everything else related to
permissions so probably be in bt_gatt_server.

>> +
>> +       *permissions = attrib->permissions;
>> +
>> +       return true;
>>  }
>>
>>  bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
>> --
>> 1.9.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Cheers,
> Arman



-- 
Luiz Augusto von Dentz
