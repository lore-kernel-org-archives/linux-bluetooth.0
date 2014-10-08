Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25QJ-nTdmOs7_HUeP+n6GHBGQa+Nc3umY7rFZt97rMw9Gg@mail.gmail.com>
References: <1412666365-9562-1-git-send-email-marcin.kraglak@tieto.com>
	<1412666365-9562-5-git-send-email-marcin.kraglak@tieto.com>
	<CAHrH25QJ-nTdmOs7_HUeP+n6GHBGQa+Nc3umY7rFZt97rMw9Gg@mail.gmail.com>
Date: Wed, 8 Oct 2014 07:30:07 +0200
Message-ID: <CABD6X-LTio=z_5Zpvt1i0m1iFdghmmNRKxMh1O=7GiChgJKOPQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] shared/gatt: Add Secondary services to service_list
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On 8 October 2014 01:04, Arman Uguray <armansito@chromium.org> wrote:
> Hi Marcin,
>
>
>> If included service was found and doesn't exist on service list,
>> create Secondary Service and insert it.
>
> I guess this is somewhat of an optimization but wouldn't it be more
> robust to actually perform secondary service discovery? I mean after
> discovering all the primary services, should we also send a bunch of
> Read By Group Type requests with the secondary service UUID? You could
> modify bt_gatt_discover_primary_services so that it accepts a boolean
> parameter (perhaps rename it to bt_gatt_discover_services) and uses
> the correct UUID based on that. Do you think that would be a better
> approach?

If we discover secondary first, then we won't have to recursive search
for include services.
I didn't implement this just because it wasn't listed in gatt feature
requirements in SPEC.
But I think that is good approach. I'll send patches

>
>
>> ---
>>  src/shared/gatt-client.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>> index 16b1630..54e6fec 100644
>> --- a/src/shared/gatt-client.c
>> +++ b/src/shared/gatt-client.c
>> @@ -471,6 +471,7 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
>>                                                 &includes[i].start_handle,
>>                                                 &includes[i].end_handle,
>>                                                 includes[i].uuid)) {
>> +               struct service_list *service;
>>                 uuid_to_string(includes[i].uuid, uuid_str);
>>                 util_debug(client->debug_callback, client->debug_data,
>>                                 "handle: 0x%04x, start: 0x%04x, end: 0x%04x,"
>> @@ -478,7 +479,56 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
>>                                 includes[i].start_handle,
>>                                 includes[i].end_handle, uuid_str);
>>
>> -               /* TODO check if included service is on list */
>> +
>> +               /*
>> +                * Check if included service was found previously in this
>> +                * session
>> +                */
>> +               for (service = op->result_head; service; service =
>> +                                                               service->next) {
>> +                       if (service->service.start_handle ==
>> +                                               includes[i].start_handle)
>> +                               break;
>> +               }
>> +
>> +               /*
>> +                * Check if included service was found in previous session
>> +                */
>> +               if (!service) {
>> +                       for (service = client->svc_head; service; service =
>> +                                                               service->next) {
>> +                               if (service->service.start_handle ==
>> +                                               includes[i].start_handle)
>> +                                       break;
>> +                       }
>> +               }
>> +
>> +               if (!service) {
>> +                       service = new0(struct service_list, 1);
>> +                       if (!service) {
>> +                               free(includes);
>> +                               success = false;
>> +                               goto done;
>> +                       }
>> +
>> +                       service->service.primary = false;
>> +                       service->service.start_handle =
>> +                                               includes[i].start_handle;
>> +                       service->service.end_handle = includes[i].end_handle;
>> +                       memcpy(service->service.uuid, includes[i].uuid,
>> +                                                               UUID_BYTES);
>> +
>> +                       service_list_insert_services(&op->result_head,
>> +                                                       &op->result_tail,
>> +                                                       service, service);
>> +
>> +                       /*
>> +                        * TODO: Newly created Secondary Service can contain
>> +                        * Included Services too. They should be discovered
>> +                        * before characteristic discovery.
>> +                        */
>> +               }
>> +
>>                 i++;
>>         }
>>
>> --
>> 1.9.3
>>

BR
Marcin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
