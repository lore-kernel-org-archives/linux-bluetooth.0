Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NE5i+7UwsQQuw_==Y0_LgYK2Tz8BugET4od7fFPpYiQQ@mail.gmail.com>
References: <1334858615-11750-1-git-send-email-luiz.dentz@gmail.com>
	<CAJdJm_NE5i+7UwsQQuw_==Y0_LgYK2Tz8BugET4od7fFPpYiQQ@mail.gmail.com>
Date: Fri, 20 Apr 2012 14:57:58 +0300
Message-ID: <CABBYNZJxtwuz6e1tzVRwSV8-C3FDmuuy6ATg7QV5CO0a7oKSOQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Remove DiscoverSchedulerInterval option from main.conf
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Fri, Apr 20, 2012 at 2:48 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Luiz,
>
> On Thu, Apr 19, 2012 at 2:03 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> @@ -2541,11 +2541,10 @@ void adapter_set_discovering(struct btd_adapter *adapter,
>>        if (!adapter_has_discov_sessions(adapter) || adapter->discov_suspended)
>>                return;
>>
>> -       DBG("hci%u enabling timer, disc_sessions %u", adapter->dev_id,
>> +       DBG("hci%u restarting discovery, disc_sessions %u", adapter->dev_id,
>>                                        g_slist_length(adapter->disc_sessions));
>>
>> -       adapter->discov_id = g_timeout_add_seconds(main_opts.discov_interval,
>> -                                                       discovery_cb, adapter);
>> +       adapter->discov_id = g_idle_add(discovery_cb, adapter);
>
> Is it necessary to keep this id? I thought g_idle_add() would run as
> soon as (or close) control returns to mainloop.

I keep it just to avoid having to cancel the discovery in case the
discovery session is dropped during the same mainloop iteration, so it
let all the events be processed before restarting the discovery.


-- 
Luiz Augusto von Dentz
