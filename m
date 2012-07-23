Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343054163-19119-2-git-send-email-claudio.takahasi@openbossa.org>
References: <1343054163-19119-1-git-send-email-claudio.takahasi@openbossa.org>
	<1343054163-19119-2-git-send-email-claudio.takahasi@openbossa.org>
Date: Mon, 23 Jul 2012 12:16:03 -0400
Message-ID: <CAJdJm_N7Z4a2p7-Ur+_kEf2Q==aL5QTYpmnRomX+LXjy1Dd37Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] btio: Rescue lost errorneous numbers
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Paulo Alcantara <paulo.alcantara@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Jul 23, 2012 at 10:36 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
>  #define ERROR_FAILED(gerr, str, err) \
> -               g_set_error(gerr, BT_IO_ERROR, BT_IO_ERROR_FAILED, \
> +               g_set_error(gerr, BT_IO_ERROR, err, \
>                                 str ": %s (%d)", strerror(err), err)
> [...]
>                 if (err < 0)
> -                       g_set_error(&gerr, BT_IO_ERROR,
> -                                       BT_IO_ERROR_CONNECT_FAILED, "%s (%d)",
> -                                       strerror(-err), -err);
> -       } else if (cond & (G_IO_HUP | G_IO_ERR))
> -               g_set_error(&gerr, BT_IO_ERROR, BT_IO_ERROR_CONNECT_FAILED,
> -                               "HUP or ERR on socket");
> +                       g_set_error(&gerr, BT_IO_ERROR, -err, "%s (%d)",
> +                                                       strerror(-err), -err);

why not use the ERROR_FAILED() macro here?

>         if (err < 0) {
> -               g_set_error(gerr, BT_IO_ERROR, BT_IO_ERROR_CONNECT_FAILED,
> -                               "connect: %s (%d)", strerror(-err), -err);
> +               g_set_error(gerr, BT_IO_ERROR, -err, "connect: %s (%d)",
> +                                                       strerror(-err), -err);

and here?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
