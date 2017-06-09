Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87shjip2h5.fsf@intel.com>
References: <20170531105640.3132-1-luiz.dentz@gmail.com> <87shjip2h5.fsf@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Jun 2017 16:04:22 +0300
Message-ID: <CABBYNZ+aSxcvUB0icgDeaLwdUOmXRY9FJCKvG=0NUsBOGuKWZQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/gatt: Add KeepCache config option
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Jun 2, 2017 at 11:19 PM, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
> Hi Luiz,
>
> Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:
>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This adds [GATT] KeepCache config option to main.conf which can be used
>> to adjust the cache behavior of attributes found over GATT.
>> ---
>>  src/device.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>  src/main.c    |  2 +-
>>  src/main.conf |  6 ++++++
>>  3 files changed, 53 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/device.c b/src/device.c
>> index 50e7f23..dfb7b1f 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -261,6 +261,8 @@ static const uint16_t uuid_list[] = {
>>       0
>>  };
>>
>> +static char *gatt_cache;
>
> There's already a main_opts (defined in hcid.h, brings back memories :-)
> for this kind of thing. Is there a reason you didn't use it?

Nice catch, it seems I had forgotten about it.

>> +
>>  static int device_browse_gatt(struct btd_device *device, DBusMessage *msg);
>>  static int device_browse_sdp(struct btd_device *device, DBusMessage *msg);
>>
>> @@ -522,11 +524,32 @@ static void browse_request_free(struct browse_req *req)
>>       g_free(req);
>>  }
>>
>
> [...]
>
>> @@ -6121,9 +6150,26 @@ struct btd_service *btd_device_get_service(struct btd_device *dev,
>>
>>  void btd_device_init(void)
>>  {
>> +     GKeyFile *conf;
>> +     GError *err = NULL;
>> +
>>       dbus_conn = btd_get_dbus_connection();
>>       service_state_cb_id = btd_service_add_state_cb(
>>                                               service_state_changed, NULL);
>> +
>> +     conf = btd_get_main_conf();
>> +     if (!conf) {
>> +             gatt_cache = g_strdup("always");
>> +             return;
>> +     }
>> +
>> +     gatt_cache = g_key_file_get_string(conf, "GATT", "KeepCache", &err);
>> +     if (!err)
>> +             return;
>> +
>> +     DBG("%s", err->message);
>> +     g_clear_error(&err);
>> +     gatt_cache = g_strdup("always");
>
> Overwriting the value looks wrong.

Indeed, that should be fixed now.

>>  }
>>
>
>
> Cheers,
> --
> Vinicius



-- 
Luiz Augusto von Dentz
