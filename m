Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1351384166-15586-4-git-send-email-dmp0x7c5@gmail.com>
References: <1351384166-15586-1-git-send-email-dmp0x7c5@gmail.com>
	<1351384166-15586-4-git-send-email-dmp0x7c5@gmail.com>
Date: Tue, 30 Oct 2012 10:35:10 +0100
Message-ID: <CABBYNZJorono572HhGqRrxNT2uDvz2PV1n4rdHs0mWJ8CRKqSg@mail.gmail.com>
Subject: Re: [RFC v2 obexd 04/11] fuse: Add request helpers and setpath operation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-2?Q?Micha=B3_Poczwardowski?= <dmp0x7c5@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Sun, Oct 28, 2012 at 2:29 AM, Michał Poczwardowski
<dmp0x7c5@gmail.com> wrote:
> ---
>  fuse/helpers.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 108 insertions(+), 0 deletions(-)
>
> diff --git a/fuse/helpers.c b/fuse/helpers.c
> index 856e1d5..1b8082f 100644
> --- a/fuse/helpers.c
> +++ b/fuse/helpers.c
> @@ -273,3 +273,111 @@ void gobexhlp_disconnect(struct gobexhlp_session* session)
>
>         g_free(session);
>  }
> +
> +void request_new(struct gobexhlp_session *session,
> +                                       gchar *name)
> +{
> +       g_print("REQUEST %s\n", name);
> +
> +       if (session->request != NULL)
> +               g_error("Another request (%s) active!\n",
> +                                       session->request->name);
> +
> +       session->status = 0;
> +       session->request = g_malloc0(sizeof(struct gobexhlp_request));
> +       session->request->name = name;
> +
> +       /*
> +        * suspend/resume operations recreates g_io_add_watch(),
> +        * it fixes obex->io freeze during transfer
> +        */
> +       g_obex_suspend(session->obex);
> +       g_obex_resume(session->obex);

It seems the issue here is that the mainloop is blocked then you have
to force the io checking by doing g_io_add_watch in a different
thread, we have dealt with this kind of problem before using
g_main_context_iteration. I would have been better if fuse supported
async io, but apparently all operations are blocking.

-- 
Luiz Augusto von Dentz
