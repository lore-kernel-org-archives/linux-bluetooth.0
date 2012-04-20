Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334858615-11750-1-git-send-email-luiz.dentz@gmail.com>
References: <1334858615-11750-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 20 Apr 2012 07:48:20 -0400
Message-ID: <CAJdJm_NE5i+7UwsQQuw_==Y0_LgYK2Tz8BugET4od7fFPpYiQQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Remove DiscoverSchedulerInterval option from main.conf
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Apr 19, 2012 at 2:03 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> @@ -2541,11 +2541,10 @@ void adapter_set_discovering(struct btd_adapter *adapter,
>        if (!adapter_has_discov_sessions(adapter) || adapter->discov_suspended)
>                return;
>
> -       DBG("hci%u enabling timer, disc_sessions %u", adapter->dev_id,
> +       DBG("hci%u restarting discovery, disc_sessions %u", adapter->dev_id,
>                                        g_slist_length(adapter->disc_sessions));
>
> -       adapter->discov_id = g_timeout_add_seconds(main_opts.discov_interval,
> -                                                       discovery_cb, adapter);
> +       adapter->discov_id = g_idle_add(discovery_cb, adapter);

Is it necessary to keep this id? I thought g_idle_add() would run as
soon as (or close) control returns to mainloop.

>  }

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
