Return-Path: <cyrus@holtmann.org>
Message-ID: <5050159C.7030307@ti.com>
Date: Wed, 12 Sep 2012 07:54:52 +0300
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 07/10] battery: Add Battery to device
References: <1347349100-24228-1-git-send-email-chen.ganir@ti.com> <1347349100-24228-8-git-send-email-chen.ganir@ti.com> <CAAngNMbnRc-JxTP_aGwVbyov3bsd=dVgAC=GkjMM9mnzgtNPQQ@mail.gmail.com>
In-Reply-To: <CAAngNMbnRc-JxTP_aGwVbyov3bsd=dVgAC=GkjMM9mnzgtNPQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 09/12/2012 12:40 AM, Joao Paulo Rechi Vita wrote:
> On Tue, Sep 11, 2012 at 4:38 AM,  <chen.ganir@ti.com> wrote:
>> From: Chen Ganir <chen.ganir@ti.com>
>>
>> Add/Remove battery from device
>> ---
>>   profiles/battery/battery.c |   14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
>> index d1e0b6e..31f2297 100644
>> --- a/profiles/battery/battery.c
>> +++ b/profiles/battery/battery.c
>> @@ -49,8 +49,9 @@ struct battery {
>>   static GSList *servers;
>>
>>   struct characteristic {
>> -       struct gatt_char        attr;   /* Characteristic */
>> -       struct battery          *batt;  /* Parent Battery Service */
>> +       struct device_battery  *devbatt;        /* device_battery pointer */
>> +       struct gatt_char        attr;           /* Characteristic */
>> +       struct battery          *batt;          /* Parent Battery Service */
>
> Just a minor pick here: the comment alignment of attr and batt should
> have been fixed on the previous commit, to keep it consistent along
> the series.
>
You are correct. That should have been like that, but i missed it. Will 
fix it.

>>          GSList                          *desc;  /* Descriptors */
>>          uint8_t                 ns;             /* Battery Namespace */
>>          uint16_t                description;    /* Battery description */
>> @@ -79,6 +80,8 @@ static void char_free(gpointer user_data)
>>
>>          g_slist_free_full(c->desc, g_free);
>>
>> +       btd_device_remove_battery(c->devbatt);
>> +
>>          g_free(c);
>>   }
>>
>> @@ -160,12 +163,12 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
>>          if (status != 0) {
>>                  error("Discover all characteristic descriptors failed [%s]: %s",
>>                                          ch->attr.uuid, att_ecode2str(status));
>> -               return;
>> +               goto update_char;
>>          }
>>
>>          list = dec_find_info_resp(pdu, len, &format);
>>          if (list == NULL)
>> -               return;
>> +               goto update_char;
>>
>>          for (i = 0; i < list->num; i++) {
>>                  struct descriptor *desc;
>> @@ -186,6 +189,9 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
>>          }
>>
>>          att_data_list_free(list);
>> +
>> +update_char:
>> +       ch->devbatt = btd_device_add_battery(ch->batt->dev);
>
> If I understood correctly, adding a battery to the device is a
> consequence of finding the "Battery Level" characteristic, and not
> related to the descriptors discovery. So the call to
> btd_device_add_battery() should be done inside the
> configure_battery_cb() instead of the discover_desc_cb(). This way
> you'll not need all these goto's.
>
You are correct. It can be done there.

>>   }
>>
>>
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

-- 
BR,
Chen Ganir

