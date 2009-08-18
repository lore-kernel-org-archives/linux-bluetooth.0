Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1250634769-12220-1-git-send-email-npelly@google.com>
References: <1250634769-12220-1-git-send-email-npelly@google.com>
From: Nick Pelly <npelly@google.com>
Date: Tue, 18 Aug 2009 16:01:42 -0700
Message-ID: <35c90d960908181601x5d31192l459ce5ccdff84b8d@mail.gmail.com>
Subject: Re: [PATCH] Fix audio.conf parsing bug - sink and source were
	transposed.
To: linux-bluetooth@vger.kernel.org
Cc: Nick Pelly <npelly@google.com>,
	Jaikumar Ganesh <jaikumar@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 18, 2009 at 3:32 PM, Nick Pelly<npelly@google.com> wrote:
> ---
>  audio/a2dp.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/audio/a2dp.c b/audio/a2dp.c
> index 45be5d4..41b8f88 100644
> --- a/audio/a2dp.c
> +++ b/audio/a2dp.c
> @@ -1098,9 +1098,9 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
>                g_clear_error(&err);
>        } else {
>                if (strstr(str, "Sink"))
> -                       source = TRUE;
> -               if (strstr(str, "Source"))
>                        sink = TRUE;
> +               if (strstr(str, "Source"))
> +                       source = TRUE;
>                g_free(str);
>        }
>
> @@ -1111,9 +1111,9 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
>                g_clear_error(&err);
>        } else {
>                if (strstr(str, "Sink"))
> -                       source = FALSE;
> -               if (strstr(str, "Source"))
>                        sink = FALSE;
> +               if (strstr(str, "Source"))
> +                       source = FALSE;
>                g_free(str);
>        }
>
> --
> 1.6.3.1


Jaikumar just gave me the heads up that this is by design.

Enable=Sink means that bluetoothd offers the Sink interface for remote
devices - and that we are a source.
Enable=Source means that bluetoothd offers the Source interface for
remote devices - and that we are a sink.

I'd say its counter-intuitive, but we can live with it.

Nick
