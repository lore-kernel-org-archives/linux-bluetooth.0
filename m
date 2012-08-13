Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343816803-16228-1-git-send-email-jaganath.k@samsung.com>
References: <1343816803-16228-1-git-send-email-jaganath.k@samsung.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 13 Aug 2012 11:03:23 -0300
Message-ID: <CAMOw1v6_boNFVPeuujtzMp409Spd0cPV6-kxmvN31+W9TdgQpg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0] gdbus: Fix compilation error if macro "error" is defined
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Aug 1, 2012 at 7:26 AM, Jaganath Kanakkassery
<jaganath.k@samsung.com> wrote:
> The variable "signature" used in error is not defined.
> ---
> v0 -> Made error message as per Lucas's suggestion
>
>  gdbus/object.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 900e7ab..9689006 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -645,8 +645,8 @@ static dbus_bool_t emit_signal_valist(DBusConnection *conn,
>                 goto fail;
>
>         if (g_dbus_args_have_signature(args, signal) == FALSE) {
> -               error("%s.%s: expected signature'%s' but got '%s'",
> -                               interface, name, args, signature);
> +               error("%s.%s: got unexpected signature '%s'", interface, name,
> +                                       dbus_message_get_signature(signal));
>                 ret = FALSE;
>                 goto fail;

Ack.

Lucas De Marchi
