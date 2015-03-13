Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLZxvzdjz+XcjJNne9DBLOR8m79qPq-dQ7vaVEqAzJ4dA@mail.gmail.com>
References: <1426097463-5288-1-git-send-email-marcin.kraglak@tieto.com>
	<1426097463-5288-5-git-send-email-marcin.kraglak@tieto.com>
	<CABBYNZLZxvzdjz+XcjJNne9DBLOR8m79qPq-dQ7vaVEqAzJ4dA@mail.gmail.com>
Date: Fri, 13 Mar 2015 10:47:35 +0100
Message-ID: <CABD6X-KmCnNyBEXTKKtzGqxd8tDgo4waixQcbyy_5wm-Gyqo+Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] plugins/policy: Try reconnect Control/Target services
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 13 March 2015 at 09:42, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Marcin,
>
> On Wed, Mar 11, 2015 at 8:11 PM, Marcin Kraglak
> <marcin.kraglak@tieto.com> wrote:
>> If state of Control/Remote services changed from CONNECTING to
>> DISCONNECTED, and error is set to -EAGAIN, set random timer and try
>> reconnect. This approach is described in AVRCP Spec 1.5 4.1.1:
>> "If both devices open an AVCTP channel at the same time both channels
>> shall be closed and each device shall wait a random time
>> (not more than 1 s and not less than 100ms) and then try to open
>> the AVCTP channel again."
>> ---
>>  plugins/policy.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 80 insertions(+)
>>
>> diff --git a/plugins/policy.c b/plugins/policy.c
>> index 9cbf146..306a7a3 100644
>> --- a/plugins/policy.c
>> +++ b/plugins/policy.c
>> @@ -50,6 +50,16 @@
>>  #define SINK_RETRY_TIMEOUT SOURCE_RETRY_TIMEOUT
>>  #define SOURCE_RETRIES 1
>>  #define SINK_RETRIES SOURCE_RETRIES
>> +#define CT_RETRIES 1
>> +#define TG_RETRIES CT_RETRIES
>> +
>> +/*
>> + * AVRCP Spec 1.5 says that reconnect timeout after connection collision
>> + * should be random value between 100 ms and 1000 ms. To improve user experience
>> + * we linit MAX value to 500 ms
>> + */
>> +#define RECONNECT_MAX_TIMEOUT 500
>> +#define RECONNECT_MIN_TIMEOUT 100
>
> Im not sure we should use sub seconds values, g_timeout_add_seconds
> allows group wake-up whereas g_timeout_add doesn't (see
> g_timeout_add_seconds_full documentation), so perhaps going with 1
> sec. for reconnect is fine here since by design g_timeout_add_seconds
> will not be precise so you have some randomness already.

That's fine with me, I'll change it to 1 sec timeout.
>
>>  /* Tracking of remote services to be auto-reconnected upon link loss */
>>
>> @@ -82,7 +92,9 @@ struct policy_data {
>>         guint sink_timer;
>>         uint8_t sink_retries;
>>         guint ct_timer;
>> +       uint8_t ct_retries;
>>         guint tg_timer;
>> +       uint8_t tg_retries;
>>  };
>>
>>  static void policy_connect(struct policy_data *data,
>> @@ -111,6 +123,7 @@ static gboolean policy_connect_ct(gpointer user_data)
>>         struct btd_service *service;
>>
>>         data->ct_timer = 0;
>> +       data->ct_retries++;
>>
>>         service = btd_device_get_service(data->dev, AVRCP_REMOTE_UUID);
>>         if (service != NULL)
>> @@ -128,6 +141,23 @@ static void policy_set_ct_timer(struct policy_data *data)
>>                                                 policy_connect_ct, data);
>>  }
>>
>> +static void policy_set_random_ct_timer(struct policy_data *data)
>> +{
>> +       GRand *rand;
>> +       int timeout;
>> +
>> +       rand = g_rand_new();
>> +       timeout = g_rand_int_range(rand, RECONNECT_MIN_TIMEOUT,
>> +                                                       RECONNECT_MAX_TIMEOUT);
>> +
>> +       if (data->ct_timer > 0)
>> +               g_source_remove(data->ct_timer);
>> +
>> +       data->ct_timer = g_timeout_add(timeout, policy_connect_ct, data);
>> +
>> +       g_rand_free(rand);
>> +}
>> +
>>  static struct policy_data *find_data(struct btd_device *dev)
>>  {
>>         GSList *l;
>> @@ -273,6 +303,7 @@ static gboolean policy_connect_tg(gpointer user_data)
>>         struct btd_service *service;
>>
>>         data->tg_timer = 0;
>> +       data->tg_retries++;
>>
>>         service = btd_device_get_service(data->dev, AVRCP_TARGET_UUID);
>>         if (service != NULL)
>> @@ -291,6 +322,23 @@ static void policy_set_tg_timer(struct policy_data *data)
>>                                                         data);
>>  }
>>
>> +static void policy_set_random_tg_timer(struct policy_data *data)
>> +{
>> +       GRand *rand;
>> +       int timeout;
>> +
>> +       rand = g_rand_new();
>> +       timeout = g_rand_int_range(rand, RECONNECT_MIN_TIMEOUT,
>> +                                                       RECONNECT_MAX_TIMEOUT);
>> +
>> +       if (data->tg_timer > 0)
>> +               g_source_remove(data->tg_timer);
>> +
>> +       data->tg_timer = g_timeout_add(timeout, policy_connect_tg, data);
>> +
>> +       g_rand_free(rand);
>> +}
>> +
>>  static gboolean policy_connect_source(gpointer user_data)
>>  {
>>         struct policy_data *data = user_data;
>> @@ -401,6 +449,22 @@ static void controller_cb(struct btd_service *service,
>>                 }
>>                 break;
>>         case BTD_SERVICE_STATE_DISCONNECTED:
>> +               if (old_state == BTD_SERVICE_STATE_CONNECTING) {
>> +                       int err = btd_service_get_error(service);
>> +
>> +                       if (err == -EAGAIN) {
>> +                               if (data->ct_retries < CT_RETRIES)
>> +                                       policy_set_random_ct_timer(data);
>> +                               else
>> +                                       data->ct_retries = 0;
>> +                               break;
>> +                       } else if (data->ct_timer > 0) {
>> +                               g_source_remove(data->ct_timer);
>> +                               data->ct_timer = 0;
>> +                       }
>> +               } else if (old_state == BTD_SERVICE_STATE_CONNECTED) {
>> +                       data->ct_retries = 0;
>> +               }
>>                 break;
>>         case BTD_SERVICE_STATE_CONNECTING:
>>                 break;
>> @@ -434,6 +498,22 @@ static void target_cb(struct btd_service *service,
>>                 }
>>                 break;
>>         case BTD_SERVICE_STATE_DISCONNECTED:
>> +               if (old_state == BTD_SERVICE_STATE_CONNECTING) {
>> +                       int err = btd_service_get_error(service);
>> +
>> +                       if (err == -EAGAIN) {
>> +                               if (data->tg_retries < TG_RETRIES)
>> +                                       policy_set_random_tg_timer(data);
>> +                               else
>> +                                       data->tg_retries = 0;
>> +                               break;
>> +                       } else if (data->tg_timer > 0) {
>> +                               g_source_remove(data->tg_timer);
>> +                               data->tg_timer = 0;
>> +                       }
>> +               } else if (old_state == BTD_SERVICE_STATE_CONNECTED) {
>> +                       data->tg_retries = 0;
>> +               }
>>                 break;
>>         case BTD_SERVICE_STATE_CONNECTING:
>>                 break;
>> --
>> 2.1.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz



-- 
BR
Marcin Kraglak
