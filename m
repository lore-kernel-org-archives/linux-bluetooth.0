Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0c9a1cc4-8554-f161-5d64-9152ad12be70@jp.fujitsu.com>
References: <20171213123655.24277-1-luiz.dentz@gmail.com> <20171213123655.24277-6-luiz.dentz@gmail.com>
 <0c9a1cc4-8554-f161-5d64-9152ad12be70@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 Dec 2017 08:45:40 -0200
Message-ID: <CABBYNZKP6Xa8tJ+EconkcqnypJSTQa_fiAMyCXBsXGs6REaYBg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 6/9] client: Rename set-filter-transport to transport
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Thu, Dec 14, 2017 at 7:12 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Hi Luiz,
>
> On 12/13/2017 09:36 PM, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> All commands under scan submenu are related to set-filter so remove its
>> portion from it and make the command return the current value if no
>> parameters:
>>
>> [bluetooth]# transport le
>> SetDiscoveryFilter success
>> [bluetooth]# transport
>> Transport: le
>> ---
>>  client/main.c | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/client/main.c b/client/main.c
>> index 1728a4d82..d8d911a37 100644
>> --- a/client/main.c
>> +++ b/client/main.c
>> @@ -1356,14 +1356,17 @@ static void cmd_scan_filter_pathloss(int argc, char *argv[])
>>       cmd_set_scan_filter_commit();
>>  }
>>
>> -static void cmd_set_scan_filter_transport(int argc, char *argv[])
>> +static void cmd_scan_filter_transport(int argc, char *argv[])
>>  {
>> -     g_free(filtered_scan_transport);
>> +     if (argc < 2 || !strlen(argv[1])) {
>> +             if (filtered_scan_transport)
>> +                     bt_shell_printf("Transport: %s\n",
>> +                                     filtered_scan_transport);
>> +             return;
>> +     }
>>
>> -     if (argc < 2 || !strlen(argv[1]))
>> -             filtered_scan_transport = NULL;
>> -     else
>> -             filtered_scan_transport = g_strdup(argv[1]);
>> +     g_free(filtered_scan_transport);
>> +     filtered_scan_transport = g_strdup(argv[1]);
>
> After applying this patch set, I think that clear command may be needed to
> enhance for clearing a individual filter value. Since all values is needed to
> clear when transport is not want to set after setting uuids/rssi/pathloss/data
> and it.

Yep, that is the drawback of reusing the command to get the current
value, but perhaps we can make clear take an optional parameter to
clear individual options.

>
> Regards,
> Eramoto
>



-- 
Luiz Augusto von Dentz
