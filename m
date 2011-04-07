Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110407175818.GB29191@piper>
References: <1302197414-833-1-git-send-email-claudio.takahasi@openbossa.org>
	<20110407175818.GB29191@piper>
Date: Thu, 7 Apr 2011 18:15:57 +0000
Message-ID: <BANLkTikZia_V1pVN_EqF8cpk0xu6GF9ZCg@mail.gmail.com>
Subject: Re: [PATCH 1/9] Register primary services exported over basic rate
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius & Johan,

I will fix this error and move the GATT SDP record functions to gatt.c

BR,
Claudio

On Thu, Apr 7, 2011 at 5:58 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Claudio,
>
> On 14:30 Thu 07 Apr, Claudio Takahasi wrote:
>> This patch registers the object paths for primary services exported
>> through SDP. PSM, start and end handle information are available in
>> the Protocol Descriptor List.
>> ---
>>  src/device.c |  130 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 files changed, 129 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/device.c b/src/device.c
>> index d567952..32eb643 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -1367,6 +1367,127 @@ static void create_device_reply(struct btd_device *device, struct browse_req *re
>>       g_dbus_send_message(req->conn, reply);
>>  }
>>
>> +static sdp_data_t *proto_seq_find(sdp_list_t *proto_list)
>> +{
>> +     sdp_list_t *list;
>> +     uuid_t proto;
>> +
>> +     sdp_uuid16_create(&proto, ATT_UUID);
>> +
>> +     for (;list = proto_list, list; list = list->next) {
>
> The first ";" doesn't look right.
>
>> +             sdp_list_t *p;
>> +             for (p = list->data; p; p = p->next) {
>> +                     sdp_data_t *seq = p->data;
>> +                     if (seq && seq->dtd == SDP_UUID16 &&
>> +                             sdp_uuid16_cmp(&proto, &seq->val.uuid) == 0)
>> +                             return seq->next;
>> +             }
>> +     }
>> +
>> +     return NULL;
>> +}
>> +
>> +static gboolean parse_proto_params(sdp_list_t *proto_list, uint16_t *psm,
>> +                                             uint16_t *start, uint16_t *end)
>> +{
>> +     sdp_data_t *seq1, *seq2;
>> +
>> +     if (psm)
>> +             *psm = sdp_get_proto_port(proto_list, L2CAP_UUID);
>> +
>> +     /* Getting start and end handle */
>> +     seq1 = proto_seq_find(proto_list);
>> +     if (!seq1 || seq1->dtd != SDP_UINT16)
>> +             return FALSE;
>> +
>> +     seq2 = seq1->next;
>> +     if (!seq2 || seq2->dtd != SDP_UINT16)
>> +             return FALSE;
>> +
>> +     if (start)
>> +             *start = seq1->val.uint16;
>> +
>> +     if (end)
>> +             *end = seq2->val.uint16;
>> +
>> +     return TRUE;
>> +}
>> +
>> +static gboolean parse_primary_record(const sdp_record_t *rec,
>> +                                     uuid_t *prim_uuid, uint16_t *psm,
>> +                                     uint16_t *start, uint16_t *end)
>> +{
>> +     sdp_list_t *list;
>> +     uuid_t uuid;
>> +     gboolean ret;
>> +
>> +     if (sdp_get_service_classes(rec, &list) < 0)
>> +             return FALSE;
>> +
>> +     memcpy(&uuid, list->data, sizeof(uuid));
>> +     sdp_list_free(list, free);
>> +
>> +     if (sdp_get_access_protos(rec, &list) < 0)
>> +             return FALSE;
>> +
>> +     ret = parse_proto_params(list, psm, start, end);
>> +
>> +     sdp_list_foreach(list, (sdp_list_func_t) sdp_list_free, NULL);
>> +     sdp_list_free(list, NULL);
>> +
>> +     if (ret && prim_uuid)
>> +             memcpy(prim_uuid, &uuid, sizeof(uuid_t));
>> +
>> +     return ret;
>> +}
>> +
>> +static GSList *primary_from_record(struct btd_device *device, GSList *profiles)
>> +{
>> +     GSList *l, *prim_list = NULL;
>> +     char *att_uuid;
>> +     uuid_t proto_uuid;
>> +
>> +     sdp_uuid16_create(&proto_uuid, ATT_UUID);
>> +     att_uuid = bt_uuid2string(&proto_uuid);
>> +
>> +     for (l = profiles; l; l = l->next) {
>> +             const char *profile_uuid = l->data;
>> +             const sdp_record_t *rec;
>> +             struct att_primary *prim;
>> +             uint16_t start = 0, end = 0, psm = 0;
>> +             uuid_t prim_uuid;
>> +
>> +             rec = btd_device_get_record(device, profile_uuid);
>> +             if (!rec)
>> +                     continue;
>> +
>> +             if (!record_has_uuid(rec, att_uuid))
>> +                     continue;
>> +
>> +             if (!parse_primary_record(rec, &prim_uuid, &psm, &start, &end))
>> +                     continue;
>> +
>> +             prim = g_new0(struct att_primary, 1);
>> +             prim->start = start;
>> +             prim->end = end;
>> +             sdp_uuid2strn(&prim_uuid, prim->uuid, sizeof(prim->uuid));
>> +
>> +             prim_list = g_slist_append(prim_list, prim);
>> +     }
>> +
>> +     g_free(att_uuid);
>> +
>> +     return prim_list;
>> +}
>> +
>> +static void register_primary_services(DBusConnection *conn,
>> +                             struct btd_device *device, GSList *prim_list)
>> +{
>> +     /* TODO: PSM is hardcoded */
>> +     attrib_client_register(conn, device, 31, NULL, prim_list);
>> +     device->primaries = g_slist_concat(device->primaries, prim_list);
>> +}
>> +
>>  static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
>>  {
>>       struct browse_req *req = user_data;
>> @@ -1396,9 +1517,16 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
>>       }
>>
>>       /* Probe matching drivers for services added */
>> -     if (req->profiles_added)
>> +     if (req->profiles_added) {
>> +             GSList *list;
>> +
>>               device_probe_drivers(device, req->profiles_added);
>>
>> +             list = primary_from_record(device, req->profiles_added);
>> +             if (list)
>> +                     register_primary_services(req->conn, device, list);
>> +     }
>> +
>>       /* Remove drivers for services removed */
>>       if (req->profiles_removed)
>>               device_remove_drivers(device, req->profiles_removed);
>> --
>> 1.7.4.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> Cheers,
> --
> Vinicius
>



-- 
--
Claudio Takahasi
Instituto Nokia de Tecnologia
Recife - Pernambuco - Brasil
+55 81 30879999
