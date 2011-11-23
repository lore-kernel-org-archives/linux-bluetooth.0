Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <c594ae0af9ab028cb1d6e273cc8ae35b560f6fbb.1322040739.git.timo.gienger@nokia.com>
References: <c594ae0af9ab028cb1d6e273cc8ae35b560f6fbb.1322040739.git.timo.gienger@nokia.com>
Date: Wed, 23 Nov 2011 16:14:01 +0200
Message-ID: <CABBYNZLWg0M7L-MNjJQV2Eya85qQXd7X-8=1qqNPZJZJGAdKXA@mail.gmail.com>
Subject: Re: [PATCH] Fixed reading of on_mode in btd_adapter_get_mode
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Timo Gienger <timo.gienger@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Timo,

On Wed, Nov 23, 2011 at 3:11 PM, Timo Gienger <timo.gienger@nokia.com> wrote:
> If InitiallyPowered was set to false, it was not possible to
> use hciconfig tool, as on_mode variable was set to MODE_OFF
> making it impossible to enable BT via hciconfig until a DBUS
> call was done and the variable was set in config file as
> connectable.
> Furthermore removed if-else condition, as the both calls
> done exactly the same. Removed also last else condition
> as MODE_OFF should not be valid for on_mode.
> Fix tested with hciops interface.
>
> Signed-off-by: Timo Gienger <timo.gienger@nokia.com>
> ---
>  src/adapter.c |   10 ++--------
>  1 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 2b4b7e3..c58eb47 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2220,14 +2220,8 @@ void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
>                        *mode = main_opts.mode;
>        }
>
> -       if (on_mode) {
> -               if (main_opts.remember_powered == FALSE)
> -                       *on_mode = get_mode(&adapter->bdaddr, "on");
> -               else if (read_on_mode(address, str, sizeof(str)) == 0)
> -                       *on_mode = get_mode(&adapter->bdaddr, str);
> -               else
> -                       *on_mode = main_opts.mode;
> -       }
> +       if (on_mode)
> +               *on_mode = get_mode(&adapter->bdaddr, "on");
>
>        if (pairable)
>                *pairable = adapter->pairable;
> --
> 1.7.0.4
>

Looks good, the description is a little wrong in saying if-else being
exactly the same when what happens is that get_mode calls read_on_mode
when "on" is given so the result is the same but the code path is
different.

-- 
Luiz Augusto von Dentz
