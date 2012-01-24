Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MVOTws3O=czdbQTM4ZxtfLGtgVbkwqS8QPjszq-1-y2w@mail.gmail.com>
References: <1327403188-21981-1-git-send-email-sancane@gmail.com>
	<1327403188-21981-2-git-send-email-sancane@gmail.com>
	<1327403188-21981-3-git-send-email-sancane@gmail.com>
	<1327403188-21981-4-git-send-email-sancane@gmail.com>
	<1327403188-21981-5-git-send-email-sancane@gmail.com>
	<1327403188-21981-6-git-send-email-sancane@gmail.com>
	<1327403188-21981-7-git-send-email-sancane@gmail.com>
	<1327403188-21981-8-git-send-email-sancane@gmail.com>
	<CAJdJm_MVOTws3O=czdbQTM4ZxtfLGtgVbkwqS8QPjszq-1-y2w@mail.gmail.com>
Date: Tue, 24 Jan 2012 16:49:13 +0100
Message-ID: <CACLukz+K6a1gDBuLoLy-90498VNfSu1xY9ciiEfnzW23WeGT4Q@mail.gmail.com>
Subject: Re: [PATCH 7/8] attrib-server: Allocate 128-bits UUIDs using highest
 available handlers
From: Santiago Carot <sancane@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

2012/1/24 Anderson Lizardo <anderson.lizardo@openbossa.org>:
> Hi Santiago,
>
> On Tue, Jan 24, 2012 at 7:06 AM, Santiago Carot-Nemesio
> <sancane@gmail.com> wrote:
>> 128-uuids services are grouped at the end of the handlers database list.
>> This group grows up from the highest handlers toward lowers handlers
>> until the whole range is used or the last 16 bit-uuid service is reached.
>> ---
>>  src/attrib-server.c |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 files changed, 46 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/attrib-server.c b/src/attrib-server.c
>> index e52571c..f2bf5ef 100644
>> --- a/src/attrib-server.c
>> +++ b/src/attrib-server.c
>> @@ -1317,7 +1317,52 @@ static uint16_t find_uuid16_avail(struct btd_adapter *adapter, uint16_t nitems)
>>
>>  static uint16_t find_uuid128_avail(struct btd_adapter *adapter, uint16_t nitems)
>>  {
>> -       /* TODO: Allocate 128 uuids at the end of the list */
>> +       struct gatt_server *server;
>> +       uint16_t handle = 0, end = 0xffff;
>> +       gboolean pick = TRUE;
>> +       GList *dl;
>> +       GSList *l;
>> +
>> +       l = g_slist_find_custom(servers, adapter, adapter_cmp);
>> +       if (l == NULL)
>> +               return 0;
>> +
>> +       server = l->data;
>> +       if (server->database == NULL)
>> +               return 0xffff - nitems + 1;
>> +
>> +       for (dl = g_list_last(server->database); dl; dl = dl->prev) {
>> +               struct attribute *a = dl->data;
>> +               if (pick) {
>> +                       handle = a->handle;
>> +                       pick = FALSE;
>> +               }
>
> I suspect you can get this code a lot simpler without using this
> "pick" variable. Unfortunately, I don't have time to look at this
> further right now.
>
>> +
>> +               if (bt_uuid_cmp(&a->uuid, &prim_uuid) != 0 &&
>> +                               bt_uuid_cmp(&a->uuid, &snd_uuid) != 0)
>> +                       continue;
>
> At this point you know a->uuid is either primary or secondary. So I
> don't think it is necessary to check again below.
>
>> +
>> +               if ((bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
>> +                               bt_uuid_cmp(&a->uuid, &snd_uuid) == 0) &&
>> +                               end - handle >= nitems)
>> +                       return end - nitems + 1;
>
> Same below. At this point, they are guaranteed to be either primary or
> secondary uuids. You only need to check for a->len.
>

Thanks for the feedback, I'll send a new set with the changes suggested.
Regards.
