Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1316527880-8081-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1316527880-8081-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Tue, 20 Sep 2011 17:44:14 +0300
Message-ID: <CABBYNZJw5jmEFCwdffC=Biurfpx7bNLh6QkGa_ZveZ2Q-zzP1A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix invalid free when stopping adapter
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Sep 20, 2011 at 5:11 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> This patch fix an "invalid free" error when the adapter is powered off
> with an active discovery session. Error happens because session_remove
> function removes the elements from the list also. Partial valgrind log:
> Address 0x6012a00 is 0 bytes inside a block of size 16 free'd
>  at 0x4C27DCC: free (vg_replace_malloc.c:366)
>  by 0x4E927AC: g_slist_remove (in
>  by 0x19F788: session_remove (adapter.c:689)
>  by 0x19F82A: session_free (adapter.c:708)
>  by 0x4E92CD6: g_slist_foreach (in
>  by 0x4E92CFA: g_slist_free_full (in
>  by 0x1A3ADD: btd_adapter_stop (adapter.c:2491)
> ---
>  src/adapter.c |   20 +++++++++++++-------
>  1 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index af8c273..b3622cb 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -704,8 +704,6 @@ static void session_free(void *data)
>        if (req->id)
>                g_dbus_remove_watch(req->conn, req->id);
>
> -       session_remove(req);
> -
>        if (req->msg) {
>                dbus_message_unref(req->msg);
>                if (!req->got_reply && req->mode && req->adapter->agent)
> @@ -724,6 +722,7 @@ static void session_owner_exit(DBusConnection *conn, void *user_data)
>
>        req->id = 0;
>
> +       session_remove(req);
>        session_free(req);
>  }
>
> @@ -736,6 +735,7 @@ static void session_unref(struct session_req *req)
>        if (req->refcount)
>                return;
>
> +       session_remove(req);
>        session_free(req);
>  }
>
> @@ -2314,12 +2314,18 @@ static void set_mode_complete(struct btd_adapter *adapter)
>
>        /*
>         * g_slist_free is not called after g_slist_foreach because the list is
> -        * updated using g_slist_remove in session_remove which is called by
> -         * session_free, which is called for each element by g_slist_foreach.
> +        * updated using g_slist_remove in session_remove.
>         */
> -       if (adapter->mode == MODE_OFF)
> -               g_slist_foreach(adapter->mode_sessions, (GFunc) session_free,
> -                                                                       NULL);
> +       if (adapter->mode == MODE_OFF) {
> +               GSList *l;
> +
> +               for (l = adapter->mode_sessions; l;) {
> +                       struct session_req *req = l->data;
> +                       l = g_slist_next(l);
> +                       session_remove(req);
> +                       session_free(req);
> +               }
> +       }

Maybe you can use g_slist_free_full here instead of iterating one by one.

-- 
Luiz Augusto von Dentz
