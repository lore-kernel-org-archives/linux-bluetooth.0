Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1337688756-1938-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337688756-1938-1-git-send-email-mikel.astiz.oss@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 22 May 2012 09:21:55 -0300
Message-ID: <CAMOw1v5dXaujizhJKL_putC33oFZEnfE4AjKZ0gfQL=jmmJB2Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0] gdbus: Fix incorrectly discarded signals
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, May 22, 2012 at 9:12 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Signals with no arguments were incorrectly filtered out due to the NULL
> inequality check.
> ---
>  gdbus/object.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 2dd7c0e..c33df57 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -616,7 +616,7 @@ static gboolean check_signal(DBusConnection *conn, const char *path,
>                }
>        }
>
> -       if (*args == NULL) {
> +       if (!signal || !signal->name) {
>                error("No signal named %s on interface %s", name, interface);
>                return FALSE;
>        }


Ack.

Thanks
Lucas De Marchi
