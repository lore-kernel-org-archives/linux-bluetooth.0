Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <53FC67E9.8090501@tieto.com>
References: <1407941416-28453-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<53FC67E9.8090501@tieto.com>
Date: Tue, 2 Sep 2014 16:34:12 +0200
Message-ID: <CAMv5GbcUsa65ybTY_YLf5ULMTPmTSQXRgRW+8v7b4Vxup3oqXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] android/gatt: Stop listening while unregistering app
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On 26 August 2014 12:56, Tyszkowski Jakub <jakub.tyszkowski@tieto.com> wrote:
> Hi Grzegorz,
>
>
> On 08/13/2014 04:50 PM, Grzegorz Kolodziejczyk wrote:
>>
>> Client gets stucked on advertising while unregistering app with not
>> stopped listening.
>> ---
>>   android/gatt.c | 102
>> ++++++++++++++++++++++++++++++++++++---------------------
>>   1 file changed, 64 insertions(+), 38 deletions(-)
>>
>> diff --git a/android/gatt.c b/android/gatt.c
>> index 89748d2..7b3db06 100644
>> --- a/android/gatt.c
>> +++ b/android/gatt.c
>> @@ -1834,15 +1834,79 @@ static uint8_t unregister_app(int client_if)
>>         return HAL_STATUS_SUCCESS;
>>   }
>>
>> +static void send_client_listen_notify(int32_t id, int32_t status)
>> +{
>> +       struct hal_ev_gatt_client_listen ev;
>> +
>> +       /* Server if because of typo in android headers */
>> +       ev.server_if = id;
>> +       ev.status = status;
>> +
>> +       ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
>> HAL_EV_GATT_CLIENT_LISTEN,
>> +                                                       sizeof(ev), &ev);
>> +}
>> +
>> +struct listen_data {
>> +       int32_t client_id;
>> +       bool start;
>> +};
>> +
>> +static void set_advertising_cb(uint8_t status, void *user_data)
>> +{
>> +       struct listen_data *l = user_data;
>> +
>> +       send_client_listen_notify(l->client_id, status);
>> +
>> +       /* In case of success update advertising state*/
>> +       if (!status)
>> +               advertising_cnt = l->start ? 1 : 0;
>> +
>> +       /*
>> +        * Let's remove client from the list in two cases
>> +        * 1. Start failed
>> +        * 2. Stop succeed
>> +        */
>> +       if ((l->start && status) || (!l->start && !status))
>> +               queue_remove(listen_apps, INT_TO_PTR(l->client_id));
>> +
>> +       free(l);
>> +}
>> +
>>   static void handle_client_unregister(const void *buf, uint16_t len)
>>   {
>>         const struct hal_cmd_gatt_client_unregister *cmd = buf;
>>         uint8_t status;
>> +       void *listening_client;
>> +       struct listen_data *data;
>>
>>         DBG("");
>>
>> +       listening_client = queue_find(listen_apps, match_by_value,
>> +
>> INT_TO_PTR(cmd->client_if));
>> +
>> +       if (listening_client) {
>> +               data = new0(struct listen_data, 1);
>> +               if (!data) {
>> +                       error("gatt: Could not allocate memory for listen
>> data");
>> +                       status = HAL_STATUS_NOMEM;
>> +                       goto reply;
>> +               }
>> +
>> +               data->client_id = cmd->client_if;
>> +               data->start = false;
>> +
>> +               if (!bt_le_set_advertising(data->start,
>> set_advertising_cb,
>> +                                                               data)) {
>> +                       error("gatt: Could not set advertising");
>> +                       status = HAL_STATUS_FAILED;
>> +                       free(data);
>> +                       goto reply;
>> +               }
>> +       }
>
>
> I think this should work like 'handle_client_listen': check the
> 'advertising_cnt' and stop only if the client that unregisters itself is the
> last one that was advertising.
>
> It would be good to actually extract this counter check and advertising set
> from 'handle_client_listen' so it can be reused in
> 'handle_client_unregister'.
>
Yes, I'll change it to trace advertising counter.
>
>> +
>>         status = unregister_app(cmd->client_if);
>>
>> +reply:
>>         ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
>>                                         HAL_OP_GATT_CLIENT_UNREGISTER,
>> status);
>>   }
>> @@ -1948,44 +2012,6 @@ static void handle_client_disconnect(const void
>> *buf, uint16_t len)
>>                                         HAL_OP_GATT_CLIENT_DISCONNECT,
>> status);
>>   }
>>
>> -static void send_client_listen_notify(int32_t id, int32_t status)
>> -{
>> -       struct hal_ev_gatt_client_listen ev;
>> -
>> -       /* Server if because of typo in android headers */
>> -       ev.server_if = id;
>> -       ev.status = status;
>> -
>> -       ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
>> HAL_EV_GATT_CLIENT_LISTEN,
>> -                                                       sizeof(ev), &ev);
>> -}
>> -
>> -struct listen_data {
>> -       int32_t client_id;
>> -       bool start;
>> -};
>> -
>> -static void set_advertising_cb(uint8_t status, void *user_data)
>> -{
>> -       struct listen_data *l = user_data;
>> -
>> -       send_client_listen_notify(l->client_id, status);
>> -
>> -       /* In case of success update advertising state*/
>> -       if (!status)
>> -               advertising_cnt = l->start ? 1 : 0;
>> -
>> -       /*
>> -        * Let's remove client from the list in two cases
>> -        * 1. Start failed
>> -        * 2. Stop succeed
>> -        */
>> -       if ((l->start && status) || (!l->start && !status))
>> -               queue_remove(listen_apps, INT_TO_PTR(l->client_id));
>> -
>> -       free(l);
>> -}
>> -
>>   static void handle_client_listen(const void *buf, uint16_t len)
>>   {
>>         const struct hal_cmd_gatt_client_listen *cmd = buf;
>>
>
> Regards,
> Jakub
>

Best regards,
Grzegorz
