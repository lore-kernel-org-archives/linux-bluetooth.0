Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGnek1nNmfJUWJVJ+J45_9eCDd=cC-7mhJ8wN3ujtV-LpLfC0w@mail.gmail.com>
References: <CAGnek1nNmfJUWJVJ+J45_9eCDd=cC-7mhJ8wN3ujtV-LpLfC0w@mail.gmail.com>
Date: Fri, 12 Jun 2015 14:00:00 +0300
Message-ID: <CABBYNZLEs8YyPUTYkJXMw9W=xdy-gtDTp+C5g+eQR=eQ2VgULQ@mail.gmail.com>
Subject: Re: [PATCH] profiles/hog: enable report notifications if ccc handle
 is valid
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Austin Foxley <austinf@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Austin,

On Fri, Jun 12, 2015 at 3:27 AM, Austin Foxley <austinf@gmail.com> wrote:
> profiles/hog: enable report notifications if ccc handle is valid
>
> This fixes an issue where hog report notifications weren't
> getting processed after a device disconnected then reconnected
> a short while later without being removed.

If you have the traces of this problem please add the relevant part to
the description.

> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index 4be9fd2..a61d0e7 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -858,7 +858,7 @@ static void attio_connected_cb(GAttrib *attrib,
> gpointer user_data)
>         for (l = hogdev->reports; l; l = l->next) {
>                 struct report *r = l->data;
>
> -               enable_report_notifications(r, false);
> +               enable_report_notifications(r, r->ccc_handle != 0);

We are doing false here because the CCC should be remembered by the
device so doing ccc_handle != 0 might sent this every time causing
extra round trips which can add latency on reconnect, perhaps the
problem is either your device don't remember CCC was already
configured which is a bug since HoG mandates pairing thus CCC should
be valid across connections, or we did disconnect before CCC was
written then perhaps we need to set a flag when CCC write operation
has been completed.

>         }
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
