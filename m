Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJcu=re_Wtp-5cdOEft6wzRQgWSdPwFMiNyaak8WG+5Pw@mail.gmail.com>
References: <1422573313-30825-1-git-send-email-armansito@chromium.org>
	<1422573313-30825-2-git-send-email-armansito@chromium.org>
	<CABBYNZJcu=re_Wtp-5cdOEft6wzRQgWSdPwFMiNyaak8WG+5Pw@mail.gmail.com>
Date: Fri, 30 Jan 2015 16:16:58 -0800
Message-ID: <CAHrH25QagusJAiL0L65kfJ0xohh4mfNaA=ORvFt1kB0Ync8xOw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 1/5] shared/gatt: Make register_notify cancellable
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Fri, Jan 30, 2015 at 1:30 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Fri, Jan 30, 2015 at 1:15 AM, Arman Uguray <armansito@chromium.org> wrote:
>> This patch makes CCC writes via bt_gatt_client_register_notify
>> cancellable. The following changes have been introduced:
>>
>>   1. bt_gatt_client_register_notify now returns the id immediately
>>      instead of returning it in a callback. The callback is still
>>      used to communicate ATT protocol errors.
>>
>>   2. A notify callback is immediately registered, so that if the
>>      remote end sends any ATT notifications/indications, the caller
>>      will start receiving them right away.
>> ---
>>  src/shared/gatt-client.c | 116 +++++++++++++++++++++++++++--------------------
>>  src/shared/gatt-client.h |   7 ++-
>>  tools/btgatt-client.c    |  17 ++++---
>>  3 files changed, 79 insertions(+), 61 deletions(-)
>>
>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>> index 04fb4cb..66d0b63 100644
>> --- a/src/shared/gatt-client.c
>> +++ b/src/shared/gatt-client.c
>> @@ -168,9 +168,10 @@ struct notify_data {
>>         struct bt_gatt_client *client;
>>         bool invalid;
>>         unsigned int id;
>> +       unsigned int att_id;
>>         int ref_count;
>>         struct notify_chrc *chrc;
>> -       bt_gatt_client_notify_id_callback_t callback;
>> +       bt_gatt_client_register_callback_t callback;
>>         bt_gatt_client_notify_callback_t notify;
>>         void *user_data;
>>         bt_gatt_client_destroy_func_t destroy;
>> @@ -1011,22 +1012,20 @@ struct service_changed_op {
>>         uint16_t end_handle;
>>  };
>>
>> -static void service_changed_reregister_cb(unsigned int id, uint16_t att_ecode,
>> -                                                               void *user_data)
>> +static void service_changed_reregister_cb(uint16_t att_ecode, void *user_data)
>>  {
>>         struct bt_gatt_client *client = user_data;
>>
>> -       if (!id || att_ecode) {
>> +       if (!att_ecode) {
>>                 util_debug(client->debug_callback, client->debug_data,
>> -                       "Failed to register handler for \"Service Changed\"");
>> +                       "Re-registered handler for \"Service Changed\" after "
>> +                       "change in GATT service");
>>                 return;
>>         }
>>
>> -       client->svc_chngd_ind_id = id;
>> -
>>         util_debug(client->debug_callback, client->debug_data,
>> -               "Re-registered handler for \"Service Changed\" after change in "
>> -               "GATT service");
>> +               "Failed to register handler for \"Service Changed\"");
>> +       client->svc_chngd_ind_id = 0;
>>  }
>>
>>  static void process_service_changed(struct bt_gatt_client *client,
>> @@ -1090,11 +1089,12 @@ static void service_changed_complete(struct discovery_op *op, bool success,
>>         /* The GATT service was modified. Re-register the handler for
>>          * indications from the "Service Changed" characteristic.
>>          */
>> -       if (bt_gatt_client_register_notify(client,
>> +       client->svc_chngd_ind_id = bt_gatt_client_register_notify(client,
>>                                         gatt_db_attribute_get_handle(attr),
>>                                         service_changed_reregister_cb,
>>                                         service_changed_cb,
>> -                                       client, NULL))
>> +                                       client, NULL);
>> +       if (client->svc_chngd_ind_id)
>>                 return;
>>
>>         util_debug(client->debug_callback, client->debug_data,
>> @@ -1184,24 +1184,24 @@ static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
>>         queue_push_tail(client->svc_chngd_queue, op);
>>  }
>>
>> -static void service_changed_register_cb(unsigned int id, uint16_t att_ecode,
>> -                                                               void *user_data)
>> +static void service_changed_register_cb(uint16_t att_ecode, void *user_data)
>>  {
>>         bool success;
>>         struct bt_gatt_client *client = user_data;
>>
>> -       if (!id || att_ecode) {
>> +       if (att_ecode) {
>>                 util_debug(client->debug_callback, client->debug_data,
>>                         "Failed to register handler for \"Service Changed\"");
>>                 success = false;
>> +               client->svc_chngd_ind_id = 0;
>>                 goto done;
>>         }
>>
>> -       client->svc_chngd_ind_id = id;
>>         client->ready = true;
>>         success = true;
>>         util_debug(client->debug_callback, client->debug_data,
>> -                       "Registered handler for \"Service Changed\": %u", id);
>> +                       "Registered handler for \"Service Changed\": %u",
>> +                       client->svc_chngd_ind_id);
>>
>>  done:
>>         notify_client_ready(client, success, att_ecode);
>> @@ -1211,7 +1211,6 @@ static void init_complete(struct discovery_op *op, bool success,
>>                                                         uint8_t att_ecode)
>>  {
>>         struct bt_gatt_client *client = op->client;
>> -       bool registered;
>>         struct gatt_db_attribute *attr = NULL;
>>         bt_uuid_t uuid;
>>
>> @@ -1235,14 +1234,14 @@ static void init_complete(struct discovery_op *op, bool success,
>>          * the handler using the existing framework.
>>          */
>>         client->ready = true;
>> -       registered = bt_gatt_client_register_notify(client,
>> +       client->svc_chngd_ind_id = bt_gatt_client_register_notify(client,
>>                                         gatt_db_attribute_get_handle(attr),
>>                                         service_changed_register_cb,
>>                                         service_changed_cb,
>>                                         client, NULL);
>>         client->ready = false;
>>
>> -       if (registered)
>> +       if (client->svc_chngd_ind_id)
>>                 return;
>>
>>         util_debug(client->debug_callback, client->debug_data,
>> @@ -1301,24 +1300,15 @@ static void complete_notify_request(void *data)
>>         /* Increment the per-characteristic ref count of notify handlers */
>>         __sync_fetch_and_add(&notify_data->chrc->notify_count, 1);
>>
>> -       /* Add the handler to the bt_gatt_client's general list */
>> -       queue_push_tail(notify_data->client->notify_list,
>> -                                               notify_data_ref(notify_data));
>> -
>> -       /* Assign an ID to the handler and notify the caller that it was
>> -        * successfully registered.
>> -        */
>> -       if (notify_data->client->next_reg_id < 1)
>> -               notify_data->client->next_reg_id = 1;
>> -
>> -       notify_data->id = notify_data->client->next_reg_id++;
>> -       notify_data->callback(notify_data->id, 0, notify_data->user_data);
>> +       notify_data->att_id = 0;
>> +       notify_data->callback(0, notify_data->user_data);
>>  }
>>
>>  static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
>>                                                 bt_att_response_func_t callback)
>>  {
>>         uint8_t pdu[4];
>> +       unsigned int att_id;
>>
>>         assert(notify_data->chrc->ccc_handle);
>>         memset(pdu, 0, sizeof(pdu));
>> @@ -1338,13 +1328,13 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
>>                         return false;
>>         }
>>
>> -       notify_data->chrc->ccc_write_id = bt_att_send(notify_data->client->att,
>> -                                               BT_ATT_OP_WRITE_REQ,
>> -                                               pdu, sizeof(pdu),
>> -                                               callback,
>> -                                               notify_data, notify_data_unref);
>> +       att_id = bt_att_send(notify_data->client->att, BT_ATT_OP_WRITE_REQ,
>> +                                               pdu, sizeof(pdu), callback,
>> +                                               notify_data_ref(notify_data),
>> +                                               notify_data_unref);
>
> Similar code apparently caused some false positive reports from LLVM
> static analyzer in the past, in fact you actually change the way you
> pass the data here since it now takes another reference, is that
> really necessary?
>

I find this mostly organizational. Basically the notify_data starts
with a reference count of 1 (one reference for bt_gatt_client who owns
it). Later we add another reference when we pass it to bt_att_send so
now bt_att holds a reference. Once the procedure ends it will drop the
reference, or whenever the procedure gets cancelled later.

We could avoid adding a ref here and pass NULL to the destroy function
but procedurally adding a ref here makes sense to me.

>> +       notify_data->chrc->ccc_write_id = notify_data->att_id = att_id;
>>
>> -       return !!notify_data->chrc->ccc_write_id;
>> +       return !!att_id;
>>  }
>>
>>  static uint8_t process_error(const void *pdu, uint16_t length)
>> @@ -1377,7 +1367,8 @@ static void enable_ccc_callback(uint8_t opcode, const void *pdu,
>>                  * the next one in the queue. If there was an error sending the
>>                  * write request, then just move on to the next queued entry.
>>                  */
>> -               notify_data->callback(0, att_ecode, notify_data->user_data);
>> +               queue_remove(notify_data->client->notify_list, notify_data);
>> +               notify_data->callback(att_ecode, notify_data->user_data);
>>
>>                 while ((notify_data = queue_pop_head(
>>                                         notify_data->chrc->reg_notify_queue))) {
>> @@ -1426,6 +1417,16 @@ static void complete_unregister_notify(void *data)
>>  {
>>         struct notify_data *notify_data = data;
>>
>> +       /*
>> +        * If a procedure to enable the CCC is still pending, then cancel it and
>> +        * return.
>> +        */
>> +       if (notify_data->att_id) {
>> +               bt_att_cancel(notify_data->client->att, notify_data->att_id);
>> +               notify_data_unref(notify_data);
>
> Wouldn't bt_att_cancel end up calling notify_data_unref since you have
> passed it as destroy callback? Or this is for the extra reference you
> have introduced?
>

Yep it should. The extra unref is for the reference held by the bt_gatt_client.

>> +               return;
>> +       }
>> +
>>         if (__sync_sub_and_fetch(&notify_data->chrc->notify_count, 1)) {
>>                 notify_data_unref(notify_data);
>>                 return;
>> @@ -1449,6 +1450,10 @@ static void notify_handler(void *data, void *user_data)
>>         if (pdu_data->length > 2)
>>                 value = pdu_data->pdu + 2;
>>
>> +       /*
>> +        * Even if the notify data has a pending ATT request to write to the
>> +        * CCC, there is really no reason not to notify the handlers.
>> +        */
>>         if (notify_data->notify)
>>                 notify_data->notify(value_handle, value, pdu_data->length - 2,
>>                                                         notify_data->user_data);
>> @@ -2569,9 +2574,9 @@ static bool match_notify_chrc_value_handle(const void *a, const void *b)
>>         return chrc->value_handle == value_handle;
>>  }
>>
>> -bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
>> +unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
>>                                 uint16_t chrc_value_handle,
>> -                               bt_gatt_client_notify_id_callback_t callback,
>> +                               bt_gatt_client_register_callback_t callback,
>>                                 bt_gatt_client_notify_callback_t notify,
>>                                 void *user_data,
>>                                 bt_gatt_client_destroy_func_t destroy)
>> @@ -2580,10 +2585,10 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
>>         struct notify_chrc *chrc = NULL;
>>
>>         if (!client || !client->db || !chrc_value_handle || !callback)
>> -               return false;
>> +               return 0;
>>
>>         if (!bt_gatt_client_is_ready(client) || client->in_svc_chngd)
>> -               return false;
>> +               return 0;
>>
>>         /* Check if a characteristic ref count has been started already */
>>         chrc = queue_find(client->notify_chrcs, match_notify_chrc_value_handle,
>> @@ -2596,17 +2601,16 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
>>                  */
>>                 chrc = notify_chrc_create(client, chrc_value_handle);
>>                 if (!chrc)
>> -                       return false;
>> -
>> +                       return 0;
>>         }
>>
>>         /* Fail if we've hit the maximum allowed notify sessions */
>>         if (chrc->notify_count == INT_MAX)
>> -               return false;
>> +               return 0;
>>
>>         notify_data = new0(struct notify_data, 1);
>>         if (!notify_data)
>> -               return false;
>> +               return 0;
>>
>>         notify_data->client = client;
>>         notify_data->ref_count = 1;
>> @@ -2616,13 +2620,24 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
>>         notify_data->user_data = user_data;
>>         notify_data->destroy = destroy;
>>
>> +       /* Add the handler to the bt_gatt_client's general list */
>> +       queue_push_tail(client->notify_list, notify_data);
>> +
>> +       /* Assign an ID to the handler and notify the caller that it was
>> +        * successfully registered.
>> +        */
>> +       if (client->next_reg_id < 1)
>> +               client->next_reg_id = 1;
>> +
>> +       notify_data->id = client->next_reg_id++;
>
> This logic has a flaw since you don't check the id 1 is currently in
> use, since this is only valid for the lifetime of the session the
> chance of next_reg_id overflowing is really small but in any case I
> would use a uint32_t, we could instead reuse the id unregistered but
> that would probably require extra lookups in the list to figure out
> what id can be used again.
>

You are correct, though this is the same thing that is done by
bt_att_send and bt_att_register, which I ultimately took from
mgmt_send. I guess we should fix all of these locations later. I'm
leaving this as it is for consistency with other code but we should
probably collectively address this overflow and id-reuse problem
rather than just here.

>>         /*
>>          * If a write to the CCC descriptor is in progress, then queue this
>>          * request.
>>          */
>>         if (chrc->ccc_write_id) {
>>                 queue_push_tail(chrc->reg_notify_queue, notify_data);
>> -               return true;
>> +               return notify_data->id;
>>         }
>>
>>         /*
>> @@ -2630,16 +2645,17 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
>>          */
>>         if (chrc->notify_count > 0) {
>>                 complete_notify_request(notify_data);
>> -               return true;
>> +               return notify_data->id;
>>         }
>>
>>         /* Write to the CCC descriptor */
>>         if (!notify_data_write_ccc(notify_data, true, enable_ccc_callback)) {
>> +               queue_remove(client->notify_list, notify_data);
>>                 free(notify_data);
>> -               return false;
>> +               return 0;
>>         }
>>
>> -       return true;
>> +       return notify_data->id;
>>  }
>>
>>  bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
>> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
>> index 9a00feb..b84fa13 100644
>> --- a/src/shared/gatt-client.h
>> +++ b/src/shared/gatt-client.h
>> @@ -49,8 +49,7 @@ typedef void (*bt_gatt_client_write_long_callback_t)(bool success,
>>  typedef void (*bt_gatt_client_notify_callback_t)(uint16_t value_handle,
>>                                         const uint8_t *value, uint16_t length,
>>                                         void *user_data);
>> -typedef void (*bt_gatt_client_notify_id_callback_t)(unsigned int id,
>> -                                                       uint16_t att_ecode,
>> +typedef void (*bt_gatt_client_register_callback_t)(uint16_t att_ecode,
>>                                                         void *user_data);
>>  typedef void (*bt_gatt_client_service_changed_callback_t)(uint16_t start_handle,
>>                                                         uint16_t end_handle,
>> @@ -110,9 +109,9 @@ unsigned int bt_gatt_client_write_long_value(struct bt_gatt_client *client,
>>                                 void *user_data,
>>                                 bt_gatt_client_destroy_func_t destroy);
>>
>> -bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
>> +unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
>>                                 uint16_t chrc_value_handle,
>> -                               bt_gatt_client_notify_id_callback_t callback,
>> +                               bt_gatt_client_register_callback_t callback,
>>                                 bt_gatt_client_notify_callback_t notify,
>>                                 void *user_data,
>>                                 bt_gatt_client_destroy_func_t destroy);
>> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
>> index 62c4d3e..8bda89b 100644
>> --- a/tools/btgatt-client.c
>> +++ b/tools/btgatt-client.c
>> @@ -856,16 +856,15 @@ static void notify_cb(uint16_t value_handle, const uint8_t *value,
>>         PRLOG("\n");
>>  }
>>
>> -static void register_notify_cb(unsigned int id, uint16_t att_ecode,
>> -                                                               void *user_data)
>> +static void register_notify_cb(uint16_t att_ecode, void *user_data)
>>  {
>> -       if (!id) {
>> +       if (att_ecode) {
>>                 PRLOG("Failed to register notify handler "
>>                                         "- error code: 0x%02x\n", att_ecode);
>>                 return;
>>         }
>>
>> -       PRLOG("Registered notify handler with id: %u\n", id);
>> +       PRLOG("Registered notify handler!");
>>  }
>>
>>  static void cmd_register_notify(struct client *cli, char *cmd_str)
>> @@ -873,6 +872,7 @@ static void cmd_register_notify(struct client *cli, char *cmd_str)
>>         char *argv[2];
>>         int argc = 0;
>>         uint16_t value_handle;
>> +       unsigned int id;
>>         char *endptr = NULL;
>>
>>         if (!bt_gatt_client_is_ready(cli->gatt)) {
>> @@ -891,12 +891,15 @@ static void cmd_register_notify(struct client *cli, char *cmd_str)
>>                 return;
>>         }
>>
>> -       if (!bt_gatt_client_register_notify(cli->gatt, value_handle,
>> +       id = bt_gatt_client_register_notify(cli->gatt, value_handle,
>>                                                         register_notify_cb,
>> -                                                       notify_cb, NULL, NULL))
>> +                                                       notify_cb, NULL, NULL);
>> +       if (!id) {
>>                 printf("Failed to register notify handler\n");
>> +               return;
>> +       }
>>
>> -       printf("\n");
>> +       PRLOG("Registering notify handler with id: %u\n", id);
>>  }
>>
>>  static void unregister_notify_usage(void)
>> --
>> 2.2.0.rc0.207.ga3a616c
>>
>
>
>
> --
> Luiz Augusto von Dentz

Thanks,
Arman
