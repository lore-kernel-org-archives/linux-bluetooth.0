Return-Path: <cyrus@holtmann.org>
Message-ID: <500E7564.2080905@ti.com>
Date: Tue, 24 Jul 2012 13:13:56 +0300
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/9] Battery: Discover Characteristic Descriptors
References: <1342533594-10413-1-git-send-email-chen.ganir@ti.com> <1342533594-10413-4-git-send-email-chen.ganir@ti.com> <CAKT1EBfTdVRp8i+atCQOLTNvv8kbRutmK03MYXRUaOuwNcuiog@mail.gmail.com>
In-Reply-To: <CAKT1EBfTdVRp8i+atCQOLTNvv8kbRutmK03MYXRUaOuwNcuiog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/23/2012 11:08 PM, Claudio Takahasi wrote:
> Hi Chen Ganir:
>
> On Tue, Jul 17, 2012 at 10:59 AM, Chen Ganir <chen.ganir@ti.com> wrote:
>> Discover all characteristic descriptors, and build a descriptor
>> list
>> ---
>>   profiles/batterystate/batterystate.c |   70 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>
>> diff --git a/profiles/batterystate/batterystate.c b/profiles/batterystate/batterystate.c
>> index 40663f6..18045ed 100644
>> --- a/profiles/batterystate/batterystate.c
>> +++ b/profiles/batterystate/batterystate.c
>> @@ -50,8 +50,24 @@ static GSList *servers;
>>   struct characteristic {
>>          struct gatt_char        attr;   /* Characteristic */
>>          struct battery          *batt;  /* Parent Battery Service */
>> +       GSList                          *desc;  /* Descriptors */
>>   };
>>
>> +struct descriptor {
>> +       struct characteristic   *ch;    /* Parent Characteristic */
>> +       uint16_t                handle; /* Descriptor Handle */
>> +       bt_uuid_t               uuid;   /* UUID */
>> +};
>> +
>> +static void char_free(gpointer user_data)
>> +{
>> +       struct characteristic *c = user_data;
>> +
>> +       g_slist_free_full(c->desc, g_free);
>> +
>> +       g_free(c);
>> +}
>
> Please fix the following warning:
>
> profiles/batterystate/batterystate.c:62:13: error: 'char_free' defined
> but not used [-Werror=unused-function]
> cc1: all warnings being treated as errors
>
I'll do that.

Anything else for this patch set ?

> BR,
> Claudio
>

Thanks,
Chen Ganir.

-- 
*Chen Ganir***| Texas Instruments | *SW Engineer* Mobile Connectivity
Solutions| Direct: (972)-9-7906080 | Mobile: (972)-52-2438-406|Zarhin
26,Ra'anana, Israel |http://www.ti.com <http://www.ti.com/>
| chen.ganir@ti.com <mailto:chen.ganir@ti.com>



