Return-Path: <cyrus@holtmann.org>
Message-ID: <4EDCC7A2.1020008@linux.intel.com>
Date: Mon, 05 Dec 2011 14:31:14 +0100
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v3 1/6] audio: Move tel drivers to DBus interface
References: <1322752445-18771-1-git-send-email-frederic.danis@linux.intel.com> <1322752445-18771-2-git-send-email-frederic.danis@linux.intel.com> <CABBYNZJ75hK0eBkHFJh7kQncsoxDYHc3TGgk6UTAPSPYP_bDbA@mail.gmail.com>
In-Reply-To: <CABBYNZJ75hK0eBkHFJh7kQncsoxDYHc3TGgk6UTAPSPYP_bDbA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

Le 05/12/2011 10:00, Luiz Augusto von Dentz a écrit :
> Hi Frédéric,
>
> 2011/12/1 Frédéric Danis<frederic.danis@linux.intel.com>:
>> +static void free_agent(struct tel_agent *agent)
>> +{
>> +       if (agent->name)
>> +               g_free(agent->name);
>> +
>> +       if (agent->path)
>> +               g_free(agent->path);
>
> You can call g_free directly.

OK

>> +       g_free(agent);
>> +}
>> +

>> +       if (find_agent(NULL, NULL, uuid) != NULL)
>> +               return btd_error_already_exists(msg);
>> +
>> +       /* initialize agent properties */
>> +       for (i=0 ; i<4; i++) {
>> +               if (strcasecmp(uuid, default_properties[i].uuid) == 0) {
>> +                       agent = g_new0(struct tel_agent, 1);
>> +                       agent->properties =&default_properties[i];
>> +                       agent->name = g_strdup(sender);
>> +                       agent->path = g_strdup(path);
>> +                       agent->version = version;
>> +                       agent->features = features;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       if (i == 4)
>> +               return btd_error_invalid_args(msg);
>
> I guess you can use sizeof(default_properties)/sizeof(struct
> default_agent) to calculate the size of the array, anyway I would
> probably split this part in a separate function e.g. agent_new.

OK

>> +       DBG("Register agent : %s%s for %s version 0x%04X with features 0x%02X",
>> +                                       sender, path, uuid, version, features);
>> +
>> +       telsrv.servers = g_slist_append(telsrv.servers, agent);
>> +
>> +       return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
>> +}
>> +

>> diff --git a/doc/assigned-numbers.txt b/doc/assigned-numbers.txt
>> index cda934c..120d7ea 100644
>> --- a/doc/assigned-numbers.txt
>> +++ b/doc/assigned-numbers.txt
>> @@ -8,6 +8,7 @@ avoid conflicts.
>>   Profile                Channel
>>   -----------------------
>>   DUN            1
>> +HSP HS         6
>
> Why not HFP HS?
>
>>   HFP HF         7
>>   OPP            9
>>   FTP            10

I am not sure to understand your comment as I do not touch HFP assigned 
numbers. In HFP specification, roles are Hands-Free unit (HFP HF) and 
Audio Gateway (HFP AG).

Regards

Fred



-- 
Frederic Danis                            Open Source Technology Centre
frederic.danis@intel.com                              Intel Corporation

