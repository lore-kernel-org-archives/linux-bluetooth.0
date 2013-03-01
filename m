Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <DA672AA1-BB12-44A4-9BDC-A7A25660DF2C@holtmann.org>
References: <1362140773-13672-1-git-send-email-luiz.dentz@gmail.com>
	<1362140773-13672-2-git-send-email-luiz.dentz@gmail.com>
	<DA672AA1-BB12-44A4-9BDC-A7A25660DF2C@holtmann.org>
Date: Fri, 1 Mar 2013 19:38:25 +0200
Message-ID: <CABBYNZ+u6JF8XtU8qiUy7ERrQg5o2Q-N2b2_4PxUn=Mg96Q=Vw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] core: Add DisableProfiles entry to main.conf
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 1, 2013 at 6:17 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>
>> This entry can be used to globally disable profiles, this is specially
>> useful for qualification purposes where some platforms may decide to
>> only qualify a subset of the supported profiles.
>> ---
>> src/hcid.h    |  1 +
>> src/main.c    | 10 ++++++++++
>> src/main.conf |  4 ++++
>> src/profile.c | 24 ++++++++++++++++++++++++
>> 4 files changed, 39 insertions(+)
>>
>> diff --git a/src/hcid.h b/src/hcid.h
>> index ea67cc2..f465a2b 100644
>> --- a/src/hcid.h
>> +++ b/src/hcid.h
>> @@ -32,6 +32,7 @@ struct main_opts {
>>       gboolean        reverse_sdp;
>>       gboolean        name_resolv;
>>       gboolean        debug_keys;
>> +     char            **disabled_profiles;
>>
>>       uint16_t        did_source;
>>       uint16_t        did_vendor;
>> diff --git a/src/main.c b/src/main.c
>> index 1e40ebc..933c20f 100644
>> --- a/src/main.c
>> +++ b/src/main.c
>> @@ -76,6 +76,7 @@ static const char * const supported_options[] = {
>>       "ReverseServiceDiscovery",
>>       "NameResolving",
>>       "DebugKeys",
>> +     "DisableProfiles"
>> };
>>
>> static GKeyFile *load_config(const char *file)
>> @@ -263,6 +264,15 @@ static void parse_config(GKeyFile *config)
>>               g_clear_error(&err);
>>       else
>>               main_opts.debug_keys = boolean;
>> +
>> +     str = g_key_file_get_string(config, "General", "DisableProfiles", &err);
>> +     if (err) {
>> +             DBG("%s", err->message);
>> +             g_clear_error(&err);
>> +     } else {
>> +             main_opts.disabled_profiles = g_strsplit(str, " ", -1);
>> +             g_free(str);
>> +     }
>> }
>
> I am not a huge fan of adding this one back. Do we really need it?

This is for profiles we used to have for plugins but they are not 1:1
to profiles so -p/-P may not be enough, we could instead take as
command line option but 128 bit UUID sounds a little too messy to pass
in the command line. Mikel also comment about having this to block
external process to register profiles, maybe it is a good idea since
we don't have to create a similar mechanism to other components such
as obexd, oFono and PulseAudio just to disable certain roles.


-- 
Luiz Augusto von Dentz
