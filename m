Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1345196026-6873-1-git-send-email-sunil.behera@samsung.com>
References: <1345196026-6873-1-git-send-email-sunil.behera@samsung.com>
Date: Fri, 17 Aug 2012 16:49:10 +0300
Message-ID: <CABBYNZKesZfqq+WPC9KxZXb7VZ0voc9On7=NnMVP3JfrbPVPeQ@mail.gmail.com>
Subject: Re: [PATCH obexd] MAP: Fix invalid oflag check
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sunil Kumar Behera <sunil.behera@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sunil,

On Fri, Aug 17, 2012 at 12:33 PM, Sunil Kumar Behera
<sunil.behera@samsung.com> wrote:
> Change logic to check for O_WRONLY, as oflag is
> created by an OR operation of O_WRONLY, O_CREAT and
> O_TRUNC.
> Message update is a PUT function, this check returns
> bad response if GET is received.
> ---
>  plugins/mas.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/plugins/mas.c b/plugins/mas.c
> index 30e529f..57d9611 100644
> --- a/plugins/mas.c
> +++ b/plugins/mas.c
> @@ -632,7 +632,7 @@ static void *message_update_open(const char *name, int oflag, mode_t mode,
>
>         DBG("");
>
> -       if (oflag != O_WRONLY) {
> +       if (oflag == O_RDONLY) {
>                 *err = -EBADR;
>                 return NULL;
>         }
> --
> 1.7.9.5

Pushed upstream, thanks.


-- 
Luiz Augusto von Dentz
