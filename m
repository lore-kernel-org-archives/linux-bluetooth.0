Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1532061239-22481-1-git-send-email-gtiwari@redhat.com>
References: <1532061239-22481-1-git-send-email-gtiwari@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Jul 2018 11:24:34 +0300
Message-ID: <CABBYNZ+SuA7GsrsHeyBj+ypQ8b4a6dSQL=6rqWsxHQ=nn-tWtg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] Fixing possible use_after_free.
To: Gopal Tiwari <gtiwari@redhat.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Don Zickus <dzickus@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gopal,

On Fri, Jul 20, 2018 at 7:33 AM, Gopal Tiwari <gtiwari@redhat.com> wrote:
> During the code review of code. Found some of the possible
> double free scenario's. So fixing them.

Id like that you split the changes with possible traces when that
happen, besides some changes seems questionable (see the comments
bellow).

> ---
>  gobex/gobex-transfer.c | 6 ++++++
>  obexd/client/session.c | 6 +++++-
>  tools/mesh/prov-db.c   | 4 +++-
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
> index bc99306..11980d0 100644
> --- a/gobex/gobex-transfer.c
> +++ b/gobex/gobex-transfer.c
> @@ -428,6 +428,12 @@ guint g_obex_put_rsp(GObex *obex, GObexPacket *req,
>         va_start(args, first_hdr_id);
>         transfer_put_req_first(transfer, req, first_hdr_id, args);
>         va_end(args);
> +
> +       /* Checking transfer in case transfer_put_req_first has
> +        * freed it to avoid double free */
> +       if(!transfer)
> +               return 0;

Check the code style, the should be a space after like in: if (

>         if (!g_slist_find(transfers, transfer))
>                 return 0;
>
> diff --git a/obexd/client/session.c b/obexd/client/session.c
> index 5bd2d26..077224b 100644
> --- a/obexd/client/session.c
> +++ b/obexd/client/session.c
> @@ -938,7 +938,11 @@ static void session_terminate_transfer(struct obc_session *session,
>         if (session->p == NULL)
>                 session_process_queue(session);
>
> -       obc_session_unref(session);
> +       /* Verifying the session variable for double free
> +        */
> +
> +       if (session)
> +               obc_session_unref(session);

I don't think you are fixing anything here with checking the session
pointer since any function altering it won't be able to reset the
pointer to NULL. If is a chance of double free here then what should
be done is have a extra reference to prevent it to be free before but
given the function name that should never happen so I wonder where you
got this from?

>  }
>
>  static void session_notify_complete(struct obc_session *session,
> diff --git a/tools/mesh/prov-db.c b/tools/mesh/prov-db.c
> index 05b2547..74915d2 100644
> --- a/tools/mesh/prov-db.c
> +++ b/tools/mesh/prov-db.c
> @@ -876,8 +876,10 @@ bool prov_db_local_set_iv_index(uint32_t iv_index, bool update, bool prov)
>
>         res = true;
>  done:
> +       /* Varify in_str for double free */
>
> -       g_free(in_str);
> +       if(in_str)
> +               g_free(in_str);

g_free is already NULL pointer safe.

>
>         if(jmain)
>                 json_object_put(jmain);
> --
> 2.7.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
