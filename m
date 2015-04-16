Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <204171214.V0XEUk3NZF@leonov>
References: <1429019315-29216-1-git-send-email-szymon.janc@tieto.com>
	<204171214.V0XEUk3NZF@leonov>
Date: Thu, 16 Apr 2015 17:42:58 +0300
Message-ID: <CABBYNZLLpB0kUuEK4W8CsM2Gf27zG_cDbkStaQ-nHuFu7XDhuw@mail.gmail.com>
Subject: Re: [PATCH] android/avrcp-lib: Use void pointer in register_notification
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Apr 16, 2015 at 2:24 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> On Tuesday 14 of April 2015 15:48:35 Szymon Janc wrote:
>> In this callback params vary depending on code. Passing those as void*
>> allows to avoid extra memcpy that would be otherwise needed to
>> avoid warnings due to increased alignment when casting.
>> ---
>>  android/avrcp-lib.h | 2 +-
>>  android/avrcp.c     | 5 +++--
>>  unit/test-avrcp.c   | 9 +++++----
>>  3 files changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
>> index add7739..6554b12 100644
>> --- a/android/avrcp-lib.h
>> +++ b/android/avrcp-lib.h
>> @@ -224,7 +224,7 @@ struct avrcp_control_cfm {
>>                                       char **text, void *user_data);
>>       bool (*register_notification) (struct avrcp *session, int err,
>>                                       uint8_t code, uint8_t event,
>> -                                     uint8_t *params, void *user_data);
>> +                                     void *params, void *user_data);
>>       void (*set_volume) (struct avrcp *session, int err, uint8_t volume,
>>                                       void *user_data);
>>       void (*set_addressed) (struct avrcp *session, int err,
>> diff --git a/android/avrcp.c b/android/avrcp.c
>> index bcb4228..8c3e25a 100644
>> --- a/android/avrcp.c
>> +++ b/android/avrcp.c
>> @@ -748,11 +748,12 @@ static const struct avrcp_control_ind control_ind = {
>>
>>  static bool handle_register_notification_rsp(struct avrcp *session, int
>> err, uint8_t code, uint8_t event,
>> -                                             uint8_t *params,
>> +                                             void *params,
>>                                               void *user_data)
>>  {
>>       struct avrcp_device *dev = user_data;
>>       struct hal_ev_avrcp_volume_changed ev;
>> +     uint8_t *volume = params;
>>
>>       if (err < 0) {
>>               error("AVRCP: %s", strerror(-err));
>> @@ -766,7 +767,7 @@ static bool handle_register_notification_rsp(struct
>> avrcp *session, int err, return false;
>>
>>       ev.type = code;
>> -     ev.volume = params[0] & 0x7f;
>> +     ev.volume = volume[0];

With the above change we would not ignore the most significant bit.

>>       ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
>>                                       HAL_EV_AVRCP_VOLUME_CHANGED,
>> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
>> index a610ad5..01307e6 100644
>> --- a/unit/test-avrcp.c
>> +++ b/unit/test-avrcp.c
>> @@ -826,22 +826,23 @@ static void set_volume_rsp(struct avrcp *session, int
>> err, uint8_t volume,
>>
>>  static bool register_notification_rsp(struct avrcp *session, int err,
>>                                       uint8_t code, uint8_t event,
>> -                                     uint8_t *params, void *user_data)
>> +                                     void *params, void *user_data)
>>  {
>>       struct context *context = user_data;
>> +     uint8_t *p = params;
>>
>>       g_assert_cmpint(err, ==, 0);
>>
>>       switch (event) {
>>       case AVRCP_EVENT_VOLUME_CHANGED:
>>               if (g_str_equal(context->data->test_name, "/TP/VLH/BV-03-C")) {
>> -                     g_assert_cmpint(params[0], ==, 0);
>> +                     g_assert_cmpint(p[0], ==, 0);
>>                       break;
>>               } else if (code == AVC_CTYPE_INTERIM) {
>> -                     g_assert_cmpint(params[0], ==, 0);
>> +                     g_assert_cmpint(p[0], ==, 0);
>>                       return true;
>>               }
>> -             g_assert_cmpint(params[0], ==, 1);
>> +             g_assert_cmpint(p[0], ==, 1);
>>               break;
>>       }
>
> Applied.
>
> --
> BR
> Szymon Janc
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
