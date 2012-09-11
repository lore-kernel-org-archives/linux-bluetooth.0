Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120907095932.GA7057@x220>
References: <1346785482-13359-1-git-send-email-jprvita@openbossa.org>
	<1346785482-13359-2-git-send-email-jprvita@openbossa.org>
	<20120907095932.GA7057@x220>
Date: Tue, 11 Sep 2012 10:34:13 -0300
Message-ID: <CAAngNMa2Gewn-GOpW_RVM2ji0F=rvtPOH1D6eAKt2Cm=Q=FAtg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 01/14] core: Control connections based on adapter state
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Sep 7, 2012 at 6:59 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Tue, Sep 04, 2012, João Paulo Rechi Vita wrote:
>> +static void set_auto_connect(gpointer data, gpointer user_data)
>> +{
>> +     struct btd_device *device = data;
>> +     gboolean enable = GPOINTER_TO_INT(user_data);
>> +
>> +     device_set_auto_connect(device, enable);
>> +}
>> +
>>  static void call_adapter_powered_callbacks(struct btd_adapter *adapter,
>>                                               gboolean powered)
>>  {
>> @@ -2125,7 +2133,10 @@ static void call_adapter_powered_callbacks(struct btd_adapter *adapter,
>>               btd_adapter_powered_cb cb = l->data;
>>
>>               cb(adapter, powered);
>> -       }
>> +     }
>> +
>> +     g_slist_foreach(adapter->devices, set_auto_connect,
>> +                                             GINT_TO_POINTER(powered));
>
> Instead of this GINT_TO_POINTER magic on a variable that isn't even a
> gint couldn't you just pass &powered to g_slist_foreach and then in the
> callback do:
>
>         gboolean enable = *(gboolean *) user_data;
>
> or
>
>         gboolean *enable = user_data;
>
>         device_set_auto_connect(device, *enable);
>

I'm sending an updated version now.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
