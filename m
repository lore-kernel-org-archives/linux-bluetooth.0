Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328539133-26410-1-git-send-email-luiz.dentz@gmail.com>
References: <1328539133-26410-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 6 Feb 2012 15:27:33 -0200
Message-ID: <CAA37ikb_RZixK2dYZa2YED=Z942Uu6=W92_xivNEjPAq+w7cqA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix not clearing ack timer when sending an i-frame
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Feb 6, 2012 at 12:38 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> When sending an i-frame the first time unacked_frames is incremented
> which means we are waiting an ack and there is no need to send an ack
> since the i-frame itself already serve that purpose.

I'm not sure this message is correct even though the patch makes
sense. We _might_ be acking received unacked frames by sending an
i-frame so it makes sense to clear the ack timer. However,
unacked_frames means our frames which weren't acked yet by the remote
side. Right?

> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 09cd860..e969677 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1448,8 +1448,10 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
>
>                chan->next_tx_seq = __next_seq(chan, chan->next_tx_seq);
>
> -               if (bt_cb(skb)->retries == 1)
> +               if (bt_cb(skb)->retries == 1) {
>                        chan->unacked_frames++;
> +                       __clear_ack_timer(chan);
> +               }
>
>                chan->frames_sent++;

Hmm, maybe we can clear ack timer only once if we check nsent in the
end of l2cap_ertm_send() instead of potentially call it several times?
Not sure if it's worth it or not, though.

Regards,

-- Ulisses
