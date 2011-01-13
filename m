Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1294915924-17068-1-git-send-email-lkslawek@gmail.com>
References: <1294915924-17068-1-git-send-email-lkslawek@gmail.com>
Date: Thu, 13 Jan 2011 19:15:58 +0200
Message-ID: <AANLkTimH2pi+goj0c7Lk6AKRiYDbNQ0fG31WWagz_iZE@mail.gmail.com>
Subject: Re: [PATCH] Fix plugin close & disconnect functions call order
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: lkslawek@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jan 13, 2011 at 12:52 PM,  <lkslawek@gmail.com> wrote:
> From: Slawomir Bochenski <lkslawek@gmail.com>
>
> Normally during an OBEX session, calling sequence
>
> service->connect - [driver->open - driver->close]* - service->disconnect
>
> is kept. The only exception to this when the connection is reset
> (when no ABORT was sent) during transfer. Then the sequence is:
>
> service->connect - [driver->open - driver->close]* - driver->open -
> service->disconnect - driver->close
>
> This patch fixes it, so memory managament of session/transfer data in
> service plugin can be easier.
> ---
>  src/obex.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/src/obex.c b/src/obex.c
> index 65f17fc..67684fa 100644
> --- a/src/obex.c
> +++ b/src/obex.c
> @@ -1231,6 +1231,8 @@ static void obex_handle_destroy(void *user_data)
>
>        os = OBEX_GetUserData(obex);
>
> +       os_reset_session(os);
> +
>        if (os->service && os->service->disconnect)
>                os->service->disconnect(os, os->service_data);

Looks like a good idea, what about removing from os_session_free?


-- 
Luiz Augusto von Dentz
Computer Engineer
