Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1422616032-14968-1-git-send-email-bharat.panda@samsung.com>
References: <1422616032-14968-1-git-send-email-bharat.panda@samsung.com>
Date: Fri, 30 Jan 2015 13:16:53 +0200
Message-ID: <CABBYNZK_VqvdKBghPAg2cO0Z-M82nGpjmZcy543b0m9QmRo4Zw@mail.gmail.com>
Subject: Re: [PATCH ] obexd/client: clear pending transfers if fails
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jan 30, 2015 at 1:07 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> In case of obex transfer fails, clear all pending
> transfers in the session.
> ---
>  obexd/client/session.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/obexd/client/session.c b/obexd/client/session.c
> index d2ae4fd..512d6b7 100644
> --- a/obexd/client/session.c
> +++ b/obexd/client/session.c
> @@ -901,8 +901,12 @@ static void session_terminate_transfer(struct obc_session *session,
>
>         pending_request_free(p);
>
> -       if (session->p == NULL)
> -               session_process_queue(session);
> +       if (session->p == NULL) {
> +               if (gerr != NULL)
> +                       obc_session_shutdown(session);
> +               else
> +                       session_process_queue(session);

Would that also work for transfer cancelled? Im afraid some errors are
not really critical that we should cancel the whole queue.



-- 
Luiz Augusto von Dentz
