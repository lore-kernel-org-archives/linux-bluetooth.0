Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+6KyKas1KMg8XZ=Ch52HCnNGiuXGW7X9cWKDNL68R0=bphHqA@mail.gmail.com>
References: <1347541403-11780-1-git-send-email-chen.ganir@ti.com>
	<1347541403-11780-8-git-send-email-chen.ganir@ti.com>
	<CA+6KyKas1KMg8XZ=Ch52HCnNGiuXGW7X9cWKDNL68R0=bphHqA@mail.gmail.com>
Date: Fri, 14 Sep 2012 18:20:48 +0200
Message-ID: <CA+6KyKaafdf6BdeK75BSv0YJm-Kn7+bq=tpynOuTz6oyu3UD_w@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] battery: Add Battery to device
From: Andrzej Kaczmarek <andrzejk@gmail.com>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi again,

Small clarification below.

On Fri, Sep 14, 2012 at 6:15 PM, Andrzej Kaczmarek <andrzejk@gmail.com> wrote:
> Hi Chen,
>
> On Thu, Sep 13, 2012 at 3:03 PM,  <chen.ganir@ti.com> wrote:
>> From: Chen Ganir <chen.ganir@ti.com>
>>
>> Add/Remove battery from device
>> ---
>>  profiles/battery/battery.c |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
>> index c368768..3a2e604 100644
>> --- a/profiles/battery/battery.c
>> +++ b/profiles/battery/battery.c
>> @@ -49,6 +49,7 @@ struct battery {
>>  static GSList *servers;
>>
>>  struct characteristic {
>> +       struct btd_battery      *devbatt;       /* device_battery pointer */
>>         struct gatt_char        attr;           /* Characteristic */
>>         struct battery          *batt;          /* Parent Battery Service */
>>         GSList                  *desc;          /* Descriptors */
>> @@ -79,6 +80,8 @@ static void char_free(gpointer user_data)
>>
>>         g_slist_free_full(c->desc, g_free);
>>
>> +       btd_device_remove_battery(c->devbatt);
>> +
>>         g_free(c);
>>  }
>>
>> @@ -228,6 +231,8 @@ static void configure_battery_cb(GSList *characteristics, guint8 status,
>>
>>                         gatt_find_info(batt->attrib, start, end,
>>                                                         discover_desc_cb, ch);
>> +
>> +                       ch->devbatt = btd_device_add_battery(ch->batt->dev);
>
> This should be done before starting characteristics discovery as
> otherwise Battery won't be registered in case characteristics has no
> descriptors (e.g. most devices which do not support notifications for
> Battery Level and have only one battery).

Of course I meant "before starting characteristic descriptors discovery"...

BR,
Andrzej
