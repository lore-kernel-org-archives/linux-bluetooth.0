Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1283952413-22791-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1283952413-22791-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 14 Sep 2010 16:49:18 +0300
Message-ID: <AANLkTimMEnSz7wN-xpAOhUFsN78j=Qy17tJOwcGBycvr@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: remove extra newline from debug output
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Wed, Sep 8, 2010 at 4:26 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/rfcomm/core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 16b79f3..a7e4f2d 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1698,7 +1698,7 @@ static int rfcomm_recv_frame(struct rfcomm_session *s, struct sk_buff *skb)
>                break;
>
>        default:
> -               BT_ERR("Unknown packet type 0x%02x\n", type);
> +               BT_ERR("Unknown packet type 0x%02x", type);
>                break;
>        }
>        kfree_skb(skb);
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
