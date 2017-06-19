Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK_DQxYFowC2vX_DtnM9NCd0Yn+CzOV2mzLoCMRiMAbJA@mail.gmail.com>
References: <20170609130258.23401-1-luiz.dentz@gmail.com> <87h8zjg4v3.fsf@intel.com>
 <CAHgsZ+jB9E-5Cmyu5rimPT=k_n=ZyCUyEmjaxMFTxUDy69AeBA@mail.gmail.com> <CABBYNZK_DQxYFowC2vX_DtnM9NCd0Yn+CzOV2mzLoCMRiMAbJA@mail.gmail.com>
From: Miao-chen Chou <mcchou@chromium.org>
Date: Mon, 19 Jun 2017 14:19:54 -0700
Message-ID: <CAHgsZ+h4w4NtU41zKj4jEL=jS2O+9dorb-h5dS-mmj0KHHbU+w@mail.gmail.com>
Subject: Re: [PATCH v3] core/gatt: Add GATT.Cache config option
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Thanks for the update. Is there an estimated time to land this patch?

Best,
Miao

On Sat, Jun 17, 2017 at 12:40 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Thu, Jun 15, 2017 at 5:31 AM, Miao-chen Chou <mcchou@chromium.org> wrote:
>> Hi Luiz,
>>
>> Thanks for the patch. It'd be better if a bit more description is
>> added to main.conf about the difference between "always" and "yes"
>> options in terms of unpair/paired devices. The fix looks good to me.
>
> Ive added some description for the options.
>
>> Thanks,
>> Miao
>>
>> On Tue, Jun 13, 2017 at 10:44 AM, Vinicius Costa Gomes
>> <vinicius.gomes@intel.com> wrote:
>>> Hi Luiz,
>>>
>>> Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:
>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>
>>>> This adds GATT.Cache config option to main.conf which can be used
>>>> to adjust the cache expected behavior of attributes found over GATT.
>>>> ---
>>>>  src/device.c  | 28 ++++++++++++++++++++++++++++
>>>>  src/hcid.h    |  7 +++++++
>>>>  src/main.c    | 26 +++++++++++++++++++++++++-
>>>>  src/main.conf |  6 ++++++
>>>>  4 files changed, 66 insertions(+), 1 deletion(-)
>>>>
>>>
>>> [...]
>>>
>>>>
>>>> +static void parse_gatt_cache(const char *cache)
>>>> +{
>>>> +     if (!strcmp(cache, "always")) {
>>>> +             main_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
>>>> +     } else if (!strcmp(cache, "yes")) {
>>>> +             main_opts.gatt_cache = BT_GATT_CACHE_YES;
>>>> +     } else if (!strcmp(cache, "no")) {
>>>> +             main_opts.gatt_cache = BT_GATT_CACHE_NO;
>>>> +     } else {
>>>> +             DBG("Invalid value for KeepCache=%s", cache);
>>>> +     }
>>>
>>> [optional] I wonder if making this return the enum, and return the
>>> default if 'cache' is NULL, would make the code clearer.
>
> Done.
>
>>>> +}
>>>> +
>>>>  static void check_config(GKeyFile *config)
>>>>  {
>>>> -     const char *valid_groups[] = { "General", "Policy", NULL };
>>>> +     const char *valid_groups[] = { "General", "Policy", "GATT", NULL };
>>>>       char **keys;
>>>>       int i;
>>>>
>>>> @@ -357,6 +370,17 @@ static void parse_config(GKeyFile *config)
>>>>               g_clear_error(&err);
>>>>       else
>>>>               main_opts.fast_conn = boolean;
>>>> +
>>>> +     str = g_key_file_get_string(config, "GATT", "Cache", &err);
>>>> +     if (err) {
>>>> +             g_clear_error(&err);
>>>> +             main_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     parse_gatt_cache(str);
>>>> +
>>>> +     g_free(str);
>>>>  }
>>>>
>>>>  static void init_defaults(void)
>>>> diff --git a/src/main.conf b/src/main.conf
>>>> index a649276..7807a8f 100644
>>>> --- a/src/main.conf
>>>> +++ b/src/main.conf
>>>> @@ -71,6 +71,12 @@
>>>>  # Defaults to "off"
>>>>  # Privacy = off
>>>>
>>>> +[GATT]
>>>> +# GATT attribute cache.
>>>> +# Possible values: always, yes, no
>>>> +# Default: always
>>>> +#Cache = always
>>>> +
>>>>  [Policy]
>>>>  #
>>>>  # The ReconnectUUIDs defines the set of remote services that should try
>>>> --
>
> Applied after a few changes mentioned above.
>
> --
> Luiz Augusto von Dentz
