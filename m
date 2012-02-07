Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328625782-19624-2-git-send-email-szymon.janc@tieto.com>
References: <1328625782-19624-1-git-send-email-szymon.janc@tieto.com>
	<1328625782-19624-2-git-send-email-szymon.janc@tieto.com>
Date: Tue, 7 Feb 2012 13:26:41 -0200
Message-ID: <CAA37ikbyvL-_=SJQVaWH8ASE0_xzmTw1fgbxZCdA8qUE5qMW5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Fix double acking I-Frames when sending
 pending I-Frames
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	kanak.gupta@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Feb 7, 2012 at 12:43 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Pending I-Frame(s) are considered as acknowledgement. To void double
> acking (via I-Frame and later via RR) clear ack timer when sending
> first pending I-Frame.
>
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 5bb298d..8dece4e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1450,7 +1450,9 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
>
>                if (bt_cb(skb)->retries == 1) {
>                        chan->unacked_frames++;
> -                       nsent++;
> +
> +                       if (!nsent++)
> +                               __clear_ack_timer(chan);
>                }
>
>                chan->frames_sent++;

If Luiz confirms the patches solve the problem I'm ok with them for now. Thanks.

Best regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
