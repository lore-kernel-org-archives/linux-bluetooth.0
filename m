Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1609087.iuvzY7v4pk@athlon>
References: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<1412858714-2845-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<1609087.iuvzY7v4pk@athlon>
Date: Tue, 14 Oct 2014 11:01:17 +0200
Message-ID: <CAMv5Gbf3BMN71Sy=evJGVA8AwfD4+ndmaMkkc=i+YefT-y+cHw@mail.gmail.com>
Subject: Re: [PATCH 03/10] android/map-client: Add support for get remote MAS instances
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 13 October 2014 22:19, Szymon Janc <szymon.janc@gmail.com> wrote:
> On Thursday 09 October 2014 14:45:07 Grzegorz Kolodziejczyk wrote:
>> This allows to get remote mas instances. In case of wrong sdp record
>> fail status will be returned in notification.
>> ---
>>  android/map-client.c | 124
>> ++++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed, 123
>> insertions(+), 1 deletion(-)
>>
>> diff --git a/android/map-client.c b/android/map-client.c
>> index 1001b36..adeae4b 100644
>> --- a/android/map-client.c
>> +++ b/android/map-client.c
>> @@ -30,21 +30,143 @@
>>  #include <stdint.h>
>>  #include <glib.h>
>>
>> +#include "lib/sdp.h"
>> +#include "lib/sdp_lib.h"
>> +#include "src/sdp-client.h"
>> +
>>  #include "ipc.h"
>>  #include "lib/bluetooth.h"
>>  #include "map-client.h"
>>  #include "src/log.h"
>>  #include "hal-msg.h"
>> +#include "ipc-common.h"
>> +#include "utils.h"
>> +#include "src/shared/util.h"
>>
>>  static struct ipc *hal_ipc = NULL;
>>  static bdaddr_t adapter_addr;
>>
>> +static int fill_mce_inst(void *buf, int32_t id, int32_t scn, int32_t
>> msg_type, +                                   const void *name, uint8_t name_len)
>> +{
>> +     struct hal_map_client_mas_instance *inst = buf;
>> +
>> +     inst->id = id;
>> +     inst->scn = scn;
>> +     inst->msg_types = msg_type;
>> +     inst->name_len = name_len;
>> +
>> +     if (name_len)
>> +             memcpy(inst->name, name, name_len);
>> +
>> +     return sizeof(*inst) + name_len;
>> +}
>> +
>> +static void map_client_sdp_search_cb(sdp_list_t *recs, int err, gpointer
>> data) +{
>> +     uint8_t buf[IPC_MTU];
>> +     struct hal_ev_map_client_remote_mas_instances *ev = (void *) buf;
>> +     bdaddr_t *dst = data;
>> +     sdp_list_t *list, *protos;
>> +     uint8_t status;
>> +     int32_t id, scn, msg_type, name_len, num_instances = 0;
>> +     char *name;
>> +     size_t size;
>> +
>> +     size = sizeof(*ev);
>> +     bdaddr2android(dst, &ev->bdaddr);
>> +
>> +     if (err < 0) {
>> +             error("mce: Unable to get SDP record: %s", strerror(-err));
>> +             status = HAL_STATUS_FAILED;
>> +             goto fail;
>> +     }
>> +
>> +     for (list = recs; list != NULL; list = list->next) {
>> +             sdp_record_t *rec = list->data;
>> +             sdp_data_t *data;
>> +
>> +             data = sdp_data_get(rec, SDP_ATTR_MAS_INSTANCE_ID);
>> +             if (data) {
>> +                     id = data->val.uint8;
>> +             } else {
>> +                     error("mce: cannot get mas instance id");
>> +                     status = HAL_STATUS_FAILED;
>> +                     goto fail;
>
> I'm not sure if we should fail here. Lets just skip record (we can leave error
> message) and continue with search.
>
> Also make it like:  if (!data) {error(); continue;};
> Not need for if-else
>

Ok.

>> +             }
>> +
>> +             data = sdp_data_get(rec, SDP_ATTR_SVCNAME_PRIMARY);
>> +             if (data) {
>> +                     name = data->val.str;
>> +                     name_len = data->unitSize;
>> +             } else {
>> +                     error("mce: cannot get mas instance name");
>> +                     status = HAL_STATUS_FAILED;
>> +                     goto fail;
>> +             }
>> +
>> +             data = sdp_data_get(rec, SDP_ATTR_SUPPORTED_MESSAGE_TYPES);
>> +             if (data) {
>> +                     msg_type = data->val.uint8;
>> +             } else {
>> +                     error("mce: cannot get mas instance msg type");
>> +                     status = HAL_STATUS_FAILED;
>> +                     goto fail;
>> +             }
>> +
>> +             if (!sdp_get_access_protos(rec, &protos)) {
>> +                     scn = sdp_get_proto_port(protos, RFCOMM_UUID);
>> +
>> +                     sdp_list_foreach(protos,
>> +                                     (sdp_list_func_t) sdp_list_free, NULL);
>> +                     sdp_list_free(protos, NULL);
>> +             } else {
>> +                     error("mce: cannot get mas instance rfcomm channel");
>> +                     status = HAL_STATUS_FAILED;
>> +                     goto fail;
>> +             }
>> +
>> +             size += fill_mce_inst(buf + size, id, scn, msg_type, name,
>> +                                                             name_len);
>> +             num_instances++;
>> +     }
>> +
>> +     status = HAL_STATUS_SUCCESS;
>
> Please check if we are expected to return error if no instances were found.
>

Ok, I'll check it.

>> +
>> +fail:
>> +     ev->num_instances = num_instances;
>> +     ev->status = status;
>> +
>> +     ipc_send_notif(hal_ipc, HAL_SERVICE_ID_MAP_CLIENT,
>> +                     HAL_EV_MAP_CLIENT_REMOTE_MAS_INSTANCES, size, buf);
>> +
>> +     free(dst);
>> +}
>> +
>>  static void handle_get_instances(const void *buf, uint16_t len)
>>  {
>> +     const struct hal_cmd_map_client_get_instances *cmd = buf;
>> +     uint8_t status;
>> +     bdaddr_t *dst;
>> +     uuid_t uuid;
>> +
>>       DBG("");
>>
>> +     dst = new0(bdaddr_t, 1);
>
> Please check if allocation failed.
>

I forgot this check, I'll fix this.

>> +     android2bdaddr(&cmd->bdaddr, dst);
>> +
>> +     sdp_uuid16_create(&uuid, MAP_MSE_SVCLASS_ID);
>> +
>> +     if (bt_search_service(&adapter_addr, dst, &uuid,
>> +                             map_client_sdp_search_cb, dst, NULL, 0)) {
>
> Just a hint: you can pass free as destroy function here instead of taking care
> of that in callback.
>
>> +             error("mce: Failed to search SDP details");
>> +             status = HAL_STATUS_FAILED;
>> +             free(dst);
>> +     }
>> +
>> +     status = HAL_STATUS_SUCCESS;
>
> In case of error status is overwritten.
>

I'll re-check those statuses.

>>       ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_MAP_CLIENT,
>> -                     HAL_OP_MAP_CLIENT_GET_INSTANCES, HAL_STATUS_FAILED);
>> +                             HAL_OP_MAP_CLIENT_GET_INSTANCES, status);
>>  }
>>
>>  static const struct ipc_handler cmd_handlers[] = {
>
> --
> Szymon K. Janc
> szymon.janc@gmail.com

Best regards,
Grzegorz
