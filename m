Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141107122043.GA14496@t440s.lan>
References: <1415347791-11716-1-git-send-email-armansito@chromium.org>
	<1415347791-11716-11-git-send-email-armansito@chromium.org>
	<20141107122043.GA14496@t440s.lan>
Date: Fri, 7 Nov 2014 12:11:48 -0800
Message-ID: <CAHrH25RzwWyfxpS1NdJLG9XzA2fP4ejn3FQza5b2R7k7qrTjdQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 10/11] shared/gatt-client: Fix alignment warnings.
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> On Fri, Nov 7, 2014 at 4:20 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Arman,
>
> On Fri, Nov 07, 2014, Arman Uguray wrote:
>> This patch addresses warnings that arise when compiled with
>> -W=cast-align.
>> ---
>>  src/shared/gatt-client.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>> index b4f28b2..2e321b2 100644
>> --- a/src/shared/gatt-client.c
>> +++ b/src/shared/gatt-client.c
>> @@ -1647,7 +1647,7 @@ bool bt_gatt_characteristic_iter_init(struct bt_gatt_characteristic_iter *iter,
>>               return false;
>>
>>       memset(iter, 0, sizeof(*iter));
>> -     iter->service = (struct service_list *) service;
>> +     iter->service = (void *) service;
>>
>>       return true;
>>  }
>> @@ -1677,7 +1677,7 @@ bool bt_gatt_include_service_iter_init(struct bt_gatt_incl_service_iter *iter,
>>               return false;
>>
>>       memset(iter, 0, sizeof(*iter));
>> -     iter->service = (struct service_list *) service;
>> +     iter->service = (void *) service;
>>
>>       return true;
>>  }
>> @@ -2387,7 +2387,7 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
>>       struct chrc_data *chrc = NULL;
>>       struct bt_gatt_service_iter iter;
>>       const bt_gatt_service_t *service;
>> -     size_t i;
>> +     size_t i, offset;
>>
>>       if (!client || !chrc_value_handle || !callback)
>>               return false;
>> @@ -2402,7 +2402,8 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
>>       while (bt_gatt_service_iter_next(&iter, &service)) {
>>               if (chrc_value_handle >= service->start_handle &&
>>                               chrc_value_handle <= service->end_handle) {
>> -                     svc_data = (struct service_list *) service;
>> +                     offset = offsetof(struct service_list, service);
>> +                     svc_data = (void *) (service - offset);
>>                       break;
>
> Are you sure a (void *) case isn't enough for the last one too? After
> all offsetof() should be returning 0 which in the end results in a void *
> cast of the service pointer anyway.
>

Yeah, just a (void *) cast should be enough. I figured it's a bit more
"correct" to do the pointer math in the code, but yeah that offset
should be 0 (and afaik is guaranteed to be 0). I'll just remove the
math I guess.

> Btw, if we at any point find the need to really do this kind of pointer
> math I'd suggest adding a container_of() helper macro like the kernel
> uses.

I actually thought of adding a container_of macro then I decided that
would be a bit of an overkill for just this case.

>
> Johan

Cheers,
Arman
