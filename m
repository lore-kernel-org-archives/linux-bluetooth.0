Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330692087-13021-4-git-send-email-mikel.astiz.oss@gmail.com>
References: <1330692087-13021-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1330692087-13021-4-git-send-email-mikel.astiz.oss@gmail.com>
Date: Mon, 5 Mar 2012 12:18:09 +0200
Message-ID: <CABBYNZJ=WtzLsVJmLhbja1JYekEjgqFrmjYAyzTM3+27Wg56GA@mail.gmail.com>
Subject: Re: [PATCH obexd 3/3] client: simplify obc_session_pull
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Mar 2, 2012 at 2:41 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Functions obc_session_get and obc_session_pull nearly share the same
> code, so the later can be achieved by just calling the first one.
>
> The session api is not modified in this patch.
> ---
>  client/session.c |   22 +---------------------
>  1 files changed, 1 insertions(+), 21 deletions(-)
>
> diff --git a/client/session.c b/client/session.c
> index 6497d70..595f684 100644
> --- a/client/session.c
> +++ b/client/session.c
> @@ -1001,27 +1001,7 @@ int obc_session_pull(struct obc_session *session,
>                                const char *type, const char *targetfile,
>                                session_callback_t function, void *user_data)
>  {
> -       struct obc_transfer *transfer;
> -       const char *agent;
> -
> -       if (session->obex == NULL)
> -               return -ENOTCONN;
> -
> -       if (session->agent != NULL)
> -               agent = obc_agent_get_name(session->agent);
> -       else
> -               agent = NULL;
> -
> -       transfer = obc_transfer_register(session->conn, session->obex,
> -                                                               agent,
> -                                                               targetfile,
> -                                                               NULL, type,
> -                                                               NULL);
> -       if (transfer == NULL) {
> -               return -EIO;
> -       }
> -
> -       return session_request(session, transfer, session_prepare_get,
> +       return obc_session_get(session, type, NULL, targetfile, NULL, 0,
>                                                        function, user_data);
>  }
>
> --
> 1.7.6.5

Sounds good, ack.

-- 
Luiz Augusto von Dentz
