Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABD6X-+zxqP8eEeBxrcP9bGW6f9mmbAp=GCJch8OhCEoyzg6Bg@mail.gmail.com>
References: <1414357967-9371-1-git-send-email-armansito@chromium.org>
	<1414357967-9371-7-git-send-email-armansito@chromium.org>
	<CABD6X-+zxqP8eEeBxrcP9bGW6f9mmbAp=GCJch8OhCEoyzg6Bg@mail.gmail.com>
Date: Mon, 27 Oct 2014 07:37:00 -0700
Message-ID: <CAHrH25TwsTSC6qCF3OGz8OeBQ+aRCqi6--_hh6g+gNG86oPuOw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 6/7] shared/gatt-db: Fix range handling in read by
 grp type.
From: Arman Uguray <armansito@chromium.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Sun, Oct 26, 2014 at 11:54 PM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> Hi Arman,
>
> On 26 October 2014 22:12, Arman Uguray <armansito@chromium.org> wrote:
>> This patch fixes bug in gatt_db_read_by_grp_type in which the range end handle
>> was being ignored. This caused incorrect results to be sent for a database
>> where services exists beyond the end handle provided in the request.
>> ---
>>  src/shared/gatt-db.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>> index b3f95d2..4e74030 100644
>> --- a/src/shared/gatt-db.c
>> +++ b/src/shared/gatt-db.c
>> @@ -428,6 +428,7 @@ static void read_by_group_type(void *data, void *user_data)
>>  {
>>         struct read_by_group_type_data *search_data = user_data;
>>         struct gatt_db_service *service = data;
>> +       uint16_t grp_start, grp_end;
>>
>>         if (!service->active)
>>                 return;
>> @@ -439,7 +440,15 @@ static void read_by_group_type(void *data, void *user_data)
>>         if (bt_uuid_cmp(&search_data->uuid, &service->attributes[0]->uuid))
>>                 return;
>>
>> -       if (service->attributes[0]->handle < search_data->start_handle)
>> +       grp_start = service->attributes[0]->handle;
>> +       grp_end = service->attributes[service->num_handles - 1]->handle;
>
> I suggest
>
> grp_end = grp_start + num_handles - 1
>
> because not all attributes must be in use. First attribute must be
> filled, because it's service decl.

Thanks, fixed in v1.
