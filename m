Return-Path: <cyrus@holtmann.org>
Message-ID: <5022015D.1010307@ti.com>
Date: Wed, 8 Aug 2012 09:04:13 +0300
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 9/9] Battery: Emit property changed on first read
References: <1343194947-13659-1-git-send-email-chen.ganir@ti.com> <1343194947-13659-10-git-send-email-chen.ganir@ti.com> <CAAngNMaAM4zYqhGs+sD18DqwA8Hx8ysiy=6ksCVXo9ygb5V+bQ@mail.gmail.com>
In-Reply-To: <CAAngNMaAM4zYqhGs+sD18DqwA8Hx8ysiy=6ksCVXo9ygb5V+bQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Joao,

On 08/07/2012 07:29 PM, Joao Paulo Rechi Vita wrote:
> On Wed, Jul 25, 2012 at 2:42 AM, Chen Ganir <chen.ganir@ti.com> wrote:
>> Emit battery level property changed upon connection, on first read.
>> ---
>>   profiles/batterystate/batterystate.c |    3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/profiles/batterystate/batterystate.c b/profiles/batterystate/batterystate.c
>> index 718863b..4300f85 100644
>> --- a/profiles/batterystate/batterystate.c
>> +++ b/profiles/batterystate/batterystate.c
>> @@ -72,6 +72,8 @@ struct descriptor {
>>          bt_uuid_t               uuid;           /* UUID */
>>   };
>>
>> +static void emit_battery_level_changed(struct characteristic *c);
>> +
>
> No need of this forward declaration, simply move the function
> implementation before the first function that references it
> (read_batterylevel_cb).
>
I will move the function as suggested.

>>   static void char_free(gpointer user_data)
>>   {
>>          struct characteristic *c = user_data;
>> @@ -161,6 +163,7 @@ static void read_batterylevel_cb(guint8 status, const guint8 *pdu, guint16 len,
>>          }
>>
>>          ch->level = value[0];
>> +       emit_battery_level_changed(ch);
>>   }
>>
>>   static void process_batteryservice_char(struct characteristic *ch)
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

Thanks,
Chen Ganir.
