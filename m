Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1436265650-6157-1-git-send-email-luiz.dentz@gmail.com>
References: <1436265650-6157-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 7 Jul 2015 15:15:18 +0300
Message-ID: <CABBYNZK64ZB9uVSr1o+0BdECwW+FERKBQoVRx6VVkyoXv+pJkA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/profiles: Fix not handling disconnections properly
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 7, 2015 at 1:40 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If a profiles disconnects while in connecting state but ext_connect has
> already been called the state is never updated since ext_io_disconnected
> always calls btd_service_disconnecting_complete.
> ---
>  src/profile.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/src/profile.c b/src/profile.c
> index 4e68afc..7c707a6 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -797,8 +797,13 @@ static gboolean ext_io_disconnected(GIOChannel *io, GIOCondition cond,
>
>         DBG("%s disconnected from %s", ext->name, addr);
>  drop:
> -       if (conn->service)
> -               btd_service_disconnecting_complete(conn->service, 0);
> +       if (conn->service) {
> +               if (btd_service_get_state(conn->service) ==
> +                                               BTD_SERVICE_STATE_CONNECTING)
> +                       bt_service_connection_complete(conn->service, -EIO);
> +               else
> +                       btd_service_disconnecting_complete(conn->service, 0);
> +       }
>
>         ext->conns = g_slist_remove(ext->conns, conn);
>         ext_io_destroy(conn);
> --
> 2.1.0

Applied after fixing the typo.


-- 
Luiz Augusto von Dentz
