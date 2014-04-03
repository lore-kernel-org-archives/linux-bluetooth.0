Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140403074944.GA20779@t440s.lan>
References: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
	<1396463426-7268-6-git-send-email-claudio.takahasi@openbossa.org>
	<20140403074944.GA20779@t440s.lan>
Date: Thu, 3 Apr 2014 16:12:48 -0300
Message-ID: <CAKT1EBfTP2wTVJK+do-V+rcgqY5caCNzy4RaQ+Q6JTLMarZfyA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 5/7] gatt: Add removing service from the database
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Thu, Apr 3, 2014 at 4:49 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Wed, Apr 02, 2014, Claudio Takahasi wrote:
>> This patch removes the service declaration and its attributes when
>> the external service implementation leaves the system bus, calls
>> UnregisterService(), or RegisterService() fails.
>> ---
>>  src/gatt-dbus.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> I've applied patches 1-4.
>
>> @@ -99,7 +100,8 @@ static void remove_service(DBusConnection *conn, void *user_data)
>>  {
>>       struct external_service *esvc = user_data;
>>
>> -     /* TODO: Remove from the database */
>> +     if (esvc->service)
>> +             btd_gatt_remove_service(esvc->service);
>
> Would it not be safer to set esvc->service to NULL after this?
>
>> @@ -360,7 +362,8 @@ static int register_external_service(const struct external_service *esvc,
>>       if (bt_string_to_uuid(&uuid, str) < 0)
>>               return -EINVAL;
>>
>> -     if (!btd_gatt_add_service(&uuid))
>> +     esvc->service = btd_gatt_add_service(&uuid);
>> +     if (!esvc->service)
>>               return -EINVAL;
>>
>>       return 0;
>> @@ -487,7 +490,8 @@ fail:
>>       error("Could not register external service: %s", esvc->path);
>>
>>       reply = btd_error_invalid_args(esvc->reg);
>> -     /* TODO: missing esvc/database cleanup */
>> +     if (esvc->service)
>> +             btd_gatt_remove_service(esvc->service);
>
> Same here.
>
> Johan

Actually, there is a potential invalid memory access related to esvc
(external_service), set esvc->service to NULL is not necessary.

Race condition & invalid memory access can happen when calling
remove_service callback & GDBusClient unref.

I will send another patchset fixing this problem.

Regards,
Claudio
