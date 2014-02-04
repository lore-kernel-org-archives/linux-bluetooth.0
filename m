Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391506089-23985-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391506089-23985-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 4 Feb 2014 15:47:17 +0200
Message-ID: <CABBYNZJyUPsn1qZ5V-KSmEU0cMN=m0o+Qp8rCyKo_5M1wRdDmw@mail.gmail.com>
Subject: Re: [PATCH] android/avctp: Fix memory leak: unregister pdu handler
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 4, 2014 at 11:28 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Unregister pdu handlers on shutdown.
> ---
>  android/avctp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/android/avctp.c b/android/avctp.c
> index 8f35403..8681cb0 100644
> --- a/android/avctp.c
> +++ b/android/avctp.c
> @@ -1462,6 +1462,15 @@ void avctp_shutdown(struct avctp *session)
>         if (session->browsing)
>                 avctp_channel_destroy(session->browsing);
>
> +       if (session->passthrough_id > 0)
> +               avctp_unregister_pdu_handler(session, session->passthrough_id);
> +
> +       if (session->unit_id > 0)
> +               avctp_unregister_pdu_handler(session, session->unit_id);
> +
> +       if (session->subunit_id > 0)
> +               avctp_unregister_pdu_handler(session, session->subunit_id);
> +
>         if (session->control)
>                 avctp_channel_destroy(session->control);
>
> --
> 1.8.3.2

There is no leak, avctp_channel_destroy cleanup all the registered handlers.


-- 
Luiz Augusto von Dentz
