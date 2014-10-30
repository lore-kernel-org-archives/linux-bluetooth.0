Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1414658845-21769-1-git-send-email-luiz.dentz@gmail.com>
References: <1414658845-21769-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 30 Oct 2014 11:20:00 +0200
Message-ID: <CABBYNZLJuf8o1_KMwNjCTjcrpAY-6vtVDeOiOZVr9r3U=5sggg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Revert "core: Fix unnecessary calls to agent_cancel()"
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Oct 30, 2014 at 10:47 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> agent_cancel calls are necessary since agent_unref only call it in case
> the last reference is dropped.
> ---
>  src/adapter.c | 8 ++++++--
>  src/agent.c   | 1 +
>  src/device.c  | 1 +
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 54e7496..21c1bb6 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1091,8 +1091,10 @@ static void service_auth_cancel(struct service_auth *auth)
>
>         dbus_error_free(&derr);
>
> -       if (auth->agent != NULL)
> +       if (auth->agent != NULL) {
> +               agent_cancel(auth->agent);
>                 agent_unref(auth->agent);
> +       }
>
>         g_free(auth);
>  }
> @@ -5173,8 +5175,10 @@ int btd_cancel_authorization(guint id)
>
>         g_queue_remove(auth->adapter->auths, auth);
>
> -       if (auth->agent)
> +       if (auth->agent) {
> +               agent_cancel(auth->agent);
>                 agent_unref(auth->agent);
> +       }
>
>         g_free(auth);
>
> diff --git a/src/agent.c b/src/agent.c
> index 9ab1c8b..97daf71 100644
> --- a/src/agent.c
> +++ b/src/agent.c
> @@ -350,6 +350,7 @@ static void simple_agent_reply(DBusPendingCall *call, void *user_data)
>
>                 if (dbus_error_has_name(&err, DBUS_ERROR_NO_REPLY)) {
>                         error("Timed out waiting for reply from agent");
> +                       agent_cancel(agent);
>                         dbus_message_unref(message);
>                         dbus_error_free(&err);
>                         agent_unref(agent);
> diff --git a/src/device.c b/src/device.c
> index 875a5c5..db6c4f8 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1879,6 +1879,7 @@ static void bonding_request_free(struct bonding_req *bonding)
>                 g_free(bonding->cb_iter);
>
>         if (bonding->agent) {
> +               agent_cancel(bonding->agent);
>                 agent_unref(bonding->agent);
>                 bonding->agent = NULL;
>         }
> --
> 1.9.3

Pushed.


-- 
Luiz Augusto von Dentz
