Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329143945-4934-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329143945-4934-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 14 Feb 2012 10:54:34 +0200
Message-ID: <CABBYNZJzaq=P8b-N0Jn71tmd_S3m7cDTieUp69tN-mzhTsxFGw@mail.gmail.com>
Subject: Re: [PATCH obexd 1/6] client: fix memory leak in obc_session_put
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Feb 13, 2012 at 4:39 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> obc_session_put takes ownership of the given buffer, but did not free
> the memory in case of error.
> ---
>  client/session.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/client/session.c b/client/session.c
> index 585e402..cb46510 100644
> --- a/client/session.c
> +++ b/client/session.c
> @@ -1007,8 +1007,10 @@ int obc_session_put(struct obc_session *session, char *buf, const char *targetna
>        struct obc_transfer *transfer;
>        const char *agent;
>
> -       if (session->obex == NULL)
> +       if (session->obex == NULL) {
> +               g_free(buf);
>                return -ENOTCONN;
> +       }
>
>        agent = obc_agent_get_name(session->agent);
>
> @@ -1016,8 +1018,10 @@ int obc_session_put(struct obc_session *session, char *buf, const char *targetna
>                                                        agent, NULL,
>                                                        targetname, NULL,
>                                                        NULL);
> -       if (transfer == NULL)
> +       if (transfer == NULL) {
> +               g_free(buf);
>                return -EIO;
> +       }
>
>        obc_transfer_set_buffer(transfer, buf);
>
> --
> 1.7.6.5

Looks good, ack.

-- 
Luiz Augusto von Dentz
