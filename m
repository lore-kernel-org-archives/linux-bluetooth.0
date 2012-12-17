Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1355759155-27921-3-git-send-email-luiz.dentz@gmail.com>
References: <1355759155-27921-1-git-send-email-luiz.dentz@gmail.com>
	<1355759155-27921-3-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 17 Dec 2012 11:55:37 -0400
Message-ID: <CAJdJm_N+5_wcvGw7wkgx+Ryr3EkB-Mcd0hfGmK4u=42LL9=fHg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/5] core: Simplify set_powered to not use set_mode
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Dec 17, 2012 at 11:45 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> -       err = set_mode(adapter, mode);
> +       err = mgmt_set_powered(adapter->dev_id, powered);
>         if (err < 0)
>                 return g_dbus_pending_property_error(id,
>                                                 ERROR_INTERFACE ".Failed",
> -                                               strerror(-err));
> +                                               strerror(err));

Looks like you changed the line above by mistake, err is negative and
thus need to be made positive to pass to strerror().

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
