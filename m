Return-Path: <cyrus@holtmann.org>
Message-ID: <505AF75F.6080509@ti.com>
Date: Thu, 20 Sep 2012 14:00:47 +0300
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] battery: Add support for notifications
References: <1348129663-1701-1-git-send-email-chen.ganir@ti.com> <1348129663-1701-10-git-send-email-chen.ganir@ti.com> <CAJdJm_P07N-VwgnHy=1m3D68086dP9fFy5AmkhZC_3b4d2xpmg@mail.gmail.com>
In-Reply-To: <CAJdJm_P07N-VwgnHy=1m3D68086dP9fFy5AmkhZC_3b4d2xpmg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Anderson,

On 09/20/2012 01:54 PM, Anderson Lizardo wrote:
> Hi Chen,
>
> On Thu, Sep 20, 2012 at 4:27 AM,  <chen.ganir@ti.com> wrote:
>> @@ -140,6 +156,18 @@ static void process_batteryservice_char(struct characteristic *ch)
>>          }
>>   }
>>
>> +static void batterylevel_enable_notify_cb(guint8 status, const guint8 *pdu,
>> +                                               guint16 len, gpointer user_data)
>> +{
>> +       struct characteristic *ch = (struct characteristic *)user_data;
>
> Casting above seems unnecessary (gpointer is typedef to void*).
>
I'll change that.

>> +
>> +       if (status != 0) {
>> +               error("Could not enable batt level notification.");
>> +               ch->canNotify = FALSE;
>
> This camelCase is inconsistent with other struct fields on the same file.
>
Will be changed.


>> +               process_batteryservice_char(ch);
>> +       }
>> +}
>> +
>>   static gint device_battery_cmp(gconstpointer a, gconstpointer b)
>>   {
>>          const struct characteristic *ch = a;
>
> Regards,
>

Thanks !

-- 
BR,
Chen Ganir

