Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1337698698-15471-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337698698-15471-1-git-send-email-mikel.astiz.oss@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 22 May 2012 12:07:09 -0300
Message-ID: <CAMOw1v6WZCn5CP67Wp4o+VJCC76tn-yiZherrNmEbiRvu_ZUeA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] gdbus: Fix incorrectly discarded signals
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, May 22, 2012 at 11:58 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Signals with no arguments were incorrectly filtered out due to the NULL
> inequality check.
> ---
>  gdbus/object.c |   10 +++-------
>  1 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 2dd7c0e..900e7ab 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -612,16 +612,12 @@ static gboolean check_signal(DBusConnection *conn, const char *path,
>        for (signal = iface->signals; signal && signal->name; signal++) {
>                if (!strcmp(signal->name, name)) {
>                        *args = signal->args;
> -                       break;
> +                       return TRUE;
>                }
>        }
>
> -       if (*args == NULL) {
> -               error("No signal named %s on interface %s", name, interface);
> -               return FALSE;
> -       }
> -
> -       return TRUE;
> +       error("No signal named %s on interface %s", name, interface);
> +       return FALSE;
>  }

Ack.

Lucas De Marchi
