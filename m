Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1317825160-21429-4-git-send-email-lkslawek@gmail.com>
References: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
	<1317825160-21429-4-git-send-email-lkslawek@gmail.com>
Date: Wed, 5 Oct 2011 18:06:55 +0300
Message-ID: <CABBYNZJyPMny8MfqxDsJ256Q+Ft-1+DFwfWbi12MxNz1rEJ8cw@mail.gmail.com>
Subject: Re: [PATCH obexd 4/4] Simplify code for calling mime driver flush()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawomir,

On Wed, Oct 5, 2011 at 5:32 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
> OBEX_EV_REQ is the last thing that we are going to receive on PUT and
> this is always going to be delivered. As the service driver will start
> receiving data at or before its .put(), we can simply call flush() after
> that. This also makes flush() usable in PUTs without length header.
> ---
>  src/obex.c |   28 ++++++++++------------------
>  1 files changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/src/obex.c b/src/obex.c
> index 38c5ca6..2cabadb 100644
> --- a/src/obex.c
> +++ b/src/obex.c
> @@ -625,11 +625,6 @@ write:
>                os->pending -= w;
>        }
>
> -       /* Flush on EOS */
> -       if (os->size != OBJECT_SIZE_UNKNOWN && os->size == os->offset &&
> -                                                       os->driver->flush)
> -               return os->driver->flush(os->object) > 0 ? -EAGAIN : 0;

By removing this it wont flush on EOS, so Im not sure why you removed
it since OBEX_EV_REQ is only generated for the request not for the
streams itself. Actually if OpenOBEX had an event for that represent
the FINAL bit that would solve the problem with unknown size, but for
gobex this is exposed directly in the callback so I wouldn't change
that now.

>        return 0;
>  }
>
> @@ -1140,19 +1135,16 @@ static void cmd_put(struct obex_session *os, obex_t *obex, obex_object_t *obj)
>                return;
>        }
>
> -       /* Check if there is a body and it is not empty (size > 0), otherwise
> -          openobex won't notify us with OBEX_EV_STREAMAVAIL and it gonna reply
> -          right away */
> -       if (os->size != 0)
> -               return;
> -
> -       /* Flush immediatly since there is nothing to write so the driver
> -          has a chance to do something before we reply */
> -       if (os->object && os->driver && os->driver->flush &&
> -                                       os->driver->flush(os->object) > 0) {
> -               OBEX_SuspendRequest(obex, obj);
> -               os->obj = obj;
> -               os->driver->set_io_watch(os->object, handle_async_io, os);
> +       if (os->object && os->driver && os->driver->flush) {
> +               err = os->driver->flush(os->object);
> +               if (err == -EAGAIN) {
> +                       OBEX_SuspendRequest(obex, obj);
> +                       os->obj = obj;
> +                       os->driver->set_io_watch(os->object,
> +                                                       handle_async_io, os);
> +               } else if (err < 0) {
> +                       os_set_response(obj, err);
> +               }

You got this wrong, the purpose of this code is to flush on end of
stream not in the beginning/put request, so if we have consecutive
puts the last packet should cause a flush so the driver can sync any
buffered data before close which needs to be immediately.

-- 
Luiz Augusto von Dentz
