Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1304123252-14464-10-git-send-email-andre.guedes@openbossa.org>
References: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
	<1304123252-14464-10-git-send-email-andre.guedes@openbossa.org>
Date: Mon, 2 May 2011 11:42:59 +0300
Message-ID: <BANLkTikv2fJoLJ+tpchWD7X6ugwjVcwoxg@mail.gmail.com>
Subject: Re: [RFC 09/16] Remove 'suspend' param from stop_discovery()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Sat, Apr 30, 2011 at 3:27 AM, Andre Guedes
<andre.guedes@openbossa.org> wrote:
> This patch removes 'suspend' parameter from stop_discovery() in adapter.c.
>
> This parameter is useless since new a function (suspend_discovery) was
> created to suspend discovery sessions.
> ---
>  src/adapter.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 6a2a8c1..0279494 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -700,12 +700,11 @@ static GSList *remove_bredr(GSList *all)
>        return le;
>  }
>
> -static void stop_discovery(struct btd_adapter *adapter, gboolean suspend)
> +static void stop_discovery(struct btd_adapter *adapter)
>  {
>        pending_remote_name_cancel(adapter);
>
> -       if (suspend == FALSE)
> -               adapter->found_devices = remove_bredr(adapter->found_devices);
> +       adapter->found_devices = remove_bredr(adapter->found_devices);
>
>        if (adapter->oor_devices) {
>                g_slist_free(adapter->oor_devices);
> @@ -762,7 +761,7 @@ static void session_remove(struct session_req *req)
>
>                DBG("Stopping discovery");
>
> -               stop_discovery(adapter, FALSE);
> +               stop_discovery(adapter);
>        }
>  }
>
> @@ -2537,7 +2536,7 @@ int btd_adapter_stop(struct btd_adapter *adapter)
>        /* check pending requests */
>        reply_pending_requests(adapter);
>
> -       stop_discovery(adapter, FALSE);
> +       stop_discovery(adapter);
>
>        if (adapter->disc_sessions) {
>                g_slist_foreach(adapter->disc_sessions, (GFunc) session_free,
> --

What happened with stop_discovery called within suspend_discovery? We
need to avoid cleaning up the list of found devices otherwise we won't
be able to send DeviceDisappeared properly when discovery got resume.

-- 
Luiz Augusto von Dentz
Computer Engineer
