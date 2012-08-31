Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346416811-23484-13-git-send-email-szymon.janc@tieto.com>
References: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com>
	<1346416811-23484-13-git-send-email-szymon.janc@tieto.com>
Date: Fri, 31 Aug 2012 09:19:28 -0400
Message-ID: <CAJdJm_NNYAHHVrr-uj97h7FEL0XatL5PuLnpOri6An4c-bz=mw@mail.gmail.com>
Subject: Re: [RFC v2 12/15] adaptername: Refactor handle_inotify_cb
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Aug 31, 2012 at 8:40 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> @@ -226,35 +226,41 @@ static int adaptername_probe(struct btd_adapter *adapter)
>  static gboolean handle_inotify_cb(GIOChannel *channel, GIOCondition cond,
>                                                                 gpointer data)
>  {
> -       char buf[EVENT_BUF_LEN];

Looks like EVENT_SIZE and EVENT_BUF_LEN defines are not used anymore
so they can be removed.

> +               err = g_io_channel_read_chars(channel, name, event.len, &len,
> +                                                                       NULL);

No need to check for event.len <= FILENAME_MAX before the
*read_chars() call ? (I don't know inotify, so I'm not sure about the
allowed limits here)

Or maybe using sizeof(name) instead of event.len ?

> +               if (err != G_IO_STATUS_NORMAL) {
> +                       error("Error reading inotify event: %d", err);
> +                       return FALSE;
> +               }

Is it necessary to check whether event.len == len here ?

Otherwise a short read may not have the necessary "\0" for the
strcmp() (but see below).

>
> -               i += EVENT_SIZE + pevent->len;
> -       }
> +               if (strcmp(name, MACHINE_INFO_FILE) != 0)
> +                       continue;

What about using strncmp() just to be safe?

>
> -       if (changed != FALSE) {
>                 DBG(MACHINE_INFO_DIR MACHINE_INFO_FILE
>                                 " changed, changing names for adapters");
> +
>                 manager_foreach_adapter((adapter_cb) adaptername_probe, NULL);
> +               break;

what about having " if (strcmp(name, MACHINE_INFO_FILE) == 0) " and
moving the code above to inside the if() ? The "unconditional" break
at the end of the while() looks strange IMHO.

>         }
>
>         return TRUE;

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
