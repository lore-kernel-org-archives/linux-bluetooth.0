Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171026120223.18492-1-luiz.dentz@gmail.com>
References: <20171026120223.18492-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Oct 2017 14:55:03 +0200
Message-ID: <CABBYNZJiFaYdXBbQD3DfL4GQ_Yj-rMj7E4V6X2XMiQCvYv-qug@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] avctp: Don't queue control request without callback
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Oct 26, 2017 at 3:02 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If no callback is set that means the request don't care about the
> response, so instead of putting such request into the pending queue
> this proceeds to send them immediately.
> ---
>  profiles/audio/avctp.c | 67 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 42 insertions(+), 25 deletions(-)
>
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index daf39a782..f8ec19c9c 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -617,6 +617,39 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state,
>         }
>  }
>
> +static uint8_t chan_get_transaction(struct avctp_channel *chan)
> +{
> +       GSList *l, *tmp;
> +       uint8_t transaction;
> +
> +       if (!chan->processed)
> +               goto done;
> +
> +       tmp = g_slist_copy(chan->processed);
> +
> +       /* Find first unused transaction id */
> +       for (l = tmp; l; l = g_slist_next(l)) {
> +               struct avctp_pending_req *req = l->data;
> +
> +               if (req->transaction == chan->transaction) {
> +                       chan->transaction++;
> +                       chan->transaction %= 16;
> +                       tmp = g_slist_delete_link(tmp, l);
> +                       l = tmp;
> +               }
> +       }
> +
> +       g_slist_free(tmp);
> +
> +done:
> +       transaction = chan->transaction;
> +
> +       chan->transaction++;
> +       chan->transaction %= 16;
> +
> +       return transaction;
> +}
> +
>  static int avctp_send(struct avctp_channel *control, uint8_t transaction,
>                                 uint8_t cr, uint8_t code,
>                                 uint8_t subunit, uint8_t opcode,
> @@ -643,6 +676,9 @@ static int avctp_send(struct avctp_channel *control, uint8_t transaction,
>         avctp = (void *) control->buffer;
>         avc = (void *) avctp + sizeof(*avctp);
>
> +       if (transaction > 16)
> +               transaction = chan_get_transaction(control);
> +
>         avctp->transaction = transaction;
>         avctp->packet_type = AVCTP_PACKET_SINGLE;
>         avctp->cr = cr;
> @@ -1556,38 +1592,14 @@ static struct avctp_pending_req *pending_create(struct avctp_channel *chan,
>                                                 GDestroyNotify destroy)
>  {
>         struct avctp_pending_req *p;
> -       GSList *l, *tmp;
> -
> -       if (!chan->processed)
> -               goto done;
> -
> -       tmp = g_slist_copy(chan->processed);
> -
> -       /* Find first unused transaction id */
> -       for (l = tmp; l; l = g_slist_next(l)) {
> -               struct avctp_pending_req *req = l->data;
> -
> -               if (req->transaction == chan->transaction) {
> -                       chan->transaction++;
> -                       chan->transaction %= 16;
> -                       tmp = g_slist_delete_link(tmp, l);
> -                       l = tmp;
> -               }
> -       }
>
> -       g_slist_free(tmp);
> -
> -done:
>         p = g_new0(struct avctp_pending_req, 1);
>         p->chan = chan;
> -       p->transaction = chan->transaction;
> +       p->transaction = chan_get_transaction(chan);
>         p->process = process;
>         p->data = data;
>         p->destroy = destroy;
>
> -       chan->transaction++;
> -       chan->transaction %= 16;
> -
>         return p;
>  }
>
> @@ -1603,6 +1615,11 @@ static int avctp_send_req(struct avctp *session, uint8_t code,
>         if (control == NULL)
>                 return -ENOTCONN;
>
> +       /* If the request set a callback send it directly */
> +       if (!func)
> +               return avctp_send(session->control, -1, AVCTP_COMMAND,
> +                               code, subunit, opcode, operands, operand_count);
> +
>         req = g_new0(struct avctp_control_req, 1);
>         req->code = code;
>         req->subunit = subunit;
> --
> 2.13.6

Applied.


-- 
Luiz Augusto von Dentz
